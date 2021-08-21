#ifndef MAESTRO_NOC_MODEL_HPP_
#define MAESTRO_NOC_MODEL_HPP_

namespace maestro {

  class NetworkOnChipModel {
    protected:
      int bandwidth_;
      int num_average_hops_;
      int latency_per_hops_;
      bool multicast_support_;

    public:
      NetworkOnChipModel(int bw, int hops, int hop_latency ,bool mc) :
        bandwidth_(bw),
        num_average_hops_(hops),
        latency_per_hops_(hop_latency),
        multicast_support_(mc)
      {
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
  }; // End of class NetworkOnChipModel

}; // End of namespace maestro
#endif
