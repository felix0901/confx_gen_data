Network VGG16 {
	Layer CONV1 {
	Type: CONV
	Stride { X: 2, Y: 2 }		
	Dimensions { K: 32, C: 3, R: 1, S: 1, Y':56, X':7 }
	Dataflow {
		SpatialMap(4,4) K
		TemporalMap(3,3) C
		TemporalMap(1,1) X'
		TemporalMap(28,28) Y'
		TemporalMap(1,1) R
		TemporalMap(1,1) S
		Cluster(3,L)
		TemporalMap(4,4) K
		SpatialMap(1,1) C
		TemporalMap(1,1) X'
		TemporalMap(28,28) Y'
		TemporalMap(1,1) R
		TemporalMap(1,1) S
		Cluster(7,P)
		TemporalMap(4,4) K
		TemporalMap(1,1) C
		TemporalMap(1,1) X'
		SpatialMap(2,2) Y'
		TemporalMap(1,1) R
		TemporalMap(1,1) S
	}
}
}
