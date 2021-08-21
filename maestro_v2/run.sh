./maestro --operation_mode=CostEval \
          --print_res=true \
          --print_res_csv_file=true \
          --print_log_file=true \
          --HW_file='data/hardware/example_acc.m' \
          --DFSL_file='1.m' \
          --noc_bw=1000 \
          --noc_hops=1 \
          --noc_mc_support=true \
          --noc_hop_latency=1 \
          --num_simd_lanes=1 \
          --l1_size=81920000 \
          --l2_size=204800 \
          --num_pes=100 \
          --print_design_space=true \
          --msg_print_lv=0 

