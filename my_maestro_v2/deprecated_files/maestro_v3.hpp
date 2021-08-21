#ifndef MAESTRO_V3_HPP_
#define MAESTRO_V3_HPP_

#include <memory>
#include <vector>
#include <list>

#include "../lib/include/abstract-hardware-model/AHW_noc-model.hpp"
#include "DFA_tensor.hpp"


namespace maestro {
  void Initialize();
  void SetParameters(int num_pes);
  void ParseDFSL(std::string dfsl_file_name, bool verbose = true);
  void AddTensor(std::string tensor_name,
                 DFA::TensorClass tensor_class,
                 DataClass data_class,
                 std::list<std::string>& correlated_vars);
  void InitializeNumSIMDLanes(std::shared_ptr<std::vector<int>> usr_num_simd_lanes = nullptr);
  void SetNoCs(std::shared_ptr<std::vector<std::shared_ptr<AHW::NetworkOnChipModel>>> nocs);
  void AnalyzeClusters(int layerID);
  void AnalyzeCostAllClusters(bool show_all_cluster_results = true);
  void AnalyzeCostSingleCluster(int lv=0, int lvs=1, bool verbose=true);
}; // End of namespace maestro

#endif
