Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 16, C: 24, R: 5, S: 5, Y: 35, X: 35 }
		Dataflow {
      SpatialMap(1,1) K;
      TemporalMap(24,24) C;
      TemporalMap(23,23) X';
      TemporalMap(1,1) Y';
      TemporalMap(5,5) R;
      TemporalMap(5,5) S;
      Cluster(24,L);
      TemporalMap(1,1) K;
      SpatialMap(1,1) C;
      TemporalMap(23,23) X';
      TemporalMap(1,1) Y';
      TemporalMap(5,5) R;
      TemporalMap(5,5) S;
      Cluster(7,P);
      TemporalMap(1,1) K;
      TemporalMap(1,1) C;
      SpatialMap(3,3) X';
      TemporalMap(1,1) Y';
      TemporalMap(5,5) R;
      TemporalMap(5,5) S;
		}
	}
}



