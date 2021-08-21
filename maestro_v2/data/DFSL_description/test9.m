Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 16, C: 24, R: 5, S: 5, Y: 35, X: 35 }
		Dataflow {
      SpatialMap(3,3) K;
      TemporalMap(6,6) C;
      TemporalMap(28,28) X';
      TemporalMap(1,1) Y';
      TemporalMap(5,5) R;
      TemporalMap(5,5) S;
      Cluster(6,L);
      TemporalMap(3,3) K;
      SpatialMap(1,1) C;
      TemporalMap(28,28) X';
      TemporalMap(1,1) Y';
      TemporalMap(5,5) R;
      TemporalMap(5,5) S;
      Cluster(28,P);
      TemporalMap(3,3) K;
      TemporalMap(1,1) C;
      SpatialMap(1,1) X';
      TemporalMap(1,1) Y';
      TemporalMap(5,5) R;
      TemporalMap(5,5) S;
		}
	}
}

