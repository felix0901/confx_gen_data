#include <memory>
#include <vector>

#include "BASE_constants.hpp"

#include "DFSL_parser.hpp"
#include "DFA_neural-network.hpp"

#include "DFA_tensor.hpp"
#include "DFA_tensor-table.hpp"

#include "DFA_cluster-analysis.hpp"
#include "DFA_cluster-unit.hpp"

#include "DSE_design_point.hpp"
#include "DSE_engine.hpp"

#include "CA_cost-analysis-engine.hpp"
#include "CA_cost-analysis-results.hpp"

namespace maestro {

  std::shared_ptr<DFA::NeuralNetwork> network_;
  std::shared_ptr<DFA::TensorTable> tensors_;
  std::shared_ptr<DFA::ClusterAnalysis> cluster_analysis_;

  std::vector<int> num_simd_lanes_;
  std::shared_ptr<std::vector<std::shared_ptr<AHW::NetworkOnChipModel>>> nocs_;
  long num_macs_;

  int num_pes_;

  void Initialize() {
    tensors_ = std::make_shared<DFA::TensorTable>();
  }

  void SetParameters(int num_pes) {
    num_pes_ = num_pes;
  }

  void ParseDFSL(std::string dfsl_file_name, bool verbose = true)
  {
    DFSL::DFSLParser dfsl_parser(dfsl_file_name);
    network_ = std::make_shared<DFA::NeuralNetwork>();
    dfsl_parser.ParseDFSL(network_);

    if(verbose) {
      std::cout << "Parsing finished" << std::endl;
      std::cout <<"Network name:" << network_->GetName() << std::endl;

      for(auto& layer: *network_) {
        std::cout << layer->ToString() << std::endl;
      }
    }
  }

  void AddTensor(std::string tensor_name,
                 DFA::TensorClass tensor_class,
                 DataClass data_class,
                 std::list<std::string>& correlated_vars) {
    std::shared_ptr<std::list<std::string>> corr_vars_to_be_added = std::make_shared<std::list<std::string>>();

    for(auto var : correlated_vars) {
      corr_vars_to_be_added->push_back(var);
    }

    std::shared_ptr<DFA::Tensor> new_tensor = std::make_shared<DFA::Tensor>(tensor_name, tensor_class, data_class, corr_vars_to_be_added);
    tensors_->AddTensor(new_tensor);

    std::cout <<"Tensor Addition done for tensor " << tensor_name <<std::endl;
  }

  void SetNoCs(std::shared_ptr<std::vector<std::shared_ptr<AHW::NetworkOnChipModel>>> nocs) {
    nocs_ = nocs;

    std::cout <<"Noc Setup is done" << std::endl;
    std::cout << std::endl;
  }

  void InitializeNumSIMDLanes(std::shared_ptr<std::vector<int>> usr_num_simd_lanes = nullptr) {
    int lvs = cluster_analysis_->GetClusters()->size();
    for(int idx = 0; idx < lvs; idx ++) {
      if(usr_num_simd_lanes != nullptr && idx < usr_num_simd_lanes->size()) {
        num_simd_lanes_.push_back(usr_num_simd_lanes->at(idx));
      }
      else {
        num_simd_lanes_.push_back(1);
      }
    }
  }



  //Output centric -> input centric
  std::shared_ptr<DFA::DimensionTable> ConstructDimensionTable(std::shared_ptr<std::vector<std::shared_ptr<DFA::LayerDimension>>> dimensions) {
    auto dimension_table = std::make_shared<DFA::DimensionTable>();

    std::cout << "Dimensions" << std::endl;

    int IX_size, IY_size, R_size, S_size, OX_size, OY_size;
    bool has_IY = false;
    bool has_IX = false;
    bool has_OY =false;
    bool has_OX =false;

    num_macs_ = 1;

    for(auto dim : *dimensions) {
      if(dim->GetName() == "Y") {
        has_IY = true;
        IY_size = dim->GetSize();
        std::cout << "Has Y" << std::endl;
      }
      else if(dim->GetName() == "X") {
        has_IX = true;
        IX_size = dim->GetSize();
      }
      else if(dim->GetName() == "X'") {
        has_OX = true;
        OX_size = dim->GetSize();
      }
      else if(dim->GetName() == "Y'") {
        has_OY = true;
        OY_size = dim->GetSize();
      }
      else if(dim->GetName() == "R") {
        R_size = dim->GetSize();
      }
      else if(dim->GetName() == "S") {
        S_size = dim->GetSize();
      }
      num_macs_ *= dim->GetSize();
      dimension_table->AddDimension(dim);
    }

    if(has_IX && !has_OX) {
      auto ox_dim = std::make_shared<DFA::LayerDimension>("X'", IX_size - S_size +1);
      dimension_table->AddDimension(ox_dim);
    }
    if(has_IY && !has_OY) {
      auto oy_dim = std::make_shared<DFA::LayerDimension>("Y'", IY_size - R_size +1);
      dimension_table->AddDimension(oy_dim);
      std::cout << "Adding Y'" << std::endl;
    }
    if(!has_IX && has_OX) {
      auto ix_dim = std::make_shared<DFA::LayerDimension>("X", OX_size + S_size -1);
      dimension_table->AddDimension(ix_dim);
    }
    if(!has_IY && has_OY) {
      auto iy_dim = std::make_shared<DFA::LayerDimension>("Y", OY_size + R_size -1);
      dimension_table->AddDimension(iy_dim);
    }


    for(auto dim : *dimension_table) {
      std::cout << "Dim " << dim->GetName() << ", size = " << dim->GetSize() << std::endl;
    }

    std::cout << std::endl;

    return dimension_table;
  }

