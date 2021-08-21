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

#ifndef MAESTRO_FE_DATAFLOW_CONSTRAINT_HPP_
#define MAESTRO_FE_DATAFLOW_CONSTRAINT_HPP_


#include <memory>
#include <vector>
#include <map>
#include <string>

#include "AHW_hw-options.hpp"
#include "AHW_buffer.hpp"
#include "AHW_noc.hpp"

#include "BASE_maestro-class.hpp"

#include "DFSL_syntax_tokens.hpp"
#include "DFA_layer.hpp"

#include "FE_dim-mapping-constraint.hpp"


namespace maestro {
  namespace FE {
  class DataflowConstraint : public MAESTROClass {
    public:
      DataflowConstraint(
          std::shared_ptr<DFA::Layer> layer,
          std::shared_ptr<DFA::DimensionTable> dimension_table,
          std::shared_ptr<std::vector<std::shared_ptr<AHW::Buffer>>> buffers,
          std::shared_ptr<std::vector<std::shared_ptr<AHW::DistributionNoC>>> dist_nocs,
          std::shared_ptr<std::vector<std::shared_ptr<AHW::ReductionNoC>>> redc_nocs) :
          buffers_(buffers), dist_nocs_(dist_nocs), redc_nocs_(redc_nocs) {

        constraint_table_ = std::make_shared<std::map<std::string, std::shared_ptr<DimMappingConstraint>>>();
        ConstructConstraintTable(layer, dimension_table);

      } // End of constructor DataflowConstraintTable

      std::shared_ptr<std::map<std::string, std::shared_ptr<DimMappingConstraint>>> GetConstraintTable() {
        return constraint_table_;
      }

      std::shared_ptr<DimMappingConstraint> GetConstraint(std::string dim) {
        if(constraint_table_->find(dim) != constraint_table_->end()) {
          return (*constraint_table_)[dim];
        }

        return nullptr;
      }

    protected:
      std::shared_ptr<std::map<std::string, std::shared_ptr<DimMappingConstraint>>> constraint_table_;
      std::shared_ptr<std::vector<std::shared_ptr<AHW::Buffer>>> buffers_;
      std::shared_ptr<std::vector<std::shared_ptr<AHW::DistributionNoC>>> dist_nocs_;
      std::shared_ptr<std::vector<std::shared_ptr<AHW::ReductionNoC>>> redc_nocs_;



