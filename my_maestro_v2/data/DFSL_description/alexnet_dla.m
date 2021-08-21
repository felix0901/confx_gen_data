Network alexnet {

Layer CONV2 { 
Type: CONV
Dimensions { K 256,C 48,R 5,S 5,Y 35,X 35 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
			TemporalMap(5,5) R;
			TemporalMap(5,5) S;
}
}

Layer CONV3 { 
Type: CONV
Dimensions { K 384,C 256,R 3,S 3,Y 15,X 15 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
}
}

Layer CONV4 { 
Type: CONV
Dimensions { K 384,C 192,R 3,S 3,Y 15,X 15 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
}
}

Layer CONV5 { 
Type: CONV
Dimensions { K 128,C 192 ,R 3,S 3,Y 15,X 15 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
}
}

}
