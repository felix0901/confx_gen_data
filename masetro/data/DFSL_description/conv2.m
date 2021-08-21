Network Lab5 {
	Layer CONV2 {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 3, S: 3, Y: 224, X: 224 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			TemporalMap(3,1) Y;
			SpatialMap(3,1) X;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
		}
	}
}

