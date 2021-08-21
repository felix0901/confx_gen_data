Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 2, C: 2, R: 5, S: 5, Y: 5, X: 12 }
		Dataflow {
			SpatialMap(2,2) K;
			TemporalMap(2,2) C;
			TemporalMap(10,6) X;
			TemporalMap(5,1) Y;
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
		}
	}
}

