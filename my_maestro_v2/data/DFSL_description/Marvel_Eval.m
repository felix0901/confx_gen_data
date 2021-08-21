Network MarvelEval_MobileNet {
	Layer Bottleneck1_1_Residual_Tiled_DLA {
		Type: CONV
		Dimensions { K: 1, C: 1, R: 1, S: 1, Y': 112, X': 64 }
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

	Layer Bottleneck1_1_Residual_Tiled_RS {
		Type: CONV
		Dimensions { K: 1, C: 1, R: 1, S: 1, Y': 112, X': 64 }
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

	Layer Bottleneck1_1_Residual_Tiled_Shi {
		Type: CONV
		Dimensions { K: 1, C: 1, R: 1, S: 1, Y': 112, X': 64 }
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

	Layer Bottleneck1_1_2_Tiled_DLA {
		Type: DSCONV
		Dimensions { C: 1, R: 3, S: 3, Y': 112, X': 66 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer Bottleneck1_1_2_Tiled_RS {
		Type: DSCONV
		Dimensions { C: 1, R: 3, S: 3, Y': 112, X': 66 }
		Dataflow {
			TemporalMap(1,1) C;
			SpatialMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;			
			Cluster(Sz(S),P);
			SpatialMap(1,1) X;
			SpatialMap(1,1) S;
		}
	}	

	Layer Bottleneck1_1_2_Tiled_Shi {
		Type: DSCONV
		Dimensions { C: 1, R: 3, S: 3, Y': 112, X': 66 }
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

	Layer CONV1_Tiled_DLA {
		Type: CONV
		Dimensions { K: 32, C: 32, R: 1, S: 1, Y': 5, X': 64 }
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

	Layer CONV1_Tiled_RS {
		Type: CONV
		Dimensions { K: 32, C: 32, R: 1, S: 1, Y': 5, X': 64 }
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

	Layer CONV1_Tiled_Shi {
		Type: CONV
		Dimensions { K: 32, C: 32, R: 1, S: 1, Y': 5, X': 64 }
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


	Layer CONV2D_3_Tiled_DLA {
		Type: CONV
		Dimensions { K: 192, C: 285, R: 1, S: 1, Y': 1, X': 1 }
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

	Layer CONV2D_3_Tiled_DLA_RS {
		Type: CONV
		Dimensions { K: 192, C: 285, R: 1, S: 1, Y': 1, X': 1 }
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

	Layer CONV2D_3_Tiled_DLA_Shi {
		Type: CONV
		Dimensions { K: 192, C: 285, R: 1, S: 1, Y': 1, X': 1 }
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

	Layer Bottleneck1_1_3_Tiled_DLA {
		Type: CONV
		Dimensions { K: 16, C: 32, R: 1, S: 1, Y': 17, X': 64 }
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

	Layer Bottleneck1_1_3_Tiled_RS {
		Type: CONV
		Dimensions { K: 16, C: 32, R: 1, S: 1, Y': 17, X': 64 }
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

	Layer Bottleneck1_1_3_Tiled_Shi {
		Type: CONV
		Dimensions { K: 16, C: 32, R: 1, S: 1, Y': 17, X': 64 }
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


	Layer Bottleneck7_1_2_Tiled_DLA {
		Type: DSCONV
		Dimensions { C: 666, R: 3, S: 3, Y': 5, X': 5 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer Bottleneck7_1_2_Tiled_RS {
		Type: DSCONV
		Dimensions { C: 666, R: 3, S: 3, Y': 5, X': 5 }
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

	Layer Bottleneck7_1_2_Tiled_Shi {
		Type: DSCONV
		Dimensions { C: 666, R: 3, S: 3, Y': 5, X': 5 }
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


	Layer Bottleneck4_3_2_Tiled_DLA {
		Type: DSCONV
		Dimensions { C: 64, R: 3, S: 3, Y': 12, X': 12 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer Bottleneck4_3_2_Tiled_RS {
		Type: DSCONV
		Dimensions { C: 64, R: 3, S: 3, Y': 12, X': 12 }
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

	Layer Bottleneck4_3_2_Tiled_Shi {
		Type: DSCONV
		Dimensions { C: 64, R: 3, S: 3, Y': 12, X': 12 }
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


	Layer Bottleneck6_2_2_Tiled_DLA {
		Type: DSCONV
		Dimensions { C: 576, R: 3, S: 3, Y': 5, X': 5 }
		Dataflow {
			SpatialMap(1,1) C;
			TemporalMap(Sz(R),1) Y;
			TemporalMap(Sz(S),1) X;
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
		}
	}	

	Layer Bottleneck6_2_2_Tiled_RS {
		Type: DSCONV
		Dimensions { C: 576, R: 3, S: 3, Y': 5, X': 5 }
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

	Layer Bottleneck6_2_2_Tiled_Shi {
		Type: DSCONV
		Dimensions { C: 576, R: 3, S: 3, Y': 5, X': 5 }
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


}
