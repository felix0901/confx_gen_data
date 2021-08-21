Network Lab5 {
	Layer CONV4 {
		Type: CONV
		Dimensions { K: 128, C: 128, R: 3, S: 3, Y: 112, X: 112 }
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

