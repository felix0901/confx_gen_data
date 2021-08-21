Network Lab5 {
	Layer CONV11 {
		Type: CONV
		Dimensions { K: 512, C: 512, R: 3, S: 3, Y: 14, X: 14 }
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

