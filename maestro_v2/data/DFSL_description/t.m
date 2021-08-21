Network VGG16 {
	Layer CONV1 {
		Type: CONV
		Dimensions { K: 1, C:1, R: 2, S: 2, Y: 2, X: 7 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
            TemporalMap(2,1) Y;
            SpatialMap(2,1) X;
			TemporalMap(2,2) S;
			TemporalMap(2,2) R;
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
