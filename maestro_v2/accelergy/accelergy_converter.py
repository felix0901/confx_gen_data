################################################################################
# Copyright (c) 2020 Georgia Instititue of Technology
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Author : Matthew Denton (matthewdenton@gatech.edu)
#
#
# Please note this conversion software is in beta and not fully validated
# Many assumptions are made which are stated in the code comments
# This is considered more accurate than the maestro baseline energy estimates
# You will need Accelergy (http://accelergy.mit.edu/)
################################################################################
import matplotlib.pyplot as plt
import csv
import pandas as pd
import yaml
import re
import copy
import math
import sys
import argparse
import os
import warnings

def dcopy(x): return copy.deepcopy(x)

def readArch(archFile):
    stream = open(archFile, 'r')
    y = yaml.load(stream, Loader=yaml.FullLoader)

    for _, doc in y.items():
        subtree = doc["subtree"]
        name = subtree[0]["name"]
        local = subtree[0]["local"]

        lNames = []
        for l in local:
            lName = name + "." + l["name"]
            lNames.append(lName)

        subsubtree = subtree[0]["subtree"]
        subname = subsubtree[0]["name"]
        assert "PE" in subname, "Yaml must list PE's"
        numRange = re.findall(r'\d+', subname)
        assert len(numRange) == 2, "Yaml must provide starting and ending index of PE array"
        numPe = int(numRange[1]) - int(numRange[0]) + 1
        
        locallocal = subsubtree[0]["local"]

        for l in locallocal:
            lName = name + ".PE[%]." + l["name"]
            lNames.append(lName)

        return numPe, lNames


def generateCounts(arch, layerFile):
    numPe, lNames = arch

    localTemplate = {'action_counts': {"local" : [], "version" : 0.2}}
    subLocalTemplate = {'action_counts' : [], "name": None}
    memArgTemplate = {"arguments" : {"address_delta": 1, "data_delta" : 1}, \
                        "counts" : 0, "name": None}

    macTemplate = {'counts' : 0, 'name' : None} # idle, mac_gated, mac_random, mac_reused
    nocXYTemplate =  {"arguments" : {"n_cols_per_row": 1, "n_rows" : 1}, \
                        "counts" : 0, "name": None}

    # TODO
    # Noc, idle, L0, sparsity, address and data delta, utilization
    
    L1, L2, numPeMaestro, utilization, numMacs = countAccesses(layerFile)
    assert numPeMaestro == numPe, "Number of PEs in Arch description({}) does not match MAESTRO({})".format(numPe, numPeMaestro)
    numPe = numPeMaestro

    thisYaml = dcopy(localTemplate)
    for l in lNames:
        if "glb" in l: #L2 in MAESTRO
            curSubEntry = dcopy(subLocalTemplate)
            if "weights" in l: #filter in MAESTRO
                read_counts = int(L2[1][0])
                write_counts = int(L2[1][1])
    
            elif "shared" in l: #input, output
                read_counts = int(L2[0][0]) + int(L2[2][0])
                write_counts = int(L2[0][1]) +  int(L2[2][1])

            else: assert False
                
            curWriteEntry = dcopy(memArgTemplate)
            curWriteEntry["counts"] = write_counts
            curWriteEntry["name"] = "fill" # assume all fills for now

            curReadEntry = dcopy(memArgTemplate)
            curReadEntry["counts"] = read_counts
            curReadEntry["name"] = "read" # assume all reads for now

            curSubEntry["name"] = l
            curSubEntry["action_counts"].extend([curWriteEntry, curReadEntry])
            thisYaml["action_counts"]["local"].append(curSubEntry)

        elif "PE" in l and "spad" in l: #L1 in MAESTRO
            if "ifmap" in l:
                idx = 0
                assert "weights" not in l and "psum" not in l 
            elif "weights" in l:
                idx = 1
                assert "psum" not in l
            elif "psum" in l:
                idx = 2
            else: assert False, "R/W location not clear {}".format(l)

            read_counts = int(math.ceil(L1[idx][0] / numPe)) #assume uniform PE accesses
            write_counts = int(math.ceil((L1[idx][1]) / numPe))
            for p in range(numPe):
                curSubEntry = dcopy(subLocalTemplate)
                curWriteEntry = dcopy(memArgTemplate)
                curWriteEntry["counts"] = write_counts
                curWriteEntry["name"] = "fill" # assume all fills for now

                curReadEntry = dcopy(memArgTemplate)
                curReadEntry["counts"] = read_counts
                curReadEntry["name"] = "read" 

                curSubEntry["name"] = l.replace("%", str(p))
                curSubEntry["action_counts"].extend([curWriteEntry, curReadEntry])
                thisYaml["action_counts"]["local"].append(curSubEntry)

        elif "mac" in l:
            #assume no gated macs for now - but we can model idle with utilization
            mac_counts = int(math.ceil(numMacs / numPe)) #assume uniform PE accesses

            #idle_counts = active_cycles/utilization - active_cycles
            #ignore idles for now

            for p in range(numPe):
                curSubEntry = dcopy(subLocalTemplate)
                curMacRandEntry = dcopy(macTemplate)
                curMacRandEntry["counts"] = mac_counts
                curMacRandEntry["name"] = "mac_random" # assume all random

                curSubEntry["name"] = l.replace("%", str(p))
                curSubEntry["action_counts"].append(curMacRandEntry)
                thisYaml["action_counts"]["local"].append(curSubEntry)

        elif "NoC" in l:
            if "ifmap" in l:
                counts = int(L2[0][0]) #total input reads
            elif "weights" in l:
                counts = int(L2[1][0])#total weight reads from glb
            elif "psum_read" in l:
                counts = int(L2[2][0]) # total ofmaps reads
            elif "psum_write" in l:
                counts = int(L2[2][1]) # ofmap writes
            else: assert False, "NoC not specified {}".format(l)

            n_cols_per_row = 14
            cols = n_cols_per_row
            rows = 1 #assume for now

            curSubEntry = dcopy(subLocalTemplate)
            curNocXYEntry = dcopy(nocXYTemplate)

            curNocXYEntry["counts"] = counts
            curNocXYEntry["name"] = "transfer_random"
            curNocXYEntry["arguments"]["n_cols_per_row"] = cols
            curNocXYEntry["arguments"]["n_rows"] = rows

            curSubEntry["name"] = l
            curSubEntry["action_counts"].append(curNocXYEntry)
            thisYaml["action_counts"]["local"].append(curSubEntry)


        else: assert False, "Unknown identfier: {}".format(l)


    return thisYaml
        


