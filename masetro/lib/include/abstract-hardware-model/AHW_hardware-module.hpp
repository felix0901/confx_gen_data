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

#ifndef MAESTRO_AHW_HARDWARE_MODULE_HPP_
#define MAESTRO_AHW_HARDWARE_MODULE_HPP_

#include <memory>
#include <vector>
#include <string>

#include "BASE_maestro-class.hpp"
#include "AHW_hw-options.hpp"

namespace maestro {

  namespace AHW {

    class AbstractHardwareModule : public MAESTROClass {
      public:
        AbstractHardwareModule(std::string module_name = "AbstractHardwareModule") :
          MAESTROClass(module_name),
          unit_area_(0),
          unit_power_(0),
          num_instances_(1),
          size_(0),
          type_(AbstractHardwareType::Others)  {
          submodule_list_ = std::make_shared<std::vector<std::shared_ptr<AbstractHardwareModule>>>();
        }

        AbstractHardwareModule(int size, double unit_area, double unit_power, AbstractHardwareType type, std::string module_name = "AbstractHardwareModule") :
          MAESTROClass(module_name),
          size_(size),
          unit_area_(unit_area),
          unit_power_(unit_power),
          num_instances_(1),
          type_(type)  {
          submodule_list_ = std::make_shared<std::vector<std::shared_ptr<AbstractHardwareModule>>>();
        }

        AbstractHardwareModule(int size, AbstractHardwareType type, int num_instances = 1, std::string module_name = "AbstractHardwareModule") :
          MAESTROClass(module_name),
          size_(size),
          unit_area_(0),
          unit_power_(0),
          num_instances_(num_instances),
          type_(type)  {
          submodule_list_ = std::make_shared<std::vector<std::shared_ptr<AbstractHardwareModule>>>();
        }

        void AddSubModule(std::shared_ptr<AbstractHardwareModule> sub_module) {
          submodule_list_->push_back(sub_module);
        }

        std::shared_ptr<std::vector<std::shared_ptr<AbstractHardwareModule>>> GetSubModules() {
          return submodule_list_;
        }

        void ProcessSubModules() {
          for(auto sub_module : *submodule_list_) {
            unit_area_ += sub_module->GetArea();
            unit_power_ += sub_module->GetPower();
          }
        }

        bool IsValid() {
          bool ret = true;
          if(submodule_list_->empty()) {
            if(unit_area_ == 0 || unit_power_ == 0) {
              ret = false;
            }
          }

          return ret;
        }

        int GetSize() {
          return size_;
        }

        double GetArea() {
          return unit_area_;

        }

        double GetPower() {
          return unit_power_;
        }

        void SetNumInstances(int num_instances) {
          num_instances_ = num_instances;
        }

        void SetSize(int size) {
          size_ = size;
        }


        bool IsLeaf() {
          return submodule_list_->empty();
        }

        AbstractHardwareType GetHWType() {
          return type_;
        }

      protected:
        AbstractHardwareType type_;
        int num_instances_;
        int size_;
        double unit_area_;
        double unit_power_;
        std::shared_ptr<std::vector<std::shared_ptr<AbstractHardwareModule>>> submodule_list_;

    }; // End of class AbstractHardwareModule

  }; // End of namespace AHW

}; // End of namespace MAESTRO

#endif
