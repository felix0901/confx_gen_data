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

#include <memory>
#include <vector>
#include <string>
#include <map>

#include "AHW_accelerator.hpp"
#include "AHW_hw-options.hpp"
#include "AHW_hardware-module.hpp"
#include "AHW_PE-cluster.hpp"
#include "DFA_layer.hpp"
#include "DFA_dimension-table.hpp"

#include "FE_dim-mapping-constraint.hpp"
#include "FE_dataflow-constraint.hpp"

#ifndef MAESTRO_FE_FLEXIBILITY_ANALYSIS_HPP_
#define MAESTRO_FE_FLEXIBILITY_ANALYSIS_HPP_

namespace maestro {
  namespace FE {
    class FlexibilityAnalysis {
      public:
        FlexibilityAnalysis(
            std::shared_ptr<AHW::AbstractAccelerator> accelerator,
            std::shared_ptr<DFA::Layer> layer,
            std::shared_ptr<DFA::DimensionTable> dimension_table,
            std::shared_ptr<std::vector<std::shared_ptr<DFA::TensorTable>>> tensor_table
            ) :
          accelerator_(accelerator),
          layer_(layer),
          dimension_table_(dimension_table),
          tensor_table_(tensor_table) {


          //TODO: Fix these hard-coded parts
          auto buffer_option = AHW::Buffer_options::ScratchPad;
          auto reduction_option = AHW::Redudction_options::FullSpatial;

          top_cluster_ = accelerator->GetTopCluster();
          num_cluster_lvs_ = top_cluster_->GetLevel()+1;

        }

        double AnalyzeFlexibility() {

          auto buffers = top_cluster_->GetBuffers();
          auto dist_nocs = top_cluster_->GetDistNoCs();
          auto redc_nocs = top_cluster_->GetRedcNoCs();

          std::cout << "Buffer vec size: " << buffers->size() << std::endl;
          std::cout << "dist_nocs vec size: " << dist_nocs->size() << std::endl;
          std::cout << "redc_nocs vec size: " << redc_nocs->size() << std::endl;

          auto top_constraint = std::make_shared<FE::DataflowConstraint>(
              layer_, dimension_table_, buffers, dist_nocs, redc_nocs);

          curr_cluster_ = top_cluster_;
          std::cout << "Start Flexibility Analysis" << std::endl;

          auto res = GetClusterLvFlexibility(dimension_table_, top_constraint, num_cluster_lvs_-1);

          double ret = static_cast<double>(res.first) / static_cast<double>(res.second);

          return ret;
        }

      protected:
        int num_cluster_lvs_ = 0;
        std::shared_ptr<AHW::PECluster> top_cluster_;
        std::shared_ptr<AHW::PECluster> curr_cluster_;
        std::shared_ptr<AHW::AbstractAccelerator> accelerator_;
        std::shared_ptr<DFA::Layer> layer_;
        std::shared_ptr<DFA::DimensionTable> dimension_table_;
        std::shared_ptr<std::vector<std::shared_ptr<DFA::TensorTable>>> tensor_table_;
        std::shared_ptr<std::vector<std::shared_ptr<FE::DataflowConstraint>>> dataflow_constraints_;

      private:

        double GetSpatialDimFlexibility(std::shared_ptr<DataflowConstraint> constraint) {
          double spDimFlexibility = 1;

          auto constraint_table = constraint->GetConstraintTable();

          double dim_count = 0;
          double sp_dim_count = 0;

          for(auto& dim_constraint : *constraint_table) {
            dim_count++;
            if(dim_constraint.second->CanBeSpatial()) {
              sp_dim_count++;
            }
          }

          assert(dim_count != 0);
          spDimFlexibility = sp_dim_count / dim_count;

          return spDimFlexibility;
        }

