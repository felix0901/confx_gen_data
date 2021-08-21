Network ActivityNet {
Layer CONV2D { 
Type: CONV
Dimensions { K 64,C 3,R 7,S 7,Y 150,X 150 }
Dataflow {
			TemporalMap(7,1) Y;
			TemporalMap(7,1) X;
			TemporalMap(4,4) C;
			SpatialMap(1,1) K;
			TemporalMap(7,7) R;
			TemporalMap(7,7) S;
			Cluster(7, P);
			SpatialMap(1,1) R;
			SpatialMap(1,1) Y;
			Cluster(7, P);
			SpatialMap(1,1) S;
			SpatialMap(1,1) X;
}
}


Layer BottleNeck0_CONV2D { 
Type: CONV
Dimensions { K 64,C 64,R 1,S 1,Y 75,X 75 }
Dataflow {
			TemporalMap(1,1) Y;
			TemporalMap(1,1) X;
			TemporalMap(4,4) C;
			SpatialMap(1,1) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
}
}


Layer BottleNeck0_CONV2D { 
Type: CONV
Dimensions { K 64,C 64,R 3,S 3,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck0_CONV2D { 
Type: CONV
Dimensions { K 256,C 64,R 1,S 1,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck1_CONV2D { 
Type: CONV
Dimensions { K 64,C 256,R 1,S 1,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck1_CONV2D { 
Type: CONV
Dimensions { K 64,C 64,R 3,S 3,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck1_CONV2D { 
Type: CONV
Dimensions { K 256,C 64,R 1,S 1,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck2_CONV2D { 
Type: CONV
Dimensions { K 64,C 256,R 1,S 1,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck2_CONV2D { 
Type: CONV
Dimensions { K 64,C 64,R 3,S 3,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck2_CONV2D { 
Type: CONV
Dimensions { K 256,C 64,R 1,S 1,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck3_CONV2D { 
Type: CONV
Dimensions { K 256,C 64,R 1,S 1,Y 75,X 75 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck4_CONV2D { 
Type: CONV
Dimensions { K 128,C 128,R 3,S 3,Y 33,X 33 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck4_CONV2D { 
Type: CONV
Dimensions { K 128,C 128,R 3,S 3,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck4_CONV2D { 
Type: CONV
Dimensions { K 128,C 128,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck5_CONV2D { 
Type: CONV
Dimensions { K 512,C 256,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck6_CONV2D { 
Type: CONV
Dimensions { K 128,C 512,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck6_CONV2D { 
Type: CONV
Dimensions { K 128,C 128,R 3,S 3,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck6_CONV2D { 
Type: CONV
Dimensions { K 512,C 128,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck7_CONV2D { 
Type: CONV
Dimensions { K 128,C 512,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck7_CONV2D { 
Type: CONV
Dimensions { K 128,C 128,R 3,S 3,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck7_CONV2D { 
Type: CONV
Dimensions { K 512,C 128,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}




Layer BottleNeck8_CONV2D { 
Type: CONV
Dimensions { K 128,C 512,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck8_CONV2D { 
Type: CONV
Dimensions { K 128,C 128,R 3,S 3,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck8_CONV2D { 
Type: CONV
Dimensions { K 512,C 128,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}




Layer BottleNeck9_CONV2D { 
Type: CONV
Dimensions { K 256,C 512,R 1,S 1,Y 38,X 38 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck9_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck9_CONV2D { 
Type: CONV
Dimensions { K 512,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck9_DownSample_CONV2D { 
Type: CONV
Dimensions { K 1024,C 512,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}




Layer BottleNeck10_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck10_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck10_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck11_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck11_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck11_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck12_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck12_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck12_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}






Layer BottleNeck13_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck13_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck13_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck14_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck14_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck14_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}




Layer BottleNeck15_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck15_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck15_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}





Layer BottleNeck16_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck16_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck16_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck17_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck17_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck17_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck18_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck18_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck18_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}





Layer BottleNeck19_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck19_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck19_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}






Layer BottleNeck20_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck20_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck20_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}








Layer BottleNeck21_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck21_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck21_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}






Layer BottleNeck22_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck22_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck22_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck23_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck23_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck23_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}







Layer BottleNeck24_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck24_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck24_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}







Layer BottleNeck25_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck25_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck25_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}






Layer BottleNeck26_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck26_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck26_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}








Layer BottleNeck27_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck27_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(3,3) R;
			TemporalMap(3,3) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}

Layer BottleNeck27_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}





Layer BottleNeck28_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck28_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck28_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck29_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck29_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck29_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}








Layer BottleNeck30_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck30_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck30_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



Layer BottleNeck31_CONV2D { 
Type: CONV
Dimensions { K 256,C 1024,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer BottleNeck31_CONV2D { 
Type: CONV
Dimensions { K 256,C 256,R 3,S 3,Y 19,X 19 }
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

Layer BottleNeck31_CONV2D { 
Type: CONV
Dimensions { K 1024,C 256,R 1,S 1,Y 19,X 19 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer RPN_CONV2D { 
Type: CONV
Dimensions { K 512,C 1024,R 3,S 3,Y 19,X 19 }
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



Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 512,C 1024,R 1,S 1,Y 7,X 7 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 512,C 512,R 3,S 3,Y 4,X 4 }
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


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 2048,C 512,R 1,S 1,Y 4,X 4 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 512,C 2048,R 1,S 1,Y 4,X 4 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 512,C 512,R 3,S 3,Y 4,X 4 }
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


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 2048,C 512,R 1,S 1,Y 4,X 4 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 512,C 2048,R 1,S 1,Y 4,X 4 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 512,C 512,R 3,S 3,Y 4,X 4 }
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


Layer Classification_CONV2D { 
Type: CONV
Dimensions { K 2048,C 512,R 1,S 1,Y 4,X 4 }
Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(64,64) K;
			TemporalMap(1,1) R;
			TemporalMap(1,1) S;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
			Cluster(64, P);
			SpatialMap(1,1) K;
}
}



}
