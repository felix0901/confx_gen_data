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
			TemporalMap(2,2) K;
			TemporalMap(1,1) C; // TemporalMap(4,4) C;
			TemporalMap(Sz(R),Sz(R)) R;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			Cluster(3,P); // Cluster(Sz(R),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}
}