#ifndef MAESTRO_MAESTRO_HPP_
#define MAESTRO_MAESTRO_HPP_

#include <string>
#include <iostream>
#include <list>
#include <memory>

#include "analysis-structure.hpp"
#include "mapping-analysis.hpp"
#include "cost-analysis.hpp"

namespace maestro {

  void SetupPEs(int np, int num_alus);
  void SetupNoC(int bw, int hops, int hop_latency, bool mc);
  void SetupInputTensors(std::list<std::string>& in_tensors);
  void SetupOutputTensors(std::list<std::string>& out_tensors);
  void ParseInputs(std::string dataflow_file_name, std::string layer_file_name);
  void InitializeAnalysis();
  void ConfigureTensors();
  void AnalyzeMapping();
  void AnalyzeBuffer(bool silent = false);
  void AnalyzeNoC(bool silent = false);
  void AnalyzeRuntime(bool do_reduction = true, bool do_implicit_reduction = true, bool fg_sync = false, bool latency_hiding = true);
  void AnalyzeEnergy();
  bool AnalyzeHardwareCost(double area_constraints = 40000, double power_constraints=2000, int l1_size=8, int l2_size=64);


  double AnalyzeL1BuffReq_DSE();
  double AnalyzeL2BuffReq_DSE();
  double AnalyzeEnergyDSE();
  long AnalyzeRuntime_DSE(int num_alus_per_pe = 1, bool do_reduction = true, bool do_implicit_reduction = true, bool fg_sync = false, bool latency_hiding = true);

  std::list<std::string> GetTensors();
  std::list<std::string> GetInputTensors();
  std::list<std::string> GetOutputTensors();

  std::shared_ptr<maestro::BufferAnalysis> GetBufferAnalysis();
  std::shared_ptr<maestro::NetworkOnChipModel> GetNoCModel();
  std::shared_ptr<maestro::PerformanceAnalysis> GetPerfAnalysis();
  std::shared_ptr<maestro::MappingAnalysis> GetMapAnalysis();

}; //End of namespace maestro

#endif
