Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 16, C: 24, R: 5, S: 5, Y: 35, X: 35 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(24,24) C;
			TemporalMap(28,28) X'
			TemporalMap(1,1) Y';
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			Cluster(12,L);
			TemporalMap(1,1) K;
			SpatialMap(2,2) C;
			TemporalMap(28,28) X';
			TemporalMap(1,1) Y';
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			Cluster(14,P);
			TemporalMap(1,1) K;
			TemporalMap(2,2) C;
			SpatialMap(2,2) X';
			TemporalMap(1,1) Y';
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
		}
	}
}



