/******************************************************************************
Copyright (c) 2019 Georgia Instititue of Technology
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Author : Hyoukjun Kwon (hyoukjun@gatech.edu)
*******************************************************************************/


#ifndef MAESTRO_DFSL_HW_PARSER_HPP_
#define MAESTRO_DFSL_HW_PARSER_HPP_

#include <string>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <memory>
#include <map>
#include <vector>

#include<boost/tokenizer.hpp>
#include<boost/format.hpp>

#include "../abstract-hardware-model/AHW_accelerator.hpp"
#include "../abstract-hardware-model/AHW_PE-cluster.hpp"
#include "AHW_hw-options.hpp"
#include "DFSL_syntax_tokens.hpp"
#include "DFSL_parser.hpp"



namespace maestro {
  namespace DFSL {

    //Indentation shows the structure of the state machine in HWParser.
    enum class HWParserState {Idle,
                              Accelerator_Identifier,
                              Accelerator_Name,
                              Accelerator_Body,
                                ComputeCluster_Identifier,
                                ComputeCluster_Name,
                                ComputeCluster_Body,
                                  Level_Identifier,
                                  ClusterCount_Identifier,
                                  ClusterSize_Identifier,
                                  Buffer_Identifier,
                                    Buffer_Name,
                                    Buffer_Body,
                                    Buffer_Tensor_Identifier,
                                    BufferType_Identifier,
                                    BufferSize_Identifer,
                                  NoC_Identifer,
                                    NoC_Name,
                                    NoC_Type,
                                    NoC_Body,
                                    NoC_Tensor,
                                    NoC_Bandwidth,
                                    NoC_Hops,
                                    NoC_LatencyPerHops,
                                 Redc_NoC_Identifier,
                                   Redc_NoC_Name,
                                   Redc_NoC_Body,
                                   Redc_NoC_Type,
                                   Redc_NoC_Bandwidth,
                                   Redc_NoC_Hops,
                                   Redc_NoC_LatencyPerHops
                           };

    class HWParser : public InputParser {
      public:
        HWParser(std::string file_name) : InputParser(file_name) {
        }

        std::shared_ptr<AHW::AbstractAccelerator> ParseHW() {
          std::string line;
          boost::char_separator<char> sep(" ,->():\t;");
          int line_number = 1;

//          std::shared_ptr<std::map<std::string, int>> constant_map = std::make_shared<std::map<std::string, int>>();

          int num_pes = 1;
          int cluster_count = 1;
          int cluster_level;
          int cluster_size;
          int buffer_size;
          int pe_vector_width = 1;

          int noc_hops = 1;
          int noc_delay_per_hop = 1;
          int noc_bandwidth = 1;

          AHW::Buffer_options buffer_option;
          AHW::NoC_options dist_noc_option;
          AHW::Redudction_options redc_noc_option;

          std::string accelerator_name;
          std::string cluster_name;
          std::string buffer_name;
          std::string noc_name;
          std::string redc_noc_name;
          std::string target_tensor = "Tensor";

          std::shared_ptr<AHW::PECluster> top_pe_cluster = nullptr;
          std::shared_ptr<AHW::PECluster> prev_pe_cluster = nullptr;
          std::shared_ptr<AHW::PECluster> pe_cluster = nullptr;

          while(std::getline(in_file_, line)) {
            boost::tokenizer<boost::char_separator<char>> tokn(line, sep);
            for(auto &tkn : tokn) {

              if(tkn.size() >= 2 && tkn.substr(0,2) == DFSL::comments_) {
                line_number++;
                break;
              }

              switch(state_) {
                case HWParserState::Idle: {
                  if(tkn == DFSL::accelerator_decl_) {
                    state_ = HWParserState::Accelerator_Identifier;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::Accelerator_Identifier: {
                  accelerator_name = tkn;
                  state_ = HWParserState::Accelerator_Name;
                  break;
                }

                case HWParserState::Accelerator_Name: {
                  if(tkn == DFSL::brace_open_) {
                    state_ = HWParserState::Accelerator_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::Accelerator_Body: {
                  if(tkn == DFSL::compute_cluster_decl_) {
                    state_ = HWParserState::ComputeCluster_Identifier;
                  }
                  else if (tkn == DFSL::brace_close_) {
                    state_ = HWParserState::Idle;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::ComputeCluster_Identifier: {
                  cluster_name = tkn;

                  pe_cluster = std::make_shared<AHW::PECluster>(cluster_name);

                  state_ = HWParserState::ComputeCluster_Name;
                  break;
                }

                case HWParserState::ComputeCluster_Name: {
                  if(tkn == DFSL::brace_open_) {
                    state_ = HWParserState::ComputeCluster_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::ComputeCluster_Body: {
                  if(tkn == DFSL::compute_cluster_level_decl_) {
                    state_ = HWParserState::Level_Identifier;
                  }
                  else if(tkn == DFSL::compute_cluster_size_decl_) {
                    state_ = HWParserState::ClusterSize_Identifier;
                  }
                  else if(tkn == DFSL::compute_cluster_counts_) {
                    state_ = HWParserState::ClusterCount_Identifier;
                  }
                  else if(tkn == DFSL::buffer_decl_) {
                    state_ = HWParserState::Buffer_Identifier;
                  }
                  else if(tkn == DFSL::noc_decl_) {
                    state_ = HWParserState::NoC_Identifer;
                  }
                  else if (tkn == DFSL::redc_noc_decl_) {
                    state_ = HWParserState::Redc_NoC_Identifier;
                  }
                  else if (tkn == DFSL::brace_close_) {

                    if(top_pe_cluster == nullptr) {
                      top_pe_cluster = pe_cluster;
                    }
                    else {
                      prev_pe_cluster->SetSubCluster(pe_cluster);
                    }
                    prev_pe_cluster = pe_cluster;

                    state_ = HWParserState::Accelerator_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::Redc_NoC_Identifier: {
                  redc_noc_name = tkn;
                  state_ = HWParserState::Redc_NoC_Name;
                 break;
                }

                case HWParserState::Redc_NoC_Name: {
                  if (tkn == DFSL::brace_open_) {
                    state_ = HWParserState::Redc_NoC_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                 break;
                }

                case HWParserState::Redc_NoC_Body: {
                  if (tkn == DFSL::noc_type_decl_) {
                    state_ = HWParserState::Redc_NoC_Type;
                  }
                  else if(tkn == DFSL::noc_bandwidth_decl_) {
                    state_ = HWParserState::Redc_NoC_Bandwidth;
                  }
                  else if(tkn == DFSL::noc_latency_per_hop_decl_) {
                    state_ = HWParserState::Redc_NoC_LatencyPerHops;
                  }
                  else if(tkn == DFSL::noc_avg_num_hops_decl_) {
                    state_ = HWParserState::Redc_NoC_Hops;
                  }
                  else if (tkn == DFSL::brace_close_) {

                    auto redc_noc = std::make_shared<AHW::ReductionNoC> (
                        redc_noc_option, cluster_size, noc_bandwidth, noc_hops, noc_delay_per_hop, redc_noc_name) ;

                    noc_bandwidth = 1;
                    noc_hops = 1;
                    noc_delay_per_hop = 1;

                    pe_cluster->AddRedcNoC(redc_noc);

                    state_ = HWParserState::ComputeCluster_Body;
                  }

                  break;
                }

                case HWParserState::Redc_NoC_Type: {
                  if(tkn == DFSL::redc_noc_type_adder_tree_) {
                    redc_noc_option = AHW::Redudction_options::FullSpatial;
                  }
                  else if(tkn == DFSL::redc_noc_type_systolic_) {
                    redc_noc_option = AHW::Redudction_options::Systolic;
                  }
                  else {
                    redc_noc_option = AHW::Redudction_options::Temporal;
                  }

                  state_ = HWParserState::Redc_NoC_Body;
                  break;
                }


                case HWParserState::Redc_NoC_Bandwidth: {
                  noc_bandwidth = std::atoi(tkn.c_str());

                  if(noc_bandwidth < 1) {
                    ParseError(line_number);
                  }

                  state_ = HWParserState::Redc_NoC_Body;
                  break;
                }

                case HWParserState::Redc_NoC_LatencyPerHops: {
                  noc_delay_per_hop = std::atoi(tkn.c_str());

                  if(noc_delay_per_hop < 1) {
                    ParseError(line_number);
                  }

                  state_ = HWParserState::Redc_NoC_Body;
                  break;
                }

                case HWParserState::Redc_NoC_Hops: {
                  noc_hops = std::atoi(tkn.c_str());

                  if(noc_hops < 1) {
                    ParseError(line_number);
                  }

                  state_ = HWParserState::Redc_NoC_Body;
                  break;
                }

                case HWParserState::Level_Identifier: {
                  cluster_level = std::atoi(tkn.c_str());

                  if(cluster_level < 0) {
                    ParseError(line_number);
                  }

                  pe_cluster->SetLevel(cluster_level);

                  state_ = HWParserState::ComputeCluster_Body;
                  break;
                }

                case HWParserState::ClusterCount_Identifier: {
                  cluster_count = std::atoi(tkn.c_str());

                  if(cluster_count < 0) {
                    ParseError(line_number);
                  }

                  pe_cluster->SetNumInstances(cluster_count);

                  state_ = HWParserState::ComputeCluster_Body;
                  break;
                }

                case HWParserState::ClusterSize_Identifier: {
                  cluster_size = std::atoi(tkn.c_str());

                  if(cluster_size < 0) {
                    ParseError(line_number);
                  }

                  pe_cluster->SetSize(cluster_size);

                  state_ = HWParserState::ComputeCluster_Body;
                  break;
                }

                case HWParserState::Buffer_Identifier: {
                  buffer_name = tkn;
                  state_ = HWParserState::Buffer_Name;
                  break;
                }

                case HWParserState::Buffer_Name: {
                  if(tkn == DFSL::brace_open_) {
                    state_ = HWParserState::Buffer_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::Buffer_Body: {
                  if(tkn == DFSL::buffer_size_decl_) {
                    state_ = HWParserState::BufferSize_Identifer;
                  }
                  else if(tkn == DFSL::buffer_type_decl_) {
                    state_ = HWParserState::BufferType_Identifier;
                  }
                  else if(tkn == DFSL::buffer_tensor_decl_) {
                    state_ = HWParserState::Buffer_Tensor_Identifier;
                  }
                  else if (tkn == DFSL::brace_close_) {

                    auto buffer = std::make_shared<AHW::Buffer>(buffer_option,
                        buffer_size, target_tensor, buffer_name);

                    pe_cluster->AddBuffer(buffer);

                    buffer_size = 1;
                    target_tensor = "Tensor";

                    state_ = HWParserState::ComputeCluster_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::Buffer_Tensor_Identifier: {
                  target_tensor =tkn;

                  state_ = HWParserState::Buffer_Body;
                  break;
                }

                case HWParserState::BufferSize_Identifer: {
                  buffer_size = std::atoi(tkn.c_str());

                  if(buffer_size < 1) {
                    ParseError(line_number);
                  }

                  state_ = HWParserState::Buffer_Body;
                  break;
                }


                case HWParserState::BufferType_Identifier: {
                  if(tkn == DFSL::buffer_type_fifo_) {
                    buffer_option = AHW::Buffer_options::FIFO;
                  }
                  else if (tkn == DFSL::buffer_type_circular_fifo_) {
                    buffer_option = AHW::Buffer_options::CFIFO;
                  }
                  else if (tkn == DFSL::buffer_type_scratchpad_) {
                    buffer_option = AHW::Buffer_options::ScratchPad;
                  }
                  else if (tkn == DFSL::buffer_type_buffet_) {
                    buffer_option = AHW::Buffer_options::Buffet;
                  }
                  else {
                    ParseError(line_number);
                  }

                  state_ = HWParserState::Buffer_Body;
                  break;
                }

                case HWParserState::NoC_Identifer: {
                  noc_name = tkn;
                  state_ = HWParserState::NoC_Name;
                  break;
                }

                case HWParserState::NoC_Name: {
                  if(tkn == DFSL::brace_open_) {
                    state_ = HWParserState::NoC_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }


                case HWParserState::NoC_Body: {

                  if(tkn == DFSL::noc_type_decl_) {
                    state_ = HWParserState::NoC_Type;
                  }
                  else if(tkn == DFSL::noc_latency_per_hop_decl_) {
                    state_ = HWParserState::NoC_LatencyPerHops;
                  }
                  else if(tkn == DFSL::noc_avg_num_hops_decl_) {
                    state_ = HWParserState::NoC_Hops;
                  }
                  else if(tkn == DFSL::noc_bandwidth_decl_) {
                    state_ = HWParserState::NoC_Bandwidth;
                  }
                  else if(tkn == DFSL::noc_tensor_decl_) {
                    state_ = HWParserState::NoC_Tensor;
                  }
                  else if(tkn == DFSL::brace_close_) {
                    auto dist_noc = std::make_shared<AHW::DistributionNoC>(
                        dist_noc_option,
                        cluster_size,
                        noc_bandwidth,
                        noc_hops,
                        noc_delay_per_hop,
                        target_tensor,
                        noc_name);

                    pe_cluster->AddDistNoC(dist_noc);

                    //Reset to default parameters
                    noc_hops = 1;
                    noc_delay_per_hop = 1;
                    noc_bandwidth = 1;
                    noc_name = "NoC";
                    target_tensor = "Tensor";

                    state_ = HWParserState::ComputeCluster_Body;
                  }
                  else {
                    ParseError(line_number);
                  }
                  break;
                }

                case HWParserState::NoC_Type: {
                  if(tkn == DFSL::dist_noc_type_bus_) {
                    dist_noc_option = AHW::NoC_options::Bus ;
                  }
                  else if(tkn == DFSL::dist_noc_type_tree_) {
                    dist_noc_option = AHW::NoC_options::Tree ;
                  }
                  else if(tkn == DFSL::dist_noc_type_crossbar_) {
                    dist_noc_option = AHW::NoC_options::Crossbar ;
                  }
                  else if(tkn == DFSL::dist_noc_type_systolic_) {
                    dist_noc_option = AHW::NoC_options::Systolic ;
                  }
                  else if(tkn == DFSL::dist_noc_type_mesh_) {
                    dist_noc_option = AHW::NoC_options::Mesh ;
                  }
                  else {
                    ParseError(line_number);
                  }
                  state_ = HWParserState::NoC_Body;
                  break;
                }

                case HWParserState::NoC_Bandwidth: {
                  noc_bandwidth = std::atoi(tkn.c_str());

                  if(noc_bandwidth < 1) {
                    ParseError(line_number);
                  }

                  state_ = HWParserState::NoC_Body;
                  break;
                }

                case HWParserState::NoC_Tensor: {
                  target_tensor = tkn;

                  state_ = HWParserState::NoC_Body;
                  break;
                }

                case HWParserState::NoC_LatencyPerHops: {
                  noc_delay_per_hop = std::atoi(tkn.c_str());
                  if(noc_delay_per_hop < 1) {
                    ParseError(line_number);
                  }
                  state_ = HWParserState::NoC_Body;
                  break;
                }

                case HWParserState::NoC_Hops: {
                  noc_hops = std::atoi(tkn.c_str());
                  if(noc_hops < 1) {
                    ParseError(line_number);
                  }
                  state_ = HWParserState::NoC_Body;
                  break;
                }



                default: {
                  ParseError(line_number);
                  break;
                }
              } // End of switch(state_)
            } // End of for(tkn)

            line_number++;

          } // End of while(getline(...))

          if(state_ != HWParserState::Idle) {
            ParseError(line_number);
          }

          std::shared_ptr<AHW::AbstractAccelerator> ret = std::make_shared<AHW::AbstractAccelerator>(accelerator_name);
          ret->SetTopCluster(top_pe_cluster);

          return ret;

        } // End of ParseHW

      protected:
        HWParserState state_ = HWParserState::Idle;

        std::vector<std::string> buffer_name_;
        std::vector<int> buffer_sizes_;
        std::vector<std::string> noc_name_;
        std::vector<int> noc_bandwidth_;
        std::vector<int> noc_latency_;



    };
  }; // End of namespace DFSL
}; // End of namespace maestro

#endif
