
Network Resnet50 {

	Layer FC1000 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { K: 1000, C: 2048, R: 7, S: 7, Y: 7, X: 7 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			TemporalMap(Sz(R),Sz(R)) R;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			Cluster(7,P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}

}