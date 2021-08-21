Network VGG16 {
	Layer CONV1 {
		Type: CONV
		Dimensions { K: 1, C:1, R: 1, S: 3, Y: 1, X: 9 }
		Dataflow {
            TemporalMap(1,1) K;
            TemporalMap(1,1) C;
            TemporalMap(1,1) Y;
			TemporalMap(1,1) R;
            TemporalMap(3,1) X;
            SpatialMap(3,1) S;
		}
	}
}


//Accelerator {
//  PE { NumPEs: 128; VectorWidth: 4; MultPrecision: INT8, AddPrecision: INT16 }
//  Buffer { GlobalL2: 2048, LocalL1: 64}
//  NoC { TopNoC {Bandwidth: 64; AvgLatency: 2 }
//        BottomNoC {Bandwidth: 4; AvgLatency: 2 }
//      }
//}