  void AnalyzeClusters(int layerID) {
    auto target_layer = network_->at(layerID);
    auto dataflow = target_layer->GetDataflow();
    auto dimensions = target_layer->GetDimensions();

    std::cout << "<Dataflow>\n" << dataflow->ToString() <<std::endl;

    auto dimension_table = ConstructDimensionTable(dimensions);

    for(auto tensor : *tensors_) {
      std::cout << "Tensor " << tensor->GetTensorName() << std::endl;
      std::cout << "Correlated vars: ";
      for(auto var : *tensor->GetCorrelatedVariables()) {
        std::cout << var << " ";
      }
      std::cout << std::endl;
    }

    cluster_analysis_ = std::make_shared<DFA::ClusterAnalysis>(num_pes_, tensors_, dimension_table, dataflow, nocs_);

    std::cout << "Cluster construction and analysis is done" << std::endl;
  }

  void PrintAnalysisResultsSingleCluster(std::shared_ptr<CA::CostAnalyisResults> results) {
    std::cout << std::endl;
    std::cout << std::endl;

    long num_computations = results->GetNumComputations();

    long double throughput = static_cast<double>(num_computations) / results->GetRuntime();
    std::cout << "Num MACs: " << num_computations << std::endl;

    std::cout << std::endl;
    std::cout << "[Performance Analysis]" << std::endl;
    std::cout << "Runtime: " << results->GetRuntime() << " cycles" << std::endl;
    std::cout << "Throughput: " << throughput << " MACs/cycle" << std::endl;

    std::cout << "[Buffer Access Analysis]" << std::endl;


    int num_data_classes = static_cast<int>(DataClass::NumDataClasses);
    long num_l1_read[num_data_classes];

    for(auto tensor : *tensors_) {
      auto dataclass = tensor->GetDataClass();

      std::cout << "Tensor " << tensor->GetTensorName() << std::endl;

      std::cout << "L2 buffer write: "
          << results->GetBufferAccessCount(CA::BufferType::Upstream, CA::BufferAccessType::Write, dataclass) << std::endl;
      std::cout << "L2 buffer read: "
          << results->GetBufferAccessCount(CA::BufferType::Upstream, CA::BufferAccessType::Read, dataclass) << std::endl;
      std::cout << "L1 buffer write: "
          << results->GetBufferAccessCount(CA::BufferType::Downstream, CA::BufferAccessType::Write, dataclass) << std::endl;
      std::cout << "L1 buffer read: "
          << results->GetBufferAccessCount(CA::BufferType::Downstream, CA::BufferAccessType::Read, dataclass) << std::endl;

    }

    std::cout << std::endl;
    std::cout << "[Energy Analysis]" << std::endl;

    long double l2_write_energy = 0;
    long double l2_read_energy = 0;
    long double l1_write_energy = 0;
    long double l1_read_energy = 0;
    long double total_energy = 0;

    std::cout << "-For each data class" << std::endl;
    long double tmp;
    for(auto tensor : *tensors_) {
      auto dataclass = tensor->GetDataClass();
      std::cout << "Tensor " << tensor->GetTensorName() << std::endl;

      tmp = results->GetBufferAccessCount(CA::BufferType::Upstream, CA::BufferAccessType::Write, dataclass) * l2_energy_multiplier;
      std::cout << "L2 buffer write energy: " << tmp << " X MAC energy" << std::endl;
      l2_write_energy += tmp;

      tmp = results->GetBufferAccessCount(CA::BufferType::Upstream, CA::BufferAccessType::Read, dataclass)  * l2_energy_multiplier;
      std::cout << "L2 buffer read energy: "  << tmp << " X MAC energy" << std::endl;
      l2_read_energy += tmp;

      tmp = results->GetBufferAccessCount(CA::BufferType::Downstream, CA::BufferAccessType::Write, dataclass) * l1_energy_multiplier;
      std::cout << "L1 buffer write energy: " << tmp << " X MAC energy" << std::endl;
      l1_write_energy += tmp;

      tmp = results->GetBufferAccessCount(CA::BufferType::Downstream, CA::BufferAccessType::Read, dataclass) * l1_energy_multiplier;
      std::cout << "L1 buffer read energy: " << tmp << " X MAC energy" << std::endl;
      l1_read_energy += tmp;
    }

    std::cout << std::endl;

    std::cout << "[Summary]" << std::endl;
    std::cout << "TotalL2 buffer write energy: " << l2_write_energy << " X MAC energy" << std::endl;
    std::cout << "Total L2 buffer read energy: " << l2_read_energy << " X MAC energy" << std::endl;
    std::cout << "Total L1 buffer write energy: " << l1_write_energy << " X MAC energy" << std::endl;
    std::cout << "Total L1 buffer read energy: " << l1_read_energy << " X MAC energy" << std::endl;
    std::cout << "Total MAC energy: " << num_computations << " X MAC energy" << std::endl;

    std::cout << std::endl;
    total_energy = l2_write_energy + l2_read_energy + l1_write_energy + l1_read_energy + num_computations;
    std::cout << "Total energy consumption: " << total_energy << " X MAC energy" << std::endl;

    std::cout << "Runtime: " << results->GetRuntime() << " cycles" << std::endl;
    std::cout << "Throughput: " << throughput << " MACs/cycle" << std::endl;
    long double performance_per_enrgy = throughput / total_energy;
    std::cout << "Performance per MAC energy: " << performance_per_enrgy << " MACs/cycle/(MAC_energy)" << std::endl;
  }

