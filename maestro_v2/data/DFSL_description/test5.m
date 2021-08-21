Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 16, C: 24, R: 5, S: 5, Y: 35, X: 35 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(6,6) C;
			TemporalMap(28,28) X';
			TemporalMap(1,1) Y';
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			Cluster(6,L);
			TemporalMap(1,1) K;
			SpatialMap(1,1) C;
			TemporalMap(28,28) X';
			TemporalMap(1,1) Y';
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			Cluster(28,P);
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) X';
			TemporalMap(1,1) Y';
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
		}
	}
}


//Accelerator {
//  PE { NumPEs: 128; VectorWidth: 4; MultPrecision: INT8, AddPrecision: INT16 }
//  Buffer { GlobalL2: 2048, LocalL1: 64}
//  NoC {Bandwidth: 64; AvgLatency: 2}
//}

