#ifndef MAESTRO_ANALYSIS_STRUCTURE_HPP_
#define MAESTRO_ANALYSIS_STRUCTURE_HPP_

#include <string>
#include <iostream>
#include <list>
#include <vector>
#include <map>
#include <tuple>
#include <algorithm>

#include "mapping-syntax.hpp"
#include "program-syntax.hpp"
#include "noc-model.hpp"

namespace maestro {

  class LoopInformation {
    protected:
      int loop_id_;
      std::string loop_var_;
      int base_;
      int bound_;
      int incr_;
    public:
      LoopInformation(std::string loop_var, int base, int bound) :
        loop_id_(-1),
        incr_(1),
        loop_var_(loop_var),
        base_(base),
        bound_(bound)
      {
        if(bound < base) {
          std::cout << "Warning: invalid loop" << std::endl;
        }
      }

      std::string ToString() {
        std::string ret = boost::str(boost::format("Loop %s, base: %d, bound: %d")
                                        % loop_var_
                                        % base_
                                        % bound_ );
        return ret;
      }

      std::string GetLoopVar() {
        return loop_var_;
      }

      int GetBase() {
        return base_;
      }

      int GetBound() {
        return bound_;
      }

      int GetNumIter() {
        int ret = (bound_ - base_) / incr_;
        return ret;
      }

  }; // End of class LoopInformation

  class LoopInfoTable {
    protected:
      std::shared_ptr<std::vector<std::shared_ptr<LoopInformation>>> info_table_;

    public:
      LoopInfoTable() {
        info_table_ = std::make_shared<std::vector<std::shared_ptr<LoopInformation>>>();
      }

      std::string ToString() {
        std::string ret = "";

        for(auto& loop : *info_table_) {
          ret += loop->ToString() + "\n";
        }

        return ret;
      }


      void AddLoop(std::shared_ptr<LoopInformation> new_loop) {
        info_table_->push_back(new_loop);
      }

      std::shared_ptr<std::list<std::shared_ptr<LoopInformation>>> FindLoops(std::string loop_var) {
         auto ret = std::make_shared<std::list<std::shared_ptr<LoopInformation>>>();

        for(auto& loop_info : *info_table_) {
          if(loop_info->GetLoopVar() == loop_var) {
            ret->push_back(loop_info); // This is not a bug; Just IDE does not understand auto around here
          }
        }

        return ret;
      }

      long GetTotalIterations() {
      	long ret = 1;

      	for(auto& loop: *info_table_) {
      		ret *= loop->GetBound();
      	}

      	return ret;
      }

  }; // End of class LoopInfoTable

  class DirectiveTable {
    public:
      DirectiveTable() {
        directive_table_ = std::make_shared<std::vector<std::shared_ptr<Directive>>>();
      }

      class iterator {
        public:
          iterator() = default;
          iterator(std::shared_ptr<std::vector<std::shared_ptr<Directive>>> ptr):
            directive_table_ptr_(ptr.get()),
            pos_(0)
          {
          }

          iterator(std::shared_ptr<std::vector<std::shared_ptr<Directive>>> ptr, int pos):
            directive_table_ptr_(ptr.get()),
            pos_(pos)
          {
          }

          iterator operator--() {
            --pos_;
            return *this;
          }

          iterator operator++() {
            ++pos_;
            return *this;
          }

          bool operator!=(const iterator & other) const {
            return pos_ != other.pos_;
          }

          const std::shared_ptr<Directive>& operator*() const {
            return (*directive_table_ptr_)[pos_];
          }

        private:
          int pos_ = 0;
          std::vector<std::shared_ptr<Directive>>* directive_table_ptr_;

      };

      iterator begin() const {
        return iterator(directive_table_, 0);
      }

      iterator end() const {
        int num_entries = directive_table_->size();
        return iterator(directive_table_, num_entries);
      }

      std::string ToString() {
        std::string ret = "";

        for(auto& directive : *directive_table_) {
          ret += directive->ToString() + "\n";
        }

        return ret;
      }

      void AddDirective(std::shared_ptr<Directive> prag) {
        directive_table_->push_back(prag);
      }

      std::shared_ptr<std::list<std::shared_ptr<Directive>>> FindDirective(std::string var_name) {
        auto ret = std::make_shared<std::list<std::shared_ptr<Directive>>>();

        for(auto& prg : *directive_table_) {
          if(prg->GetVarName() == var_name) {
            ret->push_back(prg); // This is not a bug; Just IDE does not understand auto around here
          }
        }
        return ret;
      }

      int FindDirectiveID(std::string var_name) {
        int ret = -1;
        for(int pos = 0; pos < directive_table_->size(); pos++) {
          if(directive_table_->at(pos)->GetVarName() == var_name && directive_table_->at(pos)->GetClass() != DirectiveClass::CLUSTER) {
            ret = pos;
          }
        }

        return ret;
      }

      void SetDirective(std::shared_ptr<Directive> directive) {
        int targ_idx = -1;
        for(int pos = 0; pos < directive_table_->size(); pos++) {
          if(directive_table_->at(pos)->GetVarName() == directive->GetVarName() && directive_table_->at(pos)->GetClass() != DirectiveClass::CLUSTER) {
            targ_idx = pos;
          }
        }

        if(targ_idx != -1) {
          directive_table_->at(targ_idx) = directive;
        }
      }

      std::shared_ptr<Directive> GetDirective(int pos) {
        std::shared_ptr<Directive> ret = nullptr;
        if(pos < directive_table_->size()) {
          ret = directive_table_->at(pos);
        }

        return ret;
      }

      int GetDirectiveCounts() {
        return directive_table_->size();
      }

      void SetDirective(std::shared_ptr<Directive> new_prag, int pos) {
      	directive_table_->at(pos) = new_prag;
      }

    protected:
      std::shared_ptr<std::vector<std::shared_ptr<Directive>>> directive_table_;


  }; // End of class DirectiveTable

}; // End of namespace maestro

#endif
