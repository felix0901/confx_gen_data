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
#include <map>
#include <string>

#include "BASE_maestro-class.hpp"

#include "AHW_buffer.hpp"

#ifndef MAESTRO_FE_TILING_INFO_TABLE_HPP_
#define MAESTRO_FE_TILING_INFO_TABLE_HPP_

namespace maestro {
  namespace FE {
    class TileInfoTable : public MAESTROClass {
      public:
        TileInfoTable(
            std::shared_ptr<std::vector<std::shared_ptr<AHW::Buffer>>> buffers,
            bool do_double_buffering = true) :
            buffers_(buffers),
            do_double_buffering_(do_double_buffering) {

          tile_sizes_ = std::make_unique<std::map<std::string, int>();

        }

      protected:
        bool do_double_buffering_;
        std::shared_ptr<std::vector<std::shared_ptr<AHW::Buffer>>> buffers_;
        std::unique_ptr<std::map<std::string, int>> tile_sizes_;



    }; // End of class TilingAnalysis
  }; // End of namespace FE
}; // End of namespace maestro
