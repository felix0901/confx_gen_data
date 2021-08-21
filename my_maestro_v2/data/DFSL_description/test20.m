Network VGG16 {
	Layer testLayer {
		Type: CONV
		Dimensions { K: 32, C: 6, R: 3, S: 3, Y: 10, X: 10 }
		Dataflow {
            SpatialMap(1,1) K;
            TemporalMap(64,64) C;
            TemporalMap(Sz(R), Sz(R)) R;
            TemporalMap(Sz(S), Sz(S)) S;
            TemporalMap(Sz(R), 1) Y;
            TemporalMap(Sz(S), 1) X;
			Cluster(64,P);
			SpatialMap(1,1) C;
		}
	}
}