  std::shared_ptr<std::vector<std::shared_ptr<CA::CostAnalyisResults>>> AnalyzeCostAllClusters(bool show_all_cluster_results = false, bool verbose = true) {
    auto clusters = cluster_analysis_->GetClusters();
    auto perf_analysis = std::make_unique<CA::CostAnalysisEngine>(tensors_, clusters, num_simd_lanes_);

    auto results = perf_analysis->AnalyzeEntireCluster();

    for(int cluster_lv = 0; cluster_lv < cluster_analysis_->GetClusters()->size(); cluster_lv++) {
      std::cout << "Cluster dataflow at level " << cluster_lv << "\n" << cluster_analysis_->GetClusters()->GetCluster(cluster_lv)->GetDataflow()->ToString() << std::endl;
    }

    for(int cluster_lv = 0; cluster_lv < cluster_analysis_->GetClusters()->size(); cluster_lv++) {
      std::cout << "Dimensions at level " << cluster_lv << std::endl;
      auto dimensions = cluster_analysis_->GetClusters()->GetCluster(cluster_lv)->GetDimensions();
      for(auto& dim : *dimensions) {
        std::cout << dim->ToString() << std::endl;
      }
    }

    if(show_all_cluster_results && verbose) {
      int cluster_lv = 0;
      for(auto& cluster_res : *results) {
        std::cout << "Cluster Level " << cluster_lv << std::endl;
        PrintAnalysisResultsSingleCluster(cluster_res);
        cluster_lv++;
      }
    }
    else if (verbose){
      auto top_cluster_res = results->at(results->size()-1);
      PrintAnalysisResultsSingleCluster(top_cluster_res);
    }

    return results;
  }

  void AnalyzeCostSingleCluster(int lv = 0,  int lvs=1, bool verbose=true) {

    auto clusters = cluster_analysis_->GetClusters();
    auto perf_analysis = std::make_unique<CA::CostAnalysisEngine>(tensors_, clusters, num_simd_lanes_);

    auto results = perf_analysis->AnalyzeSingleCluster(lv);
    PrintAnalysisResultsSingleCluster(results);

  } // End of function void AnalyzeCostSingleCluster


  std::shared_ptr<std::vector<std::shared_ptr<CA::CostAnalyisResults>>> AnalyzeNeuralNetwork() {
    std::shared_ptr<std::vector<std::shared_ptr<CA::CostAnalyisResults>>> ret = std::make_shared<std::vector<std::shared_ptr<CA::CostAnalyisResults>>>();

    for(auto& layer : *network_) {
      auto dataflow = layer->GetDataflow();
      auto dimensions = layer->GetDimensions();
      auto dimension_table = ConstructDimensionTable(dimensions);

      cluster_analysis_ = std::make_shared<DFA::ClusterAnalysis>(num_pes_, tensors_, dimension_table, dataflow, nocs_);

      auto layer_results = AnalyzeCostAllClusters(false, false);
      ret->push_back(layer_results->at(0)); // Take the top level cluster results
    }

    return ret;
  }


}; // End of namespace maestro
