// Matrix-Matrix multiplication
 Constant SzM 10;
 Constant SzN 10;
 Constant SzK 10;

// Matrix-vector multiplication
//Constant SzM 10;
//Constant SzN 1;
//Constant SzK 10;

// Dot product
// Constant SzM 1;
// Constant SzN 1;
// Constant SzK 10;



Network BLAS_Example {
	Layer BLAS {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { K: SzN, C: 1, R: 1, S: SzK, Y: SzM, X: SzK }
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