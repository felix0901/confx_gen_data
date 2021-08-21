Network Lab5 {
	Layer CONV8 {
		Type: CONV
		Dimensions { K: 512, C: 256, R: 3, S: 3, Y: 28, X: 28 }
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

