Accelerator ExampleAccelerator {

  ComputeUnitCluster TopLevelCluster {
    Level: 2
    NumInstances: 2
    NumSubClusters: 32

    Buffer InputGlobalBuffer {
      Tensor: Input
      Type: ScratchPad
      Size: 512
    }

    Buffer FilterGlobalBuffer {
      Tensor: Filter
      Type: ScratchPad
      Size: 512
    }

    Buffer OutputGlobalBuffer {
      Tensor: Output
      Type: ScratchPad
      Size: 512
    }

    DistributionNoC TopNoC {
      Tensor: Input
      Type: Bus
      Bandwidth: 32
      AvgNumHops: 1
      LatencyPerHop: 1
    }

    ReductionNoC TopReductionNoC {
      Type: AdderTree
      AvgNumHops: 1
      LatencyPerHop: 1
    }
  }

  ComputeUnitCluster InnerMostCluster {
    Level: 1
    NumInstances: 4    
    NumSubClusters: 64

    Buffer InputClusterBuffer {
      Tensor: Input
      Type: ScratchPad
      Size: 64
    }

    Buffer FilterClusterBuffer {
      Tensor: Filter
      Type: ScratchPad
      Size: 64
    }

    Buffer OutputClusterBuffer {
      Tensor: Output
      Type: ScratchPad
      Size: 64
    }


    DistributionNoC BottomDistributionNoC {
      Type: Bus
      Bandwidth: 16
      AvgNumHops: 1
      LatencyPerHop: 1
    }

    ReductionNoC BottomReductionNoC {
      Type: AdderTree
      Bandwidth: 16
      AvgNumHops: 1
      LatencyPerHop: 1
    }

  }

  ComputeUnitCluster PE {
    Level: 0
    NumInstances: 1    
    NumSubClusters: 1

    Buffer InputLocalBuffer {
      Tensor: Input
      Type: FIFO
      Size: 4
    }

    Buffer FilterLocalBuffer {
      Tensor: Filter
      Type: FIFO
      Size: 4
    }

    Buffer OutputLocalBuffer {
      Tensor: Output
      Type: FIFO
      Size: 4
    }

    DistributionNoC OperandNoC {
      Type: Bus
      Bandwidth: 1
      AvgNumHops: 1
      LatencyPerHop: 1
    }

    ReductionNoC OperandReductionNoC {
      Type: Bus
      Bandwidth: 1
      AvgNumHops: 1
      LatencyPerHop: 1
    }

  }

}
