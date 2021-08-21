Constant NumBatches 32;
Constant ClusterSz 64;
Constant NTileSz 1;
Constant KTileSz 1;
Constant CTileSz 64;
Constant YTileSz 32;
Constant XTileSz 32;

Network Resnet50 {
	Layer CONV1 {
		Type: CONV
		Stride { X: 2, Y: 2 }		
		Dimensions { N: NumBatches, K: 64, C: 3, R: 7, S: 7, Y:224, X:224 }
		Dataflow {
			TemporalMap(NTileSz,NTileSz) N;
			SpatialMap(1,1) K;
			TemporalMap(ClusterSz,ClusterSz) C;
			TemporalMap(YTileSz,1) Y';
			TemporalMap(XTileSz,1) X';	
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(ClusterSz, P);
			TemporalMap(NTileSz,NTileSz) N;			
			SpatialMap(1,1) C;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer CONV2_1_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 64, C: 64, R: 1, S: 1, Y: 56, X: 56 }
		Dataflow {
			SpatialMap(NTileSz,NTileSz) N;
			TemporalMap(KTileSz,KTileSz) K;
			TemporalMap(CTileSz,CTileSz) C;
			TemporalMap(YTileSz,YTileSz) Y';
			TemporalMap(XTileSz,XTileSz) X';	
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(ClusterSz, P);
			TemporalMap(1,1) N;			
			SpatialMap(1,1) C;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}

}