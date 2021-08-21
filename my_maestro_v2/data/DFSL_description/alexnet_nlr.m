Network alexnet {
Layer CONV1 { 
Type: CONV
Dimensions { K 96,C 3,R 11,S 11,Y 60,X 60 }
Dataflow {
			TemporalMap (4,4) K;
			TemporalMap (1,1) C;
			TemporalMap (1,1) Y;
			TemporalMap (1,1) R;
			TemporalMap (1,1) S;
			SpatialMap (1,1) X;
}
}

Layer CONV2 { 
Type: CONV
Dimensions { K 256,C 48,R 5,S 5,Y 35,X 35 }
Dataflow {
			TemporalMap (4,4) K;
			TemporalMap (1,1) C;
			TemporalMap (1,1) Y;
			TemporalMap (1,1) R;
			TemporalMap (1,1) S;
			SpatialMap (1,1) X;
}
}

Layer CONV3 { 
Type: CONV
Dimensions { K 384,C 256,R 3,S 3,Y 15,X 15 }
Dataflow {
			TemporalMap (4,4) K;
			TemporalMap (1,1) C;
			TemporalMap (1,1) Y;
			TemporalMap (1,1) R;
			TemporalMap (1,1) S;
			SpatialMap (1,1) X;
}
}

Layer CONV4 { 
Type: CONV
Dimensions { K 384,C 192,R 3,S 3,Y 15,X 15 }
Dataflow {
			TemporalMap (4,4) K;
			TemporalMap (1,1) C;
			TemporalMap (1,1) Y;
			TemporalMap (1,1) R;
			TemporalMap (1,1) S;
			SpatialMap (1,1) X;
}
}

Layer CONV5 { 
Type: CONV
Dimensions { K 128,C 192 ,R 3,S 3,Y 15,X 15 }
Dataflow {
			TemporalMap (4,4) K;
			TemporalMap (1,1) C;
			TemporalMap (1,1) Y;
			TemporalMap (1,1) R;
			TemporalMap (1,1) S;
			SpatialMap (1,1) X;
}
}

}
