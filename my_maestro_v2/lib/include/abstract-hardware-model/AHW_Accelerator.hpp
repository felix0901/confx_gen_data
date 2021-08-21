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

#ifndef MAESTRO_AHW_ACCELERATOR_HPP_
#define MAESTRO_AHW_ACCELERATOR_HPP_

#include <vector>
#include <string>

#include "DSE_design-options.hpp"
#include "AHW_hardware-module.hpp"
#include "AHW_PE-cluster.hpp"

namespace maestro {

  namespace AHW {

    class Accelerator {
      public:


      protected:
        int num_pes_;
        int pe_vector_width_;
        DSE::OpType mult_op_type_;
        int mult_precision_;
        DSE::OpType add_op_type_;
        int add_precision_;

        std::vector<std::string> buffer_name_;
        std::vector<int> buffer_sizes_;
        std::vector<std::string> noc_name_;
        std::vector<int> noc_bandwidth_;
        std::vector<int> noc_latency_;


    }; // End of class Accelerator


    class AcceleratorV2 {
      public:
        int num_pes_;
        int pe_vector_width_;
        DSE::OpType mult_op_type_;
        int mult_precision_;
        DSE::OpType add_op_type_;
        int add_precision_;

        int num_pe_array_dims_;
        std::vector<int> dim_size_;

        std::vector<std::string> buffer_name_;
        std::vector<int> buffer_sizes_;
        std::vector<std::string> noc_name_;
        std::vector<int> noc_bandwidth_;
        std::vector<int> noc_latency_;
        std::vector<bool> noc_neighbor_connections_;
    }; // End of class Accelerator

    class AbstractAccelerator : public AbstractHardwareModule {
      public:
        AbstractAccelerator(std::string acc_name = "Accelerator") :
          AbstractHardwareModule(acc_name) {
        }

        void SetTopCluster(std::shared_ptr<AHW::PECluster> top_cluster) {
          top_cluster_ = top_cluster;
        }

        std::shared_ptr<AHW::PECluster> GetTopCluster() {
          return top_cluster_;
        }

      protected:
        std::shared_ptr<AHW::PECluster> top_cluster_;

      private:

    };


  }; // End of namespace AHW
}; // End of namespace maestro


#endif
