
Network MobileNetV2 {
	Layer CONV1 {
		Type: CONV
		Stride { X: 2, Y: 2 }		
		Dimensions { K: 32, C: 3, R: 1, S: 1, Y:224, X:224 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(3,3) C;
			TemporalMap(3,3) R;
			SpatialMap(SZ(R),1) Y;
			TemporalMap(SZ(S),1) X;
			Cluster(3,P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer Bottleneck1_1_1 {
		Type: CONV
		Stride { X: 2, Y: 2 }		
		Dimensions { K: 32, C: 3, R: 1, S: 1, Y:112, X:112 }
	}




}
