Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 55, C: 18, R: 5, S: 5, Y: 39, X: 20 }
		Dataflow {
			SpatialMap(2,2) K;
			TemporalMap(2,2) C;
			TemporalMap(8,8) X';
			TemporalMap(5,1) Y;
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			Cluster(2,L);
			TemporalMap(2,2) K;
			SpatialMap(1,1) C;
			TemporalMap(8,8) X';
			TemporalMap(5,1) Y;
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			Cluster(8,P);
			TemporalMap(2,2) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) X';
			TemporalMap(5,1) Y;
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
		}
	}
}

