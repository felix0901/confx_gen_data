#ifndef MAESTRO_DSE_SPEC_HPP_
#define MAESTRO_DSE_SPEC_HPP_

#include<cmath>

namespace maestro {
  namespace DSE {
    class HWSpec_28nm {
      public:


      protected:


    }; // End of class HWSpec_28nm

    class SRAM_Spec {
      public:
        bool inited_ = false;
        int unit_size_;
        double unit_area_;
        double unit_power_;

        SRAM_Spec(int unit_size, double unit_area, double unit_power) :
          inited_(true), unit_size_(unit_size), unit_area_(unit_area), unit_power_(unit_power) {
        }

        double EstimateArea(int size) {
          return GetNumCells(size) * unit_area_;
        }

        double EstimatePower(int size) {
          return GetNumCells(size) * unit_power_;
        }


      private:
        double GetNumCells(int targ_size) {
          double num_cells = static_cast<double>(targ_size) / static_cast<double>(unit_size_);
          return ceil(num_cells);
        }

    };

    class

  };// End of namespace DSE

}; // End of namespace MAESTRO

#endif
