#include <string>
#include <iostream>
#include <list>
#include <memory>

#include "DSE_hardware_modules.hpp"
#include "parser.hpp"
#include "analysis-structure.hpp"
#include "mapping-analysis.hpp"
#include "cost-analysis.hpp"


namespace maestro {

  std::shared_ptr<maestro::DirectiveParser> directive_parser;
  std::shared_ptr<maestro::DirectiveTable> directive_table;
  std::shared_ptr<maestro::LoopInfoTable> loop_info_table;
  std::shared_ptr<maestro::MappingAnalysis> map_analysis;
  std::shared_ptr<maestro::NetworkOnChipModel> noc_model;

  std::shared_ptr<maestro::BufferAnalysis> buff_analysis;
  std::shared_ptr<maestro::PerformanceAnalysis> perf_analysis;

  int num_pes = 1;
  int num_alus_in_pe = 1;

  std::list<std::string> input_tensors = {"weight", "input"};
  std::list<std::string> output_tensors = {"output"};
  std::list<std::string> all_tensors;


  std::list<std::string> GetTensors() {
	  return all_tensors;
  }

  std::list<std::string> GetInputTensors() {
	  return input_tensors;
  }

  std::list<std::string> GetOutputTensors() {
	  return output_tensors;
  }


  std::shared_ptr<maestro::BufferAnalysis> GetBufferAnalysis() {
  	return buff_analysis;
  }

  std::shared_ptr<maestro::NetworkOnChipModel> GetNoCModel() {
  	return noc_model;
  }

  std::shared_ptr<maestro::PerformanceAnalysis> GetPerfAnalysis() {
  	return perf_analysis;
  }

  std::shared_ptr<maestro::MappingAnalysis> GetMapAnalysis() {
  	return map_analysis;
  }


  void SetupPEs(int np, int num_alus) {
    num_pes = np;
    num_alus_in_pe = num_alus;
  }

  void SetupNoC(int bw, int hops, int hop_latency, bool mc) {
    noc_model = std::make_shared<maestro::NetworkOnChipModel>(bw, hops, hop_latency, mc);
  }

  void SetupInputTensors(std::list<std::string>& in_tensors) {
    input_tensors = in_tensors;

    for(auto& tensor : in_tensors) {
      all_tensors.push_back(tensor);
    }
  }

  void SetupOutputTensors(std::list<std::string>& out_tensors) {
    output_tensors = out_tensors;

    for(auto& tensor : out_tensors) {
      all_tensors.push_back(tensor);
    }
  }

  void ParseInputs(std::string dataflow_file_name, std::string layer_file_name) {
    maestro::DirectiveParser directive_parser(dataflow_file_name);
    directive_table = directive_parser.ParseDirectives();

    std::cout << "============ Parsed dataflow and loop ============" << std::endl;
    std::cout << directive_table->ToString() << std::endl;

    maestro::LoopParser prob_parser(layer_file_name);
    loop_info_table = prob_parser.ParseLoop();
    std::cout << loop_info_table->ToString() << std::endl;
  }

  void InitializeAnalysis() {
    map_analysis = std::make_shared<maestro::MappingAnalysis>(directive_table, loop_info_table);
    map_analysis->PreProcess(num_pes);
  }

  void ConfigureTensors() {
    std::list<std::string> weight_vars = {"K","C","R","S"} ;
    map_analysis->AddTensor("weight", weight_vars);

    std::list<std::string> input_vars = {"C","Y","X"} ;
    map_analysis->AddTensor("input", input_vars);

    std::list<std::string> output_vars = {"K","Y","X"} ;
    map_analysis->AddTensor("output", output_vars);

  }

