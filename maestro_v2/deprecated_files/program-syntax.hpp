#ifndef MAESTRO_PROGRAM_SYNTAX_HPP_
#define MAESTRO_PROGRAM_SYNTAX_HPP_

#include <string>

namespace maestro {

  enum class BinaryOp {
    ADD,
    SUB,
    MUL,
    DIV,
    INVALID
  };

  class Expression {
    protected:

    public:
      virtual ~Expression() {}

      virtual std::string GetName() {
        return "";
      }

  };

  class Container : public Expression {
    protected:
      std::string name_;
      std::vector<int> dimension_size_;
    public:
      Container(std::string name) :
        name_(name),
        dimension_size_(1) {
      }

      Container(std::string name, std::vector<int>& dim_size) :
        name_(name),
        dimension_size_(dim_size) {
      }

      virtual ~Container() {}

      virtual std::string GetName() {return name_;}
  };

  class Variable : public Container {
    protected:

    public:
      Variable(std::string name) :
        Container(name) {
      }

      virtual std::string GetName() {return name_;}
  };

  class Tensor : public Container {
    protected:
      std::string name_;
    public:
      Tensor(std::string name, std::vector<int>& dim_size) :
        Container(name, dim_size)
      {

      }
  };


  class Statement {
    protected:

    public:

  }; // End of class Statement

  class ForLoop : public Statement {
    protected:
      int loop_base;
      int loop_bound;
      int incremental;

    public:

  }; // End of class ForLoop

}; // End of namespace maestro

#endif
