Network BLAS3 {
	Layer FC {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { K: 10, C: 1, R: 1, S: 10, Y: 10, X: 10 }
		Dataflow {
			TemporalMap (1,1) K;
			TemporalMap (1,1) C;
			TemporalMap (Sz(R),1) Y;
			SpatialMap (Sz(S),1) X;
			TemporalMap (Sz(R),Sz(R)) R;
			TemporalMap (Sz(S),Sz(S)) S;
		}
	}
}