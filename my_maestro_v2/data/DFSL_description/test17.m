Network TestNet {
	Layer CONV1 {
		Type: CONV
		Dimensions { K: 32, C: 3, R: 1, S: 1, Y': 7, X': 56 }
		Dataflow {
			SpatialMap(4,4) K
			TemporalMap(3,3) C
			TemporalMap(28,28) X'
			TemporalMap(1,1) Y'
			TemporalMap(1,1) R
			TemporalMap(1,1) S
			Cluster(3,L)
			TemporalMap(4,4) K
			SpatialMap(1,1) C
			TemporalMap(28,28) X'
			TemporalMap(1,1) Y'
			TemporalMap(1,1) R
			TemporalMap(1,1) S
			Cluster(7,P)
			TemporalMap(4,4) K
			TemporalMap(1,1) C
			SpatialMap(4,4) X'
			TemporalMap(1,1) Y'
			TemporalMap(1,1) R
			TemporalMap(1,1) S
		}
	}
}
