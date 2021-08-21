Network vgg16 {
Layer CONV1 { 
Type: CONV
Dimensions { K 64,C 3,R 3,S 3,Y 224,X 224 }
Dataflow {
            TemporalMap(3,3) R;
            TemporalMap(3,3) S;
            TemporalMap(1,1) K;
            TemporalMap(3,3) C;
            TemporalMap(16,14) Y;
            SpatialMap(3,1) X;
		Cluster(3, P);
            TemporalMap(3,1) X;
            TemporalMap(3,1) Y;            
            TemporalMap(1,1) K;
            SpatialMap(1,1) C;
		TemporalMap(3,3) R;
            TemporalMap(3,3) S;
    }
}


Layer CONV8 { 
Type: CONV
Dimensions { K: 512, C: 256, R: 3, S: 3, Y: 28, X: 28 }
Dataflow {
            TemporalMap(3,3) R;
            TemporalMap(3,3) S;
            TemporalMap(1,1) K;
            TemporalMap(16,16) C;
            TemporalMap(14,12) Y;
            SpatialMap(3,1) X;
            Cluster(16, P);
            TemporalMap(3,1) X;
            TemporalMap(3,1) Y;            
            TemporalMap(1,1) K;
            SpatialMap(1,1) C;
            TemporalMap(3,3) R;
            TemporalMap(3,3) S;
    }
}


}