        // TODO: Fix hard-coded part
        std::pair<long, long> GetClusterLvFlexibility(
            std::shared_ptr<DFA::DimensionTable> dim_table,
            std::shared_ptr<DataflowConstraint> constraint,
            int cluster_lv) {

          auto buffers = curr_cluster_->GetBuffers();
          auto dist_nocs = curr_cluster_->GetDistNoCs();
          auto redc_nocs = curr_cluster_->GetRedcNoCs();

          std::pair<long,long> ret;

          if(layer_->GetLayerType() == LayerType::CONV) {
            int size_k = dimension_table_->GetSize("K");
            int size_c = dimension_table_->GetSize("C");
            int size_y = dimension_table_->GetSize("Y");
            int size_x = dimension_table_->GetSize("X");
            int size_r = dimension_table_->GetSize("R");
            int size_s = dimension_table_->GetSize("S");

            int k_stride = dimension_table_->GetOuterStride("K");
            int c_stride = dimension_table_->GetOuterStride("C");
            int y_stride = dimension_table_->GetOuterStride("Y");
            int x_stride = dimension_table_->GetOuterStride("X");
            int r_stride = dimension_table_->GetOuterStride("R");
            int s_stride = dimension_table_->GetOuterStride("S");

            auto k_constraint = constraint->GetConstraint("K");
            int size_k_ub = k_constraint->GetMapSzUpperbound();
            int size_k_lb = k_constraint->GetMapSzLowerbound();


            auto c_constraint = constraint->GetConstraint("C");
            int size_c_ub = c_constraint->GetMapSzUpperbound();
            int size_c_lb = c_constraint->GetMapSzLowerbound();

            auto y_constraint = constraint->GetConstraint("Y");
            int size_y_ub = y_constraint->GetMapSzUpperbound();
            int size_y_lb = y_constraint->GetMapSzLowerbound();

            auto x_constraint = constraint->GetConstraint("X");
            int size_x_ub = x_constraint->GetMapSzUpperbound();
            int size_x_lb = x_constraint->GetMapSzLowerbound();


            auto r_constraint = constraint->GetConstraint("R");
            int size_r_ub = r_constraint->GetMapSzUpperbound();
            int size_r_lb = r_constraint->GetMapSzLowerbound();


            auto s_constraint = constraint->GetConstraint("S");
            int size_s_ub = s_constraint->GetMapSzUpperbound();
            int size_s_lb = s_constraint->GetMapSzLowerbound();
/*
            std::cout << "size_k_ub: " << size_k_ub << std::endl;
            std::cout << "size_k_LB: " << size_k_lb << std::endl;
            std::cout << "size_c_ub: " << size_c_ub << std::endl;
            std::cout << "size_c_LB: " << size_c_lb << std::endl;
            std::cout << "size_y_ub: " << size_y_ub << std::endl;
            std::cout << "size_y_LB: " << size_y_ub << std::endl;
            std::cout << "size_x_ub: " << size_x_ub << std::endl;
            std::cout << "size_x_LB: " << size_x_ub << std::endl;
*/

            std::shared_ptr<AHW::Buffer> filter_buffer;
            std::shared_ptr<AHW::Buffer> input_buffer;
            std::shared_ptr<AHW::Buffer> output_buffer;

            for(auto buffer: *buffers) {
              if(buffer->GetTargetTensor() == "Filter") {
                filter_buffer = buffer;
              }
              else if(buffer->GetTargetTensor() == "Input") {
                input_buffer = buffer;
              }
              else if(buffer->GetTargetTensor() == "Output") {
                output_buffer = buffer;
              }
            }

            auto tile_sizes = std::make_shared<std::map<std::string, int>>();


            long num_valid_tiles = 0;
            long num_total_tiles = 0;

            long interval = 0;

            for(int k_tile = size_k_lb; k_tile < size_k_ub; k_tile += k_stride) {
              for(int c_tile = size_c_lb; c_tile < size_c_ub; c_tile += c_stride) {
                for(int y_tile = size_y_lb; y_tile < size_y_ub; y_tile += y_stride) {
                  for(int x_tile =size_x_lb; x_tile < size_x_ub; x_tile += x_stride) {

                    (*tile_sizes)["K"] = k_tile;
                    (*tile_sizes)["C"] = c_tile;
                    (*tile_sizes)["Y"] = y_tile;
                    (*tile_sizes)["X"] = x_tile;
                    (*tile_sizes)["R"] = size_r;
                    (*tile_sizes)["S"] = size_s;


                    if(cluster_lv == num_cluster_lvs_-1 && num_total_tiles >= interval * 1000) {
                      interval++;
                      std::cout << "Investigated " << num_total_tiles << " tile options" << std::endl;
                    }

                    double sp_flexibility = GetSpatialDimFlexibility(constraint);

                    long filter_buffer_req = k_tile * c_tile * size_r * size_s;
                    long input_buffer_req = c_tile * y_tile * x_tile;
                    long output_buffer_req = k_tile * (y_tile - size_r + 1) * (x_tile - size_s + 1);


                    if(IsValidTile(buffers, tile_sizes) ) {
                      num_valid_tiles++;
                    }


                    if(cluster_lv == 0) {
                      if(input_buffer_req > input_buffer->GetSize()) {
                        num_total_tiles += (size_x_ub - x_tile) / x_stride;
                        x_tile = size_x_ub;
                      }
                      else if(output_buffer_req > output_buffer->GetSize()) {
                        num_total_tiles += (size_x_ub - x_tile) / x_stride;
                        x_tile = size_x_ub;
                      }
                    }

                    if(curr_cluster_->GetSubCluster() != nullptr) {

                      std::shared_ptr<DFA::DimensionTable> next_dim_table = std::make_shared<DFA::DimensionTable>();
                      std::shared_ptr<DFA::LayerDimension> k_dim = std::make_shared<DFA::LayerDimension>(
                          "K", k_tile, k_stride);
                      std::shared_ptr<DFA::LayerDimension> c_dim = std::make_shared<DFA::LayerDimension>(
                          "C", c_tile, c_stride);
                      std::shared_ptr<DFA::LayerDimension> y_dim = std::make_shared<DFA::LayerDimension>(
                          "Y", y_tile, y_stride);
                      std::shared_ptr<DFA::LayerDimension> x_dim = std::make_shared<DFA::LayerDimension>(
                          "X", x_tile, x_stride);
                      std::shared_ptr<DFA::LayerDimension> r_dim = std::make_shared<DFA::LayerDimension>(
                          "R", size_r, r_stride);
                      std::shared_ptr<DFA::LayerDimension> s_dim = std::make_shared<DFA::LayerDimension>(
                          "S", size_s, s_stride);

                      next_dim_table->AddDimension(k_dim);
                      next_dim_table->AddDimension(c_dim);
                      next_dim_table->AddDimension(y_dim);
                      next_dim_table->AddDimension(x_dim);
                      next_dim_table->AddDimension(r_dim);
                      next_dim_table->AddDimension(s_dim);


                      auto next_cluster = curr_cluster_->GetSubCluster();

                      auto buffers = next_cluster->GetBuffers();
                      auto dist_nocs = next_cluster->GetDistNoCs();
                      auto redc_nocs = next_cluster->GetRedcNoCs();
/*
                      std::cout << "k_tile: " << k_tile << std::endl;
                      std::cout << "c_tile: " << c_tile << std::endl;
                      std::cout << "y_tile: " << y_tile << std::endl;
                      std::cout << "x_tile: " << x_tile << std::endl;
*/
                      auto next_constraint = std::make_shared<FE::DataflowConstraint>(
                          layer_, next_dim_table, buffers, dist_nocs, redc_nocs);

                      //Recursive call
                      auto sub_cluster_res = GetClusterLvFlexibility(next_dim_table, next_constraint, cluster_lv-1);

                      num_valid_tiles += sub_cluster_res.first;
                      num_total_tiles += sub_cluster_res.second;

                    }
                    else {
                      curr_cluster_ = top_cluster_;
                    }

                    num_total_tiles++;
                  }
                }
              }
            } // End of for(k_tile)

            ret = std::make_pair(num_valid_tiles, num_total_tiles);
          }



          return ret;
        } // End of GetMappingSizeFlexibility

