Network VGG16 {
	Layer CONV1 {
		Type: CONV
		Dimensions { K: 21, C:20, R: 5, S: 5, Y: 35, X: 35 }
		Dataflow {
			SpatialMap(3,3) K;
			TemporalMap(16,16) C;
			TemporalMap(35,35) X;
			TemporalMap(5,5) Y;
			TemporalMap(1,1) S;
			TemporalMap(1,1) R;
			Cluster(4,L);
			TemporalMap(3,3) K;
			SpatialMap(4,4) C;
			TemporalMap(35,35) X;
			TemporalMap(5,5) Y;
			TemporalMap(1,1) S;
			TemporalMap(1,1) R;
			Cluster(35,P);
			TemporalMap(3,3) K;
			TemporalMap(4,4) C;
			SpatialMap(1,1) X;
			TemporalMap(5,5) Y;
			TemporalMap(1,1) S;
			TemporalMap(1,1) R;
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
