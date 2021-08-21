// BLAS 3 - Dense Matrix-Dense Matrix multiplication
Constant SzM 100;
Constant SzN 100;
Constant SzK 100;


Network BLAS3 {
	Layer BLAS {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { K: SzN, C: 1, R: 1, S: SzK, Y: SzM, X: SzK }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap (1,1) C; // TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}
}