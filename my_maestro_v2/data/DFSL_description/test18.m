
Network Resnet50 {
	Layer CONV1 {
		Type: CONV
		Dimensions { N: 16, K: 64, C: 3, R: 7, S: 7, Y:224, X:224 }
		Dataflow {
			SpatialMap(1,1) X';
			TemporalMap(1,1) N;
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			TemporalMap(1,1) Y';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}
}