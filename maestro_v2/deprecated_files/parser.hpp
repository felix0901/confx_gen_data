#ifndef MAESTRO_PRAGMA_PARSER_HPP_
#define MAESTRO_PRAGMA_PARSER_HPP_

#include <string>
#include <iostream>
#include <fstream>
#include <cstdlib>

#include<boost/tokenizer.hpp>
#include<boost/format.hpp>

#include "analysis-structure.hpp"

namespace maestro {

  class InputParser {
    protected:
      std::string file_name_;
      std::ifstream in_file_;

    public:
      InputParser(std::string file_nm) :
        file_name_(file_nm)
      {
        in_file_.open(file_nm);
        if(!in_file_) {
          std::cout << "Failed to open the input file" << std::endl;
        }
      }
  }; // End of class InputParser

  class DirectiveParser : public InputParser {
    protected:
      int num_pes_;

    public:
      DirectiveParser(std::string file_nm) :
        InputParser(file_nm),
        num_pes_(1)
      {
      }

      DirectiveParser(std::string file_nm, int num_pes) :
        InputParser(file_nm),
        num_pes_(num_pes)
      {
      }

      std::shared_ptr<DirectiveTable> ParseDirectives() {
        auto prag_table = std::make_shared<DirectiveTable>();
        std::string line;

        //Read a line of the file
        while(std::getline(in_file_, line)) {
          boost::char_separator<char> sep(" ,->()");
          boost::tokenizer<boost::char_separator<char>> tokn(line, sep);

          DirectiveClass directive_cls = DirectiveClass::INVALID;
          std::string loop_var = default_loop_var;
          bool saw_size = false;
          bool saw_ofs = false;

          int map_size = 1;
          int tile_size = 1;
          int map_offset = 1;

          for(auto& tok : tokn) {

            switch(directive_cls) {
              case(DirectiveClass::INVALID): {
                if(tok == tkn_temporal_map) {
                  directive_cls = DirectiveClass::TEMPORAL_MAP;
                }
                else if (tok == tkn_spatial_map) {
                  directive_cls = DirectiveClass::SPATIAL_MAP;
                }
                else if (tok == tkn_unroll) {
                  directive_cls = DirectiveClass::UNROLL;
                }
                else if (tok == tkn_tile) {
                  directive_cls = DirectiveClass::CLUSTER;
                }
                break;
              }
              case(DirectiveClass::TEMPORAL_MAP):
              case(DirectiveClass::SPATIAL_MAP): {
                if(!saw_size) {
                  map_size = std::atoi(tok.c_str());
                  saw_size = true;
                }
                else if(!saw_ofs) {
                  map_offset = std::atoi(tok.c_str());
                  saw_ofs = true;
                }
                else {
                  loop_var = tok;
                }
                break;
              }
              case(DirectiveClass::CLUSTER): {
                if(!saw_size) {
                  tile_size = std::atoi(tok.c_str());
                  saw_size = true;
                }
                else {
                  loop_var = tok;
                }
                break;
              }
              default: { //Merge and unroll
                loop_var = tok;
                break;
              }
            }
          } // End of for that tokenizes and lexes a line

          switch(directive_cls) {
            case(DirectiveClass::TEMPORAL_MAP):{
              std::shared_ptr<Directive> new_directive = std::make_shared<TemporalMap>(loop_var, map_size, map_offset);
              prag_table->AddDirective(new_directive);
              break;
            }
            case(DirectiveClass::SPATIAL_MAP): {
              std::shared_ptr<Directive> new_directive = std::make_shared<SpatialMap>(loop_var, map_size, map_offset, num_pes_);
              prag_table->AddDirective(new_directive);
              break;
            }
            case(DirectiveClass::CLUSTER): {
              std::cout << " CLUSTER" << std::endl;
              std::shared_ptr<Directive> new_directive = std::make_shared<Cluster>(loop_var, tile_size);
              prag_table->AddDirective(new_directive);
              break;
            }
            case(DirectiveClass::UNROLL): {
              std::shared_ptr<Directive> new_directive = std::make_shared<Unroll>(loop_var);
              prag_table->AddDirective(new_directive);
              break;
            }
            default: //Parse error -> do not add any item
              break;
          }

        }

        return prag_table;
      }
  }; // End of class DirectiveParser

  class ProgramParser : public InputParser {

    public:
      ProgramParser(std::string file_nm) :
        InputParser(file_nm) {
      }

      std::shared_ptr<LoopInfoTable> ParseProgram() {
        auto prob_table = std::make_shared<LoopInfoTable>();
        std::string line;

        //Read a line of the file
        while(std::getline(in_file_, line)) {
          boost::char_separator<char> sep(" ,->()");
          boost::tokenizer<boost::char_separator<char>> tokn(line, sep);

          std::string loop_var = default_loop_var;

          bool saw_size = false;
          int size = 0;

          for(auto& tok : tokn) {
            if(loop_var == default_loop_var) {
              loop_var = tok;
            }
            else if (!saw_size){
              size = std::atoi(tok.c_str());
              saw_size = true;
            }
            else {
              //TODO: Update error message with a better version
              std::cout << "[ProblemParser]Warning: Located extra arguments in problem dimension description. Ignoring extra arguments " << std::endl;
            }
          }

          auto loop_info = std::make_shared<LoopInformation>(loop_var, 0, size);
          prob_table->AddLoop(loop_info);

        }
        return prob_table;
      }


  }; // End of class ProgramParser


  class LoopParser : public InputParser {
    protected:

    public:
      LoopParser(std::string file_nm) :
        InputParser(file_nm)
      {
      }

      std::shared_ptr<LoopInfoTable> ParseLoop() {
        auto loop_table = std::make_shared<LoopInfoTable>();
        auto prag_table = std::make_shared<DirectiveTable>();

        std::string line;

        //Read a line of the file
        while(std::getline(in_file_, line)) {
          boost::char_separator<char> sep(" ,->()");
          boost::tokenizer<boost::char_separator<char>> tokn(line, sep);

          std::string loop_var = default_loop_var;

          bool saw_size = false;
          int size = 0;

          for(auto& tok : tokn) {
            if(loop_var == default_loop_var) {
              loop_var = tok;
            }
            else if (!saw_size){
              size = std::atoi(tok.c_str());
              saw_size = true;
            }
            else {
              //TODO: Update error message with a better version
              std::cout << "[ProblemParser]Warning: Located extra arguments in problem dimension description. Ignoring extra arguments " << std::endl;
            }
          }

          auto loop_info = std::make_shared<LoopInformation>(loop_var, 0, size);
          loop_table->AddLoop(loop_info);

        }
        return loop_table;
      }

  }; // End of class ProblemParser
}; // End of namespace maestro

#endif
