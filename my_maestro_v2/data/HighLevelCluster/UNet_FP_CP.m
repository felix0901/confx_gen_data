Constant NumBatches 32;
Constant ClusterSz 64;
Constant NTileSz 1;
Constant KTileSz 1;
Constant CTileSz 64;
Constant YTileSz 32;
Constant XTileSz 32;

Network UNet {
	Layer CONV1_1 {
		Type: CONV
		Dimensions { N: NumBatches, K: 64, C:1, R: 3, S: 3, Y: 572, X: 572 }
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

	Layer CONV1_2 {
		Type: CONV
		Dimensions { N: NumBatches, K: 64, C: 64, R: 3, S: 3, Y: 570, X: 570 }
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

	Layer CONV2_1 {
		Type: CONV
		Dimensions { N: NumBatches, K: 128, C: 64, R: 3, S: 3, Y: 284, X: 284 }
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

	Layer CONV2_2 {
		Type: CONV
		Dimensions { N: NumBatches, K: 128, C: 128, R: 3, S: 3, Y: 282, X: 282 }
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

	Layer CONV3_1 {
		Type: CONV
		Dimensions { N: NumBatches, K: 256, C: 128, R: 3, S: 3, Y: 140, X: 140 }
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


	Layer CONV3_2 {
		Type: CONV
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 138, X: 138 }
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

	Layer CONV4_1 {
		Type: CONV
		Dimensions { N: NumBatches, K: 512, C: 256, R: 3, S: 3, Y: 68, X: 68 }
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


	Layer CONV4_2 {
		Type: CONV
		Dimensions { N: NumBatches, K: 512, C: 512, R: 3, S: 3, Y: 66, X: 66 }
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

	Layer CONV5_1 {
		Type: CONV
		Dimensions { N: NumBatches, K: 1024, C: 512, R: 3, S: 3, Y: 32, X: 32 }
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


	Layer CONV5_2 {
		Type: CONV
		Dimensions { N: NumBatches, K: 1024, C: 1024, R: 3, S: 3, Y: 30, X: 30 }
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

	Layer TRCONV1 {
		Type: TRCONV
		Dimensions { N: NumBatches, K: 512, C: 1024, R: 2, S: 2, Y: 28, X: 28 }
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


	Layer CONV4_3 {
		Type: CONV
		Dimensions { N: NumBatches, K: 512, C: 1024, R: 3, S: 3, Y: 56, X: 56 }
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

	Layer CONV4_4 {
		Type: CONV
		Dimensions { N: NumBatches, K: 512, C: 512, R: 3, S: 3, Y: 54, X: 54 }
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

	Layer TRCONV2 {
		Type: TRCONV
		Dimensions { N: NumBatches, K: 512, C: 512, R: 2, S: 2, Y: 52, X: 52 }
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

	Layer CONV3_3 {
		Type: CONV
		Dimensions { N: NumBatches, K: 256, C: 512, R: 3, S: 3, Y: 104, X: 104 }
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


	Layer CONV3_4 {
		Type: CONV
		Dimensions { N: NumBatches, K: 256, C: 256, R: 3, S: 3, Y: 102, X: 102 }
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

	Layer TRCONV3 {
		Type: TRCONV
		Dimensions { N: NumBatches, K: 128, C: 256, R: 2, S: 2, Y: 100, X: 100 }
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


	Layer CONV2_3 {
		Type: CONV
		Dimensions { N: NumBatches, K: 128, C: 256, R: 3, S: 3, Y: 200, X: 200 }
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

	Layer CONV2_4 {
		Type: CONV
		Dimensions { N: NumBatches, K: 128, C: 128, R: 3, S: 3, Y: 198, X: 198 }
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

	Layer TRCONV4 {
		Type: TRCONV
		Dimensions { N: NumBatches, K: 64, C: 128, R: 2, S: 2, Y: 196, X: 196 }
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

	Layer CONV1_3 {
		Type: CONV
		Dimensions { N: NumBatches, K: 64, C: 128, R: 3, S: 3, Y: 392, X: 392 }
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


	Layer CONV1_4 {
		Type: CONV
		Dimensions { N: NumBatches, K: 64, C: 64, R: 3, S: 3, Y: 390, X: 390 }
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

	Layer CONV1_5 {
		Type: CONV
		Dimensions { N: NumBatches, K: 2, C: 64, R: 1, S: 1, Y: 388, X: 388 }
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
}

// Accelerator {
//  PE { NumPEs: 128; VectorWidth: 4; MultPrecision: INT8, AddPrecision: INT16 }
//  Buffer { GlobalL2: 2048, LocalL1: 64}
//  NoC {Bandwidth: 64; AvgLatency: 2}
// }