  void AnalyzeMapping() {

    std::cout << "============ Mapping analysis ============" << std::endl;

    std::cout << "Per PE mapping size analysis" << std::endl;
    std::cout << "Num mapped weights: " << map_analysis->GetMappedSize("weight",false, false)
              << ", Num spatially mapped unique weights: " << map_analysis->GetMappedSize("weight", false, true)
              << ", Num temporally mapped unique weights " << map_analysis->GetMappedSize("weight", true, false)
              << ", Num temporally and spatially mapped unique weights " << map_analysis->GetMappedSize("weight", true, true)
              << std::endl;
    std::cout << std::endl;

    std::cout << "Num mapped inputs: " << map_analysis->GetMappedSize("input",false, false)
              << ", Num spatially mapped unique inputs: " << map_analysis->GetMappedSize("input", false, true)
              << ", Num temporally mapped unique inputs " << map_analysis->GetMappedSize("input", true, false)
              << ", Num temporally and spatially mapped unique inputs " << map_analysis->GetMappedSize("input", true, true)
              << std::endl;
    std::cout << std::endl;

    std::cout << "Num mapped outputs: " << map_analysis->GetMappedSize("output",false, false)
              << ", Num spatially mapped unique outputs: " << map_analysis->GetMappedSize("output", false, true)
              << ", Num temporally mapped unique outputs " << map_analysis->GetMappedSize("output", true, false)
              << ", Num temporally and spatially mapped unique outputs " << map_analysis->GetMappedSize("output", true, true)
              << std::endl;
    std::cout << std::endl;

    std::cout << "Spatially reduced outputs per PE in the steady state: " << map_analysis->GetMappedSize("output",false, false) - map_analysis->GetMappedSize("output", true, true) <<std::endl;
  }

  void AnalyzeBuffer(bool silent = false) {
    buff_analysis = std::make_shared<maestro::BufferAnalysis>(map_analysis, noc_model, num_pes);

    if(!silent) {

      std::cout << "============ Buffer analysis ============" << std::endl;

    	std::cout << "L1 Buffer requirement (per PE): " << buff_analysis->GetL1BufferRequiredSize(all_tensors) << " Bytes" << std::endl;
    	std::cout << "L2 Buffer requirement: " << buff_analysis->GetL2BufferRequiredSize(all_tensors) << " Bytes" << std::endl;

    	std::cout << "1. Weight" << std::endl;
    	std::cout << "  L1 Buffer Read Counts: " << buff_analysis->GetL1BufferRead("weight") << std::endl;
      std::cout << "  L1 Buffer Write Counts: " << buff_analysis->GetL1BufferWrite("weight", true, true) << std::endl;
      std::cout << "  L2 Buffer Read Counts: " << buff_analysis->GetL2BufferRead("weight", true, true) << std::endl;
      std::cout << "  L2 Buffer Write Counts: " << buff_analysis->GetL2BufferWrite("weight", true, true) << std::endl;

      std::cout << "2. Input" << std::endl;
      std::cout << "  L1 Buffer Read Counts: " << buff_analysis->GetL1BufferRead("input") << std::endl;
      std::cout << "  L1 Buffer Write Counts: " << buff_analysis->GetL1BufferWrite("input", true, true) << std::endl;
      std::cout << "  L2 Buffer Read Counts: " << buff_analysis->GetL2BufferRead("input", true, true) << std::endl;
      std::cout << "  L2 Buffer Write Counts: " << buff_analysis->GetL2BufferWrite("input", true, true) << std::endl;

      std::cout << "3. Output" << std::endl;
      std::cout << "  L1 Buffer Read Counts: " << buff_analysis->GetL1BufferRead("output") << std::endl;
      std::cout << "  L1 Buffer Write Counts: " << buff_analysis->GetL1BufferWrite("output", true, true) << std::endl;
      std::cout << "  L2 Buffer Read Counts: " << buff_analysis->GetL2BufferRead("output", true, true) << std::endl;
      std::cout << "  L2 Buffer Write Counts: " << buff_analysis->GetL2BufferWrite("output", true, true) << std::endl;

      std::cout << std::endl;

    }
  }

  void AnalyzeNoC(bool silent = false) {
    long bandwidth_requirement = perf_analysis->GetNoCBandwidthRequirement(input_tensors, output_tensors, num_pes, num_alus_in_pe);
    long compute_delay = perf_analysis->GetComputeDelay(input_tensors, num_alus_in_pe);

    if(!silent) {
      std::cout << "============ NoC analysis ============" << std::endl;
      std::cout << "Peak bandwidth requirement: " << bandwidth_requirement << "Bytes per cycle" << std::endl;
      std::cout << "Average bandwidth requirement: " << bandwidth_requirement/compute_delay << "Bytes per cycle" << std::endl;

      std::cout << std::endl;
    }

  }

  double AnalyzeEnergyDSE() {
    double energy_consumption_ = 0.0;

    double l1_energy = 0.0;

    l1_energy += buff_analysis->GetL1BufferRead("weight");
    l1_energy += buff_analysis->GetL1BufferRead("input");
    l1_energy += buff_analysis->GetL1BufferRead("output");

    l1_energy += buff_analysis->GetL1BufferWrite("weight", true, true);
    l1_energy += buff_analysis->GetL1BufferWrite("input", true, true);
    l1_energy += buff_analysis->GetL1BufferWrite("output", true, true);

    l1_energy *= 2.91;

    double l2_energy = 0.0;

    l2_energy += buff_analysis->GetL2BufferRead("weight");
    l2_energy += buff_analysis->GetL2BufferRead("input");
    l2_energy += buff_analysis->GetL2BufferRead("output");

    l2_energy += buff_analysis->GetL2BufferWrite("weight", true, true);
    l2_energy += buff_analysis->GetL2BufferWrite("input", true, true);
    l2_energy += buff_analysis->GetL2BufferWrite("output", true, true);

    l2_energy *= 32.2;

    return l1_energy + l2_energy;
  }

  double AnalyzeL1BuffReq_DSE() {
  	return buff_analysis->GetL1BufferRequiredSize(all_tensors);
  }

  double AnalyzeL2BuffReq_DSE() {
  	return buff_analysis->GetL2BufferRequiredSize(all_tensors);
  }

  long AnalyzeRuntime_DSE(int num_alus_per_pe = 1, bool do_reduction = true, bool do_implicit_reduction = true, bool fg_sync = false, bool latency_hiding = true) {
    perf_analysis = std::make_shared<maestro::PerformanceAnalysis> (map_analysis, buff_analysis, noc_model, do_reduction, do_implicit_reduction, fg_sync);
    long runtime = perf_analysis->GetRunTime (input_tensors, output_tensors, num_pes, num_alus_per_pe, latency_hiding);

    return runtime;
  }

  void AnalyzeRuntime(bool do_reduction = true, bool do_implicit_reduction = true, bool fg_sync = false, bool latency_hiding = true) {
    perf_analysis = std::make_shared<maestro::PerformanceAnalysis> (map_analysis, buff_analysis, noc_model, do_reduction, do_implicit_reduction, fg_sync);

    std::cout << "============ Performance analysis ============" << std::endl;

    long runtime = perf_analysis->GetRunTime (input_tensors, output_tensors, num_pes, num_alus_in_pe, latency_hiding);
    std::cout << "Total Runtime: " << runtime << " cycles" << std::endl;
    std::cout << std::endl;
  }

  void AnalyzeEnergy() {
    double energy = AnalyzeEnergyDSE();
    std::cout << "============ Energy analysis ============" << std::endl;

    std::cout << "Estimated energy: " << energy/1.61 << " times MAC energy" << std::endl;
    std::cout << std::endl;
  }

  /* Analyze Hardware Cost
   *
   * Returns true only when the tested hardware configuration satisfies constraints.
   *
   */
  bool AnalyzeHardwareCost(double area_constraints = 40000, double power_constraints=2000, int l1_size=8, int l2_size=64) {
    bool success = true;
    int bw = noc_model->GetBandwidth();
    int estimated_l1_size = buff_analysis->GetL1BufferRequiredSize(all_tensors);
    int estimated_l2_size = buff_analysis->GetL2BufferRequiredSize(all_tensors);

    std::cout << "============ Hardware cost analysis ============" << std::endl;

    if(estimated_l1_size > l1_size) {
      std::cout << "[MAESTRO] Warning: L1 buffer requirement is " << estimated_l1_size << " Bytes, but you have only " << l1_size << "-Byte L1 buffer." << std::endl;
      success = false;
    }

    if(estimated_l2_size > l2_size) {
      std::cout << "[MAESTRO] Warning: L2 buffer requirement is " << estimated_l2_size << " Bytes, but you have only " << l2_size << "-Byte L2 buffer." << std::endl;
      success = false;
    }

    std::shared_ptr<maestro::DSE::Accelerator> accelerator = std::make_shared<maestro::DSE::Accelerator>(num_pes, num_alus_in_pe, bw, l1_size, l2_size);

    double estimated_area = accelerator->GetArea();
    double estimated_power = accelerator->GetPower();

    if(estimated_area > area_constraints) {
      std::cout << "[MAESTRO] Warning: Your design requires " << estimated_area << " um^2 of area but the area constraint is "  << area_constraints << " mm^2." << std::endl;
      success = false;
    }

    if(estimated_power > power_constraints) {
      std::cout << "[MAESTRO] Warning: Your design requires " << estimated_power << " mW of power but the area constraint is "  << power_constraints << " mm^2." << std::endl;
      success = false;
    }

    std::cout << "Estimated Area: " << estimated_area << " um^2" << std::endl;
    std::cout << "Estimated Power: " << estimated_area << "Wo mW" << std::endl;

    return success;
  }

} //End of namespace maestro
