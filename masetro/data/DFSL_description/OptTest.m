Network VGG16 {
	Layer CONV1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { K: 64, C:3, R: 3, S: 3, Y: 224, X: 224 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(64,64) X';
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			Cluster(64, P);
			TemporalMap(1,1) Y'
			SpatialMap(1,1) X';
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
		}
	}

	Layer CONV13 {
		Type: CONV
		Dimensions { K: 512, C: 512, R: 3, S: 3, Y: 14, X: 14 }
		Dataflow {
			TemporalMap(64,64) K;			
			SpatialMap(1,1) C;
			TemporalMap(3,1) Y;
			TemporalMap(3,1) X;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			Cluster(64, P);
			SpatialMap(1,1) K;		}
	}
}


//Accelerator {
//  PE { NumPEs: 128; VectorWidth: 4; MultPrecision: INT8, AddPrecision: INT16 }
//  Buffer { GlobalL2: 2048, LocalL1: 64}
//  NoC {Bandwidth: 64; AvgLatency: 2}
//}
