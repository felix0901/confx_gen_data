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




#ifndef MAESTRO_AHW_PECLUSTER_HPP_
#define MAESTRO_AHW_PECLUSTER_HPP_

#include <vector>
#include <string>
#include <cmath>
#include <memory>

#include "AHW_hardware-module.hpp"
#include "AHW_hw-options.hpp"
#include "AHW_buffer.hpp"
#include "AHW_noc.hpp"

#include "DFA_tensor.hpp"
#include "DFA_tensor-table.hpp"

#include "DSE_cost-database.hpp"

namespace maestro {
  namespace AHW {
    class PECluster : public AbstractHardwareModule {
      public:
        //TODO: Update input arguments to be a config class
        PECluster(std::string name = "PECluster") :
          AbstractHardwareModule(1, AbstractHardwareType::Cluster, 1, name),
          sub_cluster_(nullptr) {

          buffer_list_ = std::make_shared<std::vector<std::shared_ptr<Buffer>>>();
          noc_list_ = std::make_shared<std::vector<std::shared_ptr<DistributionNoC>>>();
          reduction_noc_list_ = std::make_shared<std::vector<std::shared_ptr<ReductionNoC>>>();
        }

        void SetLevel(int level) {
          level_ = level;
        }

        int GetLevel() {
          return level_;
        }

        void AddBuffer(std::shared_ptr<Buffer> buffer) {
          buffer_list_->push_back(buffer);
        }

        void AddDistNoC(std::shared_ptr<DistributionNoC> noc) {
          noc_list_->push_back(noc);
        }

        void AddRedcNoC(std::shared_ptr<ReductionNoC> noc) {
          reduction_noc_list_->push_back(noc);
        }

        std::shared_ptr<std::vector<std::shared_ptr<Buffer>>> GetBuffers() {
          return buffer_list_;
        }

        std::shared_ptr<std::vector<std::shared_ptr<DistributionNoC>>> GetDistNoCs() {
          return noc_list_;
        }

        std::shared_ptr<std::vector<std::shared_ptr<ReductionNoC>>> GetRedcNoCs() {
          return reduction_noc_list_;
        }


        void SetSubCluster(std::shared_ptr<PECluster> sub_cluster) {
          sub_cluster_ = sub_cluster;
        }

        std::shared_ptr<PECluster> GetSubCluster() {
          return sub_cluster_;
        }


      protected:
        int level_ = -1;
        int vector_width = 1; //TODO: Connect this

        std::shared_ptr<PECluster> sub_cluster_ = nullptr;

        std::shared_ptr<std::vector<std::shared_ptr<Buffer>>> buffer_list_;
        std::shared_ptr<std::vector<std::shared_ptr<DistributionNoC>>> noc_list_;
        std::shared_ptr<std::vector<std::shared_ptr<ReductionNoC>>> reduction_noc_list_;

      private:
        void ComputePEAreaPower(int vector_width, Buffer_options buffer_type, int local_buffer_size) {
          this->ProcessSubModules();

          unit_area_ = DSE::cost::mac_area * vector_width;
          unit_power_ = DSE::cost::mac_power * vector_width;
        }

    }; // End of class PECluster
  }; // End of namespace AHW
}; // End of namespace maestro

#endif
