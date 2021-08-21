Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14  }
		Dataflow {
			TemporalMap(2,2) C;
			TemporalMap(1,1) K;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			Cluster(Sz(R),P);
			SpatialMap(1,1) Y;
			SpatialMap(1,1) R;
		}
	}
}