    private:
      void ConstructConstraintTable(
          std::shared_ptr<DFA::Layer> layer,
          std::shared_ptr<DFA::DimensionTable> dimension_table) {

        assert(redc_nocs_->size() == 1);
        AHW::Redudction_options reduction_option = redc_nocs_->at(0)->GetRedcNoCType();

        std::shared_ptr<AHW::Buffer> filter_buffer;

        for(auto buffer: *buffers_) {
          if(buffer->GetTargetTensor() == "Filter") {
            filter_buffer = buffer;
          }
        }

        AHW::Buffer_options filter_buffer_option = filter_buffer->GetBufferType();
        int k_mapsize_lowerbound;
        int c_mapsize_lowerbound;
        int y_mapsize_lowerbound;
        int x_mapsize_lowerbound;
        int r_mapsize_lowerbound;
        int s_mapsize_lowerbound;

        int k_mapsize_upperbound;
        int c_mapsize_upperbound;
        int y_mapsize_upperbound;
        int x_mapsize_upperbound;
        int r_mapsize_upperbound;
        int s_mapsize_upperbound;

        bool r_sp;
        bool s_sp;
        bool c_sp;



        auto layer_type = layer->GetLayerType();
        switch(layer_type) {
          case (LayerType::CONV) : {
            k_mapsize_lowerbound = 1;
            c_mapsize_lowerbound = 1;
            y_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                dimension_table->GetSize(DFSL::layer_dim_weight_height_) : 1;
            x_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                dimension_table->GetSize(DFSL::layer_dim_weight_width_) : 1;
            r_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                dimension_table->GetSize(DFSL::layer_dim_weight_height_) : 1;
            s_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                dimension_table->GetSize(DFSL::layer_dim_weight_width_) : 1;

            k_mapsize_upperbound = filter_buffer_option == AHW::Buffer_options::FIFO ?
                                            1 : dimension_table->GetSize(DFSL::layer_dim_output_channel_);
            c_mapsize_upperbound = dimension_table->GetSize(DFSL::layer_dim_input_channel_);
            y_mapsize_upperbound = filter_buffer_option == AHW::Buffer_options::FIFO ?
                                           dimension_table->GetSize(DFSL::layer_dim_weight_height_)
                                           : dimension_table->GetSize(DFSL::layer_dim_input_height_);
            x_mapsize_upperbound = filter_buffer_option == AHW::Buffer_options::FIFO ?
                                           dimension_table->GetSize(DFSL::layer_dim_weight_width_)
                                           : dimension_table->GetSize(DFSL::layer_dim_input_width_);


            r_mapsize_upperbound = dimension_table->GetSize(DFSL::layer_dim_weight_height_);
            s_mapsize_upperbound = dimension_table->GetSize(DFSL::layer_dim_weight_width_);

            r_sp = reduction_option == AHW::Redudction_options::Temporal? false : true;
            s_sp = reduction_option == AHW::Redudction_options::Temporal? false : true;
            c_sp = reduction_option == AHW::Redudction_options::Temporal? false : true;

            break;
          }
          case (LayerType::DSCONV) : {

            c_mapsize_lowerbound = 1;
            y_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                layer->GetSize(DFSL::layer_dim_weight_height_) : 1;
            x_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                layer->GetSize(DFSL::layer_dim_weight_width_) : 1;
            r_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                layer->GetSize(DFSL::layer_dim_weight_height_) : 1;
            s_mapsize_lowerbound = reduction_option == AHW::Redudction_options::Temporal?
                layer->GetSize(DFSL::layer_dim_weight_width_) : 1;

            c_mapsize_upperbound = filter_buffer_option == AHW::Buffer_options::FIFO ?
                                            1 : layer->GetSize(DFSL::layer_dim_output_channel_);
            y_mapsize_upperbound = filter_buffer_option == AHW::Buffer_options::FIFO ?
                                           dimension_table->GetSize(DFSL::layer_dim_weight_height_)
                                           : dimension_table->GetSize(DFSL::layer_dim_input_height_);
            x_mapsize_upperbound = filter_buffer_option == AHW::Buffer_options::FIFO ?
                                           dimension_table->GetSize(DFSL::layer_dim_weight_width_)
                                           : dimension_table->GetSize(DFSL::layer_dim_input_width_);

            r_mapsize_upperbound = layer->GetSize(DFSL::layer_dim_weight_height_);
            s_mapsize_upperbound = layer->GetSize(DFSL::layer_dim_weight_width_);

            r_sp = reduction_option == AHW::Redudction_options::Temporal? false : true;
            s_sp = reduction_option == AHW::Redudction_options::Temporal? false : true;
            c_sp = reduction_option == AHW::Redudction_options::Temporal? false : true;

            break;
          }
          default: {

          }

        } // End of switch (layerType)
        if(layer->GetSize(DFSL::layer_dim_input_batch_) != -1) {
          auto constraint_n = std::make_shared<DimMappingConstraint>(
               DFSL::layer_dim_input_batch_,
               1,
               layer->GetSize(DFSL::layer_dim_input_batch_),
               true);
          (*constraint_table_)[DFSL::layer_dim_input_batch_] = constraint_n;
        }

        if(layer_type != LayerType::DSCONV) {
          auto constraint_k = std::make_shared<DimMappingConstraint>(
               DFSL::layer_dim_output_channel_,
               k_mapsize_lowerbound,
               k_mapsize_upperbound,
               true);
          (*constraint_table_)[DFSL::layer_dim_output_channel_] = constraint_k;
        }



        auto constraint_c = std::make_shared<DimMappingConstraint>(
            DFSL::layer_dim_input_channel_,
            c_mapsize_lowerbound,
            c_mapsize_upperbound,
            c_sp);

         auto constraint_y = std::make_shared<DimMappingConstraint>(
             DFSL::layer_dim_input_height_,
             y_mapsize_lowerbound,
             y_mapsize_upperbound,
             true);

         auto constraint_x = std::make_shared<DimMappingConstraint>(
             DFSL::layer_dim_input_width_,
             x_mapsize_lowerbound,
             x_mapsize_upperbound,
             true);

         auto constraint_r = std::make_shared<DimMappingConstraint>(
             DFSL::layer_dim_weight_height_,
             r_mapsize_lowerbound,
             r_mapsize_upperbound,
             r_sp);

         auto constraint_s = std::make_shared<DimMappingConstraint>(
             DFSL::layer_dim_weight_width_,
             s_mapsize_lowerbound,
             s_mapsize_upperbound,
             s_sp);

         (*constraint_table_)[DFSL::layer_dim_input_channel_] = constraint_c;
         (*constraint_table_)[DFSL::layer_dim_input_height_] = constraint_y;
         (*constraint_table_)[DFSL::layer_dim_input_width_] = constraint_x;
         (*constraint_table_)[DFSL::layer_dim_weight_height_] = constraint_r;
         (*constraint_table_)[DFSL::layer_dim_weight_width_] = constraint_s;

      }// End of void ConstructConstraintTable
  }; // End of class DataflowConstraint


  }; // End of namespace FE
}; // End of namespace maestro

#endif
