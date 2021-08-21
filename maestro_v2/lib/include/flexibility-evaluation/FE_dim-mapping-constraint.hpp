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


#ifndef MAESTRO_FE_DIM_MAPPING_CONSTRAINT_HPP_
#define MAESTRO_FE_DIM_MAPPING_CONSTRAINT_HPP_

#include <memory>
#include <vector>
#include <string>

#include "AHW_hw-options.hpp"
#include "BASE_maestro-class.hpp"

#include "DFSL_syntax_tokens.hpp"
#include "DFA_layer.hpp"

namespace maestro {
  namespace FE {
    class DimMappingConstraint : public MAESTROClass {
      public:
        DimMappingConstraint(
            std::string dim_name,
            int mapsize_lowerbound,
            int mapsize_upperbound,
            bool can_be_spatial ) :
          dim_name_(dim_name),
          mapsize_lowerbound_(mapsize_lowerbound),
          mapsize_upperbound_(mapsize_upperbound),
          can_be_spatial_(can_be_spatial) {
          order_constraint_ = std::make_shared<std::vector<std::string>>();
        }

        void AddMustProceedDim(std::string proceed_dim) {
          order_constraint_->push_back(proceed_dim);
        }

        bool CanBeSpatial() {
          return can_be_spatial_;
        }

        int GetMapSzUpperbound() {
          return mapsize_upperbound_;
        }

        int GetMapSzLowerbound() {
          return mapsize_lowerbound_;
        }


      protected:
        std::shared_ptr<std::vector<std::string>> order_constraint_;
        std::string dim_name_;
        int mapsize_lowerbound_;
        int mapsize_upperbound_;
        bool can_be_spatial_;

      private:


    }; // End of class Dataflow Constraint



  }; // End of namespace FE
}; // End of namespace maestro

#endif
