Network VGG16 {
	Layer CONV13 {
		Type: CONV
		Dimensions { K: 256, C: 256, R: 3, S: 3, Y: 224, X: 224 }
		Dataflow {
			SpatialMap(2,2) C
			TemporalMap(12,12) K
			TemporalMap(6,2) X
			TemporalMap(5,1) Y
			TemporalMap(5,5) R
			TemporalMap(5,5) S
			Cluster(12,L)
			TemporalMap(2,2) C
			SpatialMap(1,1) K
			TemporalMap(6,2) X
			TemporalMap(5,1) Y
			TemporalMap(5,5) R
			TemporalMap(5,5) S
			Cluster(2,P)
			TemporalMap(2,2) C
			TemporalMap(1,1) K
			SpatialMap(5,1) X
			TemporalMap(5,1) Y
			TemporalMap(5,5) R
			TemporalMap(5,5) S
		}
	}
}


//Accelerator {
//  PE { NumPEs: 128; VectorWidth: 4; MultPrecision: INT8, AddPrecision: INT16 }
//  Buffer { GlobalL2: 2048, LocalL1: 64}
//  NoC {Bandwidth: 64; AvgLatency: 2}
//}
