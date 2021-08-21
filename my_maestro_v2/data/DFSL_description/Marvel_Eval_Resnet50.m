Network MarvelEval_Resnet50 {
	Layer CONV2_2_2_Tiled_DLA {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 3, S: 3, Y': 18, X': 13 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV2_2_2_Tiled_RS {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 3, S: 3, Y': 18, X': 13 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV2_2_2_Tiled_Shi {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 3, S: 3, Y': 18, X': 13 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}	

	Layer CONV5_3_2_Tiled_DLA {
		Type: CONV
		Dimensions { K: 64, C: 65, R: 3, S: 3, Y': 5, X': 5 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV5_3_2_Tiled_RS {
		Type: CONV
		Dimensions { K: 64, C: 65, R: 3, S: 3, Y': 5, X': 5 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV5_3_2_Tiled_Shi {
		Type: CONV
		Dimensions { K: 64, C: 65, R: 3, S: 3, Y': 5, X': 5 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

	Layer CONV5_3_Residual_Tiled_DLA {
		Type: DSCONV
		Dimensions { C: 64, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV5_3_Residual_Tiled_RS {
		Type: DSCONV
		Dimensions { C: 64, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV5_3_Residual_Tiled_Shi {
		Type: DSCONV
		Dimensions { C: 64, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

	Layer CONV2_1_2_Tiled_DLA {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 1, S: 1, Y': 50, X': 8 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV2_1_2_Tiled_RS {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 1, S: 1, Y': 50, X': 8 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV2_1_2_Tiled_Shi {
		Type: CONV
		Dimensions { K: 64, C: 64, R: 1, S: 1, Y': 50, X': 8 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

	Layer CONV3_4_1_Tiled_DLA {
		Type: CONV
		Dimensions { K: 128, C: 192, R: 1, S: 1, Y': 24, X': 4 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV3_4_1_Tiled_RS {
		Type: CONV
		Dimensions { K: 128, C: 192, R: 1, S: 1, Y': 24, X': 4 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV3_4_1_Tiled_Shi {
		Type: CONV
		Dimensions { K: 128, C: 192, R: 1, S: 1, Y': 24, X': 4 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

	Layer CONV5_1_3_Tiled_DLA {
		Type: CONV
		Dimensions { K: 128, C: 257, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV5_1_3_Tiled_RS {
		Type: CONV
		Dimensions { K: 128, C: 257, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV5_1_3_Tiled_Shi {
		Type: CONV
		Dimensions { K: 128, C: 257, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

	Layer CONV5_1_1_Tiled_DLA {
		Type: CONV
		Dimensions { K: 192, C: 118, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer CONV5_1_1_Tiled_RS {
		Type: CONV
		Dimensions { K: 192, C: 118, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer CONV5_1_1_Tiled_Shi {
		Type: CONV
		Dimensions { K: 192, C: 118, R: 1, S: 1, Y': 7, X': 7 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

	Layer FC1000_Tiled_DLA {
		Type: CONV
		Dimensions { K: 512, C: 2, R: 7, S: 7, Y': 1, X': 1 }
		Dataflow {
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;	
			Cluster(64, P);
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer FC1000_Tiled_RS {
		Type: CONV
		Dimensions { K: 512, C: 2, R: 7, S: 7, Y': 1, X': 1 }
		Dataflow {
			TemporalMap(2,2) K;
			TemporalMap(4,4) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}
	
	Layer FC1000_Tiled_Shi {
		Type: CONV
		Dimensions { K: 512, C: 2, R: 7, S: 7, Y': 1, X': 1 }
		Dataflow {
			TemporalMap(1,1) K;
			TemporalMap(1,1) C;
			SpatialMap(1,1) Y';
			TemporalMap(8,8) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;			
			Cluster(8, P);
			TemporalMap(1,1) Y';
			SpatialMap(1,1) X';
			TemporalMap(Sz(R), Sz(R)) R;
			TemporalMap(Sz(R), Sz(R)) S;
		}
	}

}
