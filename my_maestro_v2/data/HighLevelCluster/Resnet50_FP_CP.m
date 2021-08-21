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


	Layer CONV2_1_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 64, C: 64, R: 3, S: 3, Y: 56, X: 56 }
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


	Layer CONV2_1_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 64, R: 1, S: 1, Y: 56, X: 56 }
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

	Layer CONV2_1_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 256, R: 1, S: 1, Y: 56, X: 56 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer CONV2_2_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 64, C: 256, R: 1, S: 1, Y: 56, X: 56 }
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


	Layer CONV2_2_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 64, C: 64, R: 3, S: 3, Y: 56, X: 56 }
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


	Layer CONV2_2_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 64, R: 1, S: 1, Y: 56, X: 56 }
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


	Layer CONV2_2_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 256, R: 1, S: 1, Y: 56, X: 56 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer CONV2_3_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 64, C: 256, R: 1, S: 1, Y: 56, X: 56 }
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


	Layer CONV2_3_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 64, C: 64, R: 3, S: 3, Y: 56, X: 56 }
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


	Layer CONV2_3_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 64, R: 1, S: 1, Y: 56, X: 56 }
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


	Layer CONV2_3_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 256, R: 1, S: 1, Y: 56, X: 56 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer CONV3_1_1 {
		Type: CONV
		Stride { X: 2, Y: 2 }		
		Dimensions { N: NumBatches, K: 128, C: 256, R: 1, S: 1, Y: 56, X: 56 }
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


	Layer CONV3_1_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 128, C: 128, R: 3, S: 3, Y: 28, X: 28 }
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


	Layer CONV3_1_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 128, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_1_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 512, R: 1, S: 1, Y: 28, X: 28 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV3_2_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 128, C: 256, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_2_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 128, C: 128, R: 3, S: 3, Y: 28, X: 28 }
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


	Layer CONV3_2_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 128, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_1_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 512, R: 1, S: 1, Y: 28, X: 28 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer CONV3_3_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 128, C: 256, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_3_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 128, C: 128, R: 3, S: 3, Y: 28, X: 28 }
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


	Layer CONV3_3_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 128, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_3_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 512, R: 1, S: 1, Y: 28, X: 28 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV3_4_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 128, C: 256, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_4_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 128, C: 128, R: 3, S: 3, Y: 28, X: 28 }
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


	Layer CONV3_4_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 128, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV3_4_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 512, R: 1, S: 1, Y: 28, X: 28 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV4_1_1 {
		Type: CONV
		Stride { X: 2, Y: 2 }
		Dimensions { N: NumBatches, K: 256, C: 512, R: 1, S: 1, Y: 28, X: 28 }
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


	Layer CONV4_1_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14 }
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


	Layer CONV4_1_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1024, C: 256, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_1_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV4_2_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 256, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_2_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14 }
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


	Layer CONV4_2_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1024, C: 256, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_2_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV4_3_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 256, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_3_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14 }
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


	Layer CONV4_3_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1024, C: 256, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_3_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV4_4_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 256, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_4_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14 }
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


	Layer CONV4_4_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1024, C: 256, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_4_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV4_5_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 256, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_5_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14 }
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


	Layer CONV4_5_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1024, C: 256, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_5_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}




	Layer CONV4_6_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 256, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_6_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 14, X: 14 }
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


	Layer CONV4_6_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1024, C: 256, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV4_6_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV5_1_1 {
		Type: CONV
		Stride { X: 2, Y: 2 }
		Dimensions { N: NumBatches, K: 512, C: 1024, R: 1, S: 1, Y: 14, X: 14 }
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


	Layer CONV5_1_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 512, R: 3, S: 3, Y: 7, X: 7 }
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


	Layer CONV5_1_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 2048, C: 512, R: 1, S: 1, Y: 7, X: 7 }
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


	Layer CONV5_1_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 2048, R: 1, S: 1, Y: 7, X: 7 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer CONV5_2_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 512, C: 2048, R: 1, S: 1, Y: 7, X: 7 }
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


	Layer CONV5_2_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 512, R: 3, S: 3, Y: 7, X: 7 }
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


	Layer CONV5_2_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 2048, C: 512, R: 1, S: 1, Y: 7, X: 7 }
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


	Layer CONV5_2_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 2048, R: 1, S: 1, Y: 7, X: 7 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}



	Layer CONV5_3_1 {
		Type: CONV
		Stride { X: 1, Y: 1 }
		Dimensions { N: NumBatches, K: 512, C: 2048, R: 1, S: 1, Y: 7, X: 7 }
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


	Layer CONV5_3_2 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 512, C: 512, R: 3, S: 3, Y: 7, X: 7 }
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


	Layer CONV5_3_3 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 2048, C: 512, R: 1, S: 1, Y: 7, X: 7 }
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


	Layer CONV5_3_Residual {
		Type: DSCONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1, C: 2048, R: 1, S: 1, Y: 7, X: 7 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}


	Layer FC1000 {
		Type: CONV
		Stride { X: 1, Y: 1 }		
		Dimensions { N: NumBatches, K: 1000, C: 2048, R: 7, S: 7, Y: 7, X: 7 }
		Dataflow {
			TemporalMap(NTileSz,NTileSz) N;
			SpatialMap(1,1) K;
			TemporalMap(ClusterSz,ClusterSz) C;
			TemporalMap(1,1) Y';
			TemporalMap(1,1) X';	
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
}