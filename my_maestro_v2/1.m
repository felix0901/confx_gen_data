Constant ClusterSz 16;
Network dla {
Layer CONV {
Type: CONV
Dimensions { K: 16, C: 16, Y: 128, X: 128, R: 5, S: 5 }
Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(ClusterSz,ClusterSz) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			Cluster(ClusterSz, P);
			SpatialMap(1,1) C;
			Cluster(ClusterSz, P);
			SpatialMap(1,1) K;

}
}
