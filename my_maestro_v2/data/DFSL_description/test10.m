Network VGG16 {
  Layer CONV13 {
    Type: CONV
      Dimensions { K: 16, C: 24, R: 5, S: 5, Y: 35, X: 35 }
        Dataflow {
          SpatialMap(3,3) K;
          TemporalMap(12,12) C;
          TemporalMap(28,28) X';
          TemporalMap(36,36) Y';
          TemporalMap(5,5) R;
          TemporalMap(5,5) S;
          Cluster(6,L);
          TemporalMap(3,3) K;
          SpatialMap(3,3) C;
          TemporalMap(28,28) X';
          TemporalMap(36,36) Y';
          TemporalMap(5,5) R;
          TemporalMap(5,5) S;
          Cluster(28,P);
          TemporalMap(3,3) K;
          TemporalMap(2,2) C;
          SpatialMap(2,2) X';
          TemporalMap(40,40) Y';
          TemporalMap(5,5) R;
          TemporalMap(5,5) S;
    }
  }
}
