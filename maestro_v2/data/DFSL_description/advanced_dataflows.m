

// WS++
TemporalMap(1,1) K;
TemporalMap(3,3) R;
TemporalMap(3,3) S;
TemporalMap(1,1) C;
TemporalMap(16,16) X';
SpatialMap(1,1) Y';
Cluster(16, P);
TemporalMap(1,1) K;
TemporalMap(1,1) C;
TemporalMap(1,1) Y';
SpatialMap(1,1) X';
TemporalMap(3,3) R;
TemporalMap(3,3) S;

// IS++
TemporalMap(1,1) K;
TemporalMap(16,16) Y';
TemporalMap(3,1) X';
SpatialMap(1,1) C;
TemporalMap(3,3) R;
TemporalMap(3,3) S;
Cluster(16, P);
TemporalMap(1,1) C;
SpatialMap(1,1) Y';
TemporalMap(3,1) X;
TemporalMap(1,1) K;
TemporalMap(3,3) R;
TemporalMap(3,3) S;

//TPU 
SpatialMap(1,1) K;
TemporalMap(var,var) C;
TemporalMap(Sz(R),1) Y;
TemporalMap(Sz(S),1) X;
TemporalMap(3,3) R;
TemporalMap(3,3) S;


// OS+
TemporalMap(16,16) K;
SpatialMap(3,1) Y;
TemporalMap(3,1) X;
TemporalMap(3,1) C;
Cluster(16, P);
SpatialMap(1,1) K;
TemporalMap(3,1) Y;
TemporalMap(3,1) X;
TemporalMap(3,3) R;
TemporalMap(3,3) S;



// Hand-optimized 1
TemporalMap (1,1) C;
SpatialMap (3,1) Y;
TemporalMap(66,64) X;
TemporalMap(1,1) K;
TemporalMap(3,3) R;
TemporalMap(3,3) S;
Cluster(64, P);
TemporalMap(1,1) K;
TemporalMap(1,1) C;
TemporalMap(3,1) Y;
SpatialMap(3,1) X;
TemporalMap(3,3) R;
TemporalMap(3,3) S;


// Hand-optimized 2
TemporalMap(1,1) C;
TemporalMap(18,16) Y;
TemporalMap(18,16) X;
SpatialMap(1,1) K;
TemporalMap(3,3) R;
TemporalMap(3,3) S;
Cluster(16 ,P);
SpatialMap(3,1) Y;
TemporalMap(18,16) X;
TemporalMap(1,1) C;
TemporalMap(1,1) K;
TemporalMap(3,3) R;
TemporalMap(3,3) S;
Cluster(16, P);
TemporalMap(1,1) K;
TemporalMap(1,1) C;
TemporalMap(3,1) Y;
SpatialMap(3,1) X;
TemporalMap(3,3) R;
TemporalMap(3,3) S;

