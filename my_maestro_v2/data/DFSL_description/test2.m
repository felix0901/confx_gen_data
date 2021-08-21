Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 64, C: 1, R: 3, S: 3, Y: 3, X: 3 }
		Dataflow {
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';
			TemporalMap(1,1) C;
			SpatialMap(1,1) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
		}
	}
}


//Accelerator {
//  PE { NumPEs: 128; VectorWidth: 4; MultPrecision: INT8, AddPrecision: INT16 }
//  Buffer { GlobalL2: 2048, LocalL1: 64}
//  NoC {Bandwidth: 64; AvgLatency: 2}
//}