def countAccesses(layerF = "Acc_test.csv"):
    df = pd.read_csv(layerF)
   
    #power = [' L1 power', ' L2 power', ' NOC power'] 
    L1_input = [' input l1 read', ' input l1 write']
    L2_input = [' input l2 read',' input l2 write']
    #input_reuse = [' input reuse factor']
    L1_filter = ['filter l1 read', ' filter l1 write'] #doesn't have space in key (notice space in others)
    L2_filter = [' filter l2 read', ' filter l2 write'] 
    #filter_reuse = [' filter reuse factor']
    L1_output = ['output l1 read', ' output l1 write'] #no space
    L2_output = [' output l2 read', ' output l2 write'] 
    #output_reuse = [' output reuse factor']

    numPE = ' NumPEs'
    avgUtilPe = 'Avg number of utilized PEs'

    df = df.astype({avgUtilPe: float})
    df.fillna(0)

    numMacs = ' Num MACs'

    #L0 = []
    L1 = [L1_input, L1_filter, L1_output]
    L2 = [L2_input, L2_filter, L2_output]

    
    #convert dataframe names to values
    for l in L1:
        l[0] = df[l[0]].sum() #lookup, then reduce sums of reads, writes, etc
        l[1] = df[l[1]].sum()

    for l in L2:
        l[0] = df[l[0]].sum() #lookup, then reduce sums of reads, writes, etc
        l[1] = df[l[1]].sum()

    if df[avgUtilPe].sum() == 0:
        util = 0
    else:
        util = (df[avgUtilPe].sum() / df[numPE].sum()).astype(float)

    assert df[numPE].value_counts().nunique() == 1, "Number of PEs must be same for all Maestro entries" 
    numPE = df[numPE][0].astype(int)

    numMacs = df[numMacs].sum().astype(int)

    return L1, L2, numPE, util, numMacs

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description='Converts Maestro output to be used as Accelergy action counts')
    parser.add_argument('input_file', help='Maestro file to be converted')
    parser.add_argument('output_file', help='Accelergy Yaml output file')
    parser.add_argument('arch_file', help='Accelergy architecture description - should match Maestro description')

    args = parser.parse_args()
    layerFile = args.input_file
    outFile = args.output_file
    archFile = args.arch_file

    
    #Basic file name error checking
    assert layerFile.endswith('.csv') and os.path.exists(layerFile), "Maestro filename invalid or does not exist"
    assert archFile.endswith('.yaml') and os.path.exists(archFile), "Accelergy arch file does not exists or is not .yaml"
    assert outFile.endswith('.yaml'), "Output file must be yaml"
    if os.path.exists(outFile): warnings.warn("Overwriting old output file with given name")
    
    arch = readArch(archFile)
    yamlGen = generateCounts(arch, layerFile)


    with open(outFile, 'w') as outfile:
        noalias_dumper = yaml.dumper.SafeDumper
        noalias_dumper.ignore_aliases = lambda self, data: True
        yaml.dump(yamlGen, outfile, Dumper=noalias_dumper) #default_flow_style=False)
        
   