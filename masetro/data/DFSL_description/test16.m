Network TestNet {
	Layer CONV5_1_3_Tiled_DLA {
		Type: CONV
		Dimensions { K: 128, C: 257, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(4,4) K;
			SpatialMap(4,4) C;
			TemporalMap(7,7) Y';
			TemporalMap(7,7) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(S), Sz(S)) S;
			Cluster(4, P);
			SpatialMap(1,1) K;
			TemporalMap(4,4) C;
			TemporalMap(7,7) Y';
			TemporalMap(7,7) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(S), Sz(S)) S;
		}
	}	
}
