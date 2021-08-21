Network NestedGroupedConvolution {
	Layer NGCONV1 {
		Type: NGCONV
		Dimensions { G: 32, K: 1, C: 64, R: 3, S: 3, Y: 3, X: 3 }
		Dataflow {
			TemporalMap(1,1) G;
			SpatialMap(1,1) C;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}
}

