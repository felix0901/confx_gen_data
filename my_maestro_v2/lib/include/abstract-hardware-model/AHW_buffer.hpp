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


#ifndef MAESTRO_AHW_BUFFER_HPP_
#define MAESTRO_AHW_BUFFER_HPP_

#include <vector>
#include <string>
#include <cmath>

#include "AHW_hardware-module.hpp"
#include "AHW_hw-options.hpp"

#include "DSE_cost-database.hpp"

namespace maestro {

  namespace AHW {
    class Buffer : public AbstractHardwareModule {
      public:
        Buffer(Buffer_options buffer_type, int size, std::string target_tensor = "Tensor" ,std::string name = "Buffer") :
          AbstractHardwareModule(size, AbstractHardwareType::Buffer, 1, name),
          buffer_type_(buffer_type),
          target_tensor_(target_tensor) {

          ComputeBufferAreaPower(buffer_type, size);

        }

        Buffer_options GetBufferType() {
          return buffer_type_;
        }

        std::string GetTargetTensor() {
          return target_tensor_;
        }

      protected:
        std::string target_tensor_;
        Buffer_options buffer_type_;

      private:
        void ComputeBufferAreaPower(Buffer_options buffer_type, int size) {
          switch(buffer_type) {
          //TODO: Add other cost information
            default: {
              double num_large_sram_modules = std::ceil(static_cast<double>(size) / DSE::cost::sram_unit_size_32768);
              double remaining_size = size - num_large_sram_modules * DSE::cost::sram_unit_size_32768;
              double num_small_modules = std::ceil(static_cast<double>(remaining_size) / DSE::cost::sram_unit_size_64);

              unit_area_ = num_large_sram_modules * DSE::cost::sram_area_32768 ;
              unit_power_ = num_large_sram_modules * DSE::cost::sram_power_32768;

              unit_area_ += num_small_modules * DSE::cost::sram_area_64 ;
              unit_power_ += num_small_modules * DSE::cost::sram_power_64;
            }
          }// End of switch(buffer_type)
        }// End of ComputeBufferAreaPower
    }; // End of class Buffer
  }; // End of namespace AHW
}; // End of namespace maestro

#endif
