Network TEST {
  Layer CONV1 {
      Type: CONV
        Dimensions { K: 40, C: 49, R: 3, S: 3, Y': 14, X': 14 }
        Dataflow {
			SpatialMap(1,1) K
			TemporalMap(32,32) C
			TemporalMap(8,8) X'
			TemporalMap(1,1) Y'
			TemporalMap(3,3) R
			TemporalMap(3,3) S
			Cluster(32,L)
			TemporalMap(1,1) K
			SpatialMap(1,1) C
			TemporalMap(8,8) X'
			TemporalMap(1,1) Y'
			TemporalMap(3,3) R
			TemporalMap(3,3) S
			Cluster(8,P)
			TemporalMap(1,1) K
			TemporalMap(1,1) C
			SpatialMap(1,1) X'
			TemporalMap(1,1) Y'
			TemporalMap(3,3) R
			TemporalMap(3,3) S
    }
  }
}
