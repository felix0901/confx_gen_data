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

#include <boost/filesystem.hpp>
#include <iostream>
#include <fstream>
#include <string>
#include <memory>

#include "BASE_maestro-class.hpp"

#include "API_configuration.hpp"

namespace maestro {

  namespace TL {

    class GenericCSVWriter : public MAESTROClass {
      public:
        GenericCSVWriter(std::string file_name_, bool append = true) {
          bool file_exists = boost::filesystem::exists(file_name_);

          if(append) {
            outfile_.open(file_name_,std::fstream::in | std::fstream::out | std::fstream::app);
          }
          else {
            outfile_.open(file_name_,std::fstream::in | std::fstream::out);
          }
        }

        void WriteWord(std::string word, bool change_line = false) {
          if(change_line) {
            outfile_ << word << std::endl;
          }
          else {
            outfile_ << word;
          }
        }

        void WriteLine(std::shared_ptr<std::vector<std::string>> input_words, bool change_line = true) {
          for(auto word : *input_words) {
            outfile_ << word;
          }

          if(change_line)
            outfile_ << std::endl;
        }


      protected:
        std::ofstream outfile_;


    }; // End of class GenericCSVWriter


  }; // End of namespace TL (Tool)

}; // End of namespace maestro