        long IsValidTile(
            std::shared_ptr<std::vector<std::shared_ptr<AHW::Buffer>>> buffers,
            std::shared_ptr<std::map<std::string, int>> tile_sizes,
            bool do_double_buffering = true) {

          int k_tile = (*tile_sizes)["K"];
          int c_tile = (*tile_sizes)["C"];
          int y_tile = (*tile_sizes)["Y"];
          int x_tile = (*tile_sizes)["X"];
          int r_tile = (*tile_sizes)["R"];
          int s_tile = (*tile_sizes)["S"];


          long filter_buffer_req = k_tile * c_tile * r_tile * s_tile;
          long input_buffer_req = c_tile * y_tile * x_tile;
          long output_buffer_req = k_tile * (y_tile - r_tile + 1) * (x_tile - s_tile + 1);

          if(do_double_buffering) {
            filter_buffer_req *= 2;
            input_buffer_req *= 2;
            output_buffer_req *= 2;
          }

          std::shared_ptr<AHW::Buffer> filter_buffer;
          std::shared_ptr<AHW::Buffer> input_buffer;
          std::shared_ptr<AHW::Buffer> output_buffer;

          for(auto buffer: *buffers) {
            if(buffer->GetTargetTensor() == "Filter") {
              filter_buffer = buffer;
            }
            else if(buffer->GetTargetTensor() == "Input") {
              input_buffer = buffer;
            }
            else if(buffer->GetTargetTensor() == "Output") {
              output_buffer = buffer;
            }
          }

          bool ret = true;

          ret = ret && (filter_buffer_req < filter_buffer->GetSize());
          ret = ret && (input_buffer_req < input_buffer->GetSize());
          ret = ret&& (output_buffer_req < output_buffer->GetSize());

          return ret;

        } // End of IsValidTile


    }; // End of class FlexibilityAnalysis

  }; // End of namespace FE (Flexibility Evaluation)
}; // End of namespace maestro

#endif
