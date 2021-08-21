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


#ifndef MAESTRO_AHW_NOC_HPP_
#define MAESTRO_AHW_NOC_HPP_

#include <vector>
#include <string>
#include <cmath>

#include "AHW_hardware-module.hpp"
#include "AHW_hw-options.hpp"

#include "DSE_cost-database.hpp"
#include "DSE_scaling-coefficients.hpp"

namespace maestro {
  namespace AHW {
    class DistributionNoC : public AbstractHardwareModule {
      public:
        DistributionNoC(NoC_options noc_type, int num_connections, int bw, int hops, int hop_latency, std::string target_tensor, std::string noc_name = "DistributionNoC") :
          AbstractHardwareModule(num_connections, AbstractHardwareType::DistributionNoC, 1, noc_name),
          bandwidth_(bw), num_average_hops_(hops), latency_per_hops_(hop_latency), target_tensor_(target_tensor) {
          ComputeNoCAreaPower(noc_type, bw);
          AnalyzeMulticastSupport(noc_type);
        }

        NoC_options GetNoCType() {
          return noc_type_;
        }

        int GetBandwidth() {
          return bandwidth_;
        }

        bool IsMulticastSupported() {
          return multicast_support_;
        }

        void SetBandwidth(int bw) {
          bandwidth_ = bw;
        }

        long GetOutStandingDelay(long data_amount) {
          long delay;

          long num_sends;
          if(data_amount % bandwidth_ != 0) {
            num_sends = data_amount / bandwidth_ + 1;
          }
          else {
            num_sends = data_amount / bandwidth_;
          }

          long avg_zero_load_delay = num_average_hops_ * latency_per_hops_;

          delay = avg_zero_load_delay // Head delay
              + (num_sends-1); // Pipeline delay

              return delay;
        } // End of GetOutStandingDelay

        std::string GetTargetTensor() {
          return target_tensor_;
        }

      protected:
        NoC_options noc_type_;
        std::string target_tensor_;
        int bandwidth_;
        int num_average_hops_;
        int latency_per_hops_;
        bool multicast_support_;

      private:
        void AnalyzeMulticastSupport(NoC_options noc_type) {
          switch(noc_type) {
            case(NoC_options::Bus):
            case(NoC_options::Tree): {
              multicast_support_ = true;
              break;
            }
            default: {
              multicast_support_ = false;
            }
          }
        }

        void ComputeNoCAreaPower(NoC_options noc_type, int bw) {
          switch(noc_type) {
          //TODO: Update cost information for other NoC types
//            case(NoC_options::Bus) : {
          default: {
              unit_area_ =
                  GetArbiterScalingFactor() * DSE::cost::arbiter_unit_area
                  + GetBusScalingFactor() * DSE::cost::bus_unit_area;

              unit_power_ =
                  GetArbiterScalingFactor() * DSE::cost::arbiter_unit_power
                  + GetBusScalingFactor() * DSE::cost::bus_unit_power;
            }
          }
        } // End of void COmputeNoCAreaPower

        double GetArbiterScalingFactor() {
          double mult = DSE::scaling_model::matrix_arbiter_c2 * pow(size_, 2) + DSE::scaling_model::matrix_arbirter_c1 * size_ + DSE::scaling_model::matrix_arbiter_c0 ;
          return mult;
        }

        double GetBusScalingFactor() {
          double res = DSE::scaling_model::bus_c1 * size_ + DSE::scaling_model::bus_c0;
          return res;
        }

    }; // End of class DistributionNoC

    class ReductionNoC : public AbstractHardwareModule {
      public:
        ReductionNoC(Redudction_options noc_type, int num_connections, int bw, int hops, int hop_latency, std::string noc_name = "ReductionNoC") :
          AbstractHardwareModule(num_connections, AbstractHardwareType::ReductionNoC, 1, noc_name),
          noc_type_(noc_type), bandwidth_(bw), num_average_hops_(hops), latency_per_hops_(hop_latency) {
        }

        Redudction_options GetRedcNoCType() {
          return noc_type_;
        }

      protected:
        Redudction_options noc_type_;
        int bandwidth_;
        int num_average_hops_;
        int latency_per_hops_;

      private:

        void ComputeNoCAreaPower(Redudction_options noc_type, int bw) {
          switch(noc_type) {
          //TODO: Update Cost Information
            default: {
              unit_area_ = 1;
              unit_power_ = 1;
            }
          }// End of switch(noc_type)
        } // End of void COmputeNoCAreaPower
    }; // End of class ReductionNoC


  }; // End of namespace AHW
}; // End of namespace maestro

#endif
