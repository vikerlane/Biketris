TimePassed += delta_time;

if (!Crash) {
	var MoveInplay = 0;
	var i, j, Item;

	UpdatePiece = false;
	RecalculateShadow = false;
	DropPiece = false;
	
	if (Piece == -1) {
		UpdatePiece = true;
	}

	if (ScoreDelta) {
		DisplayScore += ScoreDelta;
		if (Score <= DisplayScore) {
			ScoreDelta = 0;
			DisplayScore = Score;
		}
	}
	
	if (Piece != -1) {
	
		if (KeypressCooldown != -1) {
			KeypressCooldown -= 1;
			if (KeypressCooldown == 0) {
				PreviousKeypress = false;
				KeypressCooldown = -1;
			}
		} 

/*
		// TO DO: this is not necessary if we keep MinX and MaxX values and update via keypresses, etc
		for (i=0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			if (Item.Inplay) {
				if (Item.x < MinX) {
					MinX = Item.x;
				}
				if (Item.x > MaxX) {
					MaxX = Item.x;
				}
			}
	
			if (Item.Shadow) {
				RecalculateShadow = false;
			}
		}
*/

		if (PreviousKeypress == false) {
			if (keyboard_check(vk_left)) {
				if (MinX > CamPosX + 8 * 5) {
					MoveInplay = -8;
					KeypressCooldown = 8;
				}
			} else if (keyboard_check(vk_right)) {
				if (MaxX < CamPosX + room_width - 8) {
					MoveInplay = 8;
					KeypressCooldown = 8;
				}
			} else if (keyboard_check(vk_up)) {
				PieceRotation += 1;
				UpdatePiece = true;
				PreviousKeypress = true;
				KeypressCooldown = -1;
			} else if (keyboard_check(vk_down)) {
				Piece = -1;
				UpdatePiece = true;
				RecalculateShadow = true;
				PreviousKeypress = true;
				KeypressCooldown = -1;
				DropPiece = true;
/*
				// TO DO: move this code in part UpdatePiece first runthrough
				for (i=0; i < instance_number(blockObj); i++) {
					Item = instance_find(blockObj, i);
					if (Item.Shadow) {
						Item.image_index = 0;
						Item.Shadow = false;
					} else if (Item.Inplay) {
						Item.Inplay = false;
						Item.image_alpha = 0;
						Item.Destroyable = true;
					}
				}
*/
			}
		} else {
			if (keyboard_check(vk_nokey)) {
				PreviousKeypress = false;
			}
		}
	}
	
	if (MoveInplay != 0) {
		MinX += MoveInplay;
		MaxX += MoveInplay;
	}

	if (UpdatePiece) {
		for (i=0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			if (Item.Inplay) {
				Item.Inplay = false;
				Item.Destroyable = true;
				Item.image_alpha = 0;
			} else if (Item.Shadow) {
				if (!DropPiece) {
					Item.Inplay = false;
					Item.Destroyable = true;
					Item.image_alpha = 0;
				} else {
					Item.image_index = 0;
					Item.Shadow = false;
				}
			}
		}
		
		if (Piece == -1) {
			Piece = irandom_range(1, 7);
			PieceRotation = 0;
		}
		
		switch (Piece) {
			case 1:
			case 5:
			case 7:
				if (PieceRotation > 1) {
					PieceRotation = 0;
				}
				break;
			case 2:
				PieceRotation = 0;
				break;
			case 3:
			case 4:
			case 6:
				if (PieceRotation > 3) {
					PieceRotation = 0;
				}
				break;
		}
		
		RecalculateShadow = true;

		switch (Piece) {
			case 1:
				switch (PieceRotation) {
					case 0:
						for (i=0; i<4; i++) {
							Item = instance_create_layer(MinX + (i * 8), 2 * 8, "Instances", blockObj);
							Item.image_index = 1;
							Item.Inplay = true;
						}
						MaxX = MinX + (4 * 8);
						break;
					case 1:
						for (i=0; i<4; i++) {
							Item = instance_create_layer(MinX + (3 * 8), (1 + i) * 8, "Instances", blockObj);
							Item.image_index = 1;
							Item.Inplay = true;
						}
						MaxX = MinX;
						break;
				}
				break;
			case 2:
				for (i=0; i<2; i++) {
					for (j=0; j<2; j++) {
						Item = instance_create_layer(MinX + (i * 8), (2 + j) * 8, "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
				}
				MaxX = MinX + (2 * 8);
				break;
			case 3:
				if (PieceRotation == 0) {
					MinX -= 8;
				}

				if (PieceRotation == 0 || PieceRotation == 2) {
					for (i=0; i<3; i++) {
						Item = instance_create_layer(MinX + (i * 8), (2 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
					MaxX = MinX + (3 * 8);
				} else {
					for (i=0; i<3; i++) {
						Item = instance_create_layer(MinX + (1 * 8), ((1 + i ) * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
					MaxX = MinX + (2 * 8);
				}
				
				switch (PieceRotation) {
					case 0:
						Item = instance_create_layer(MinX + (2 * 8), (3 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 1:
						Item = instance_create_layer(MinX + (0 * 8), (3 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 2:
						Item = instance_create_layer(MinX + (0 * 8), (1 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 3:
						Item = instance_create_layer(MinX + (2 * 8), (1 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
				}
				break;
			case 4:
				if (PieceRotation == 0) {
					MinX -= 8;
				}

				if (PieceRotation == 0 || PieceRotation == 2) {
					for (i=0; i<3; i++) {
						Item = instance_create_layer(MinX + (i * 8), (2 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
					MaxX = MinX + (3 * 8);
				} else {
					for (i=0; i<3; i++) {
						Item = instance_create_layer(MinX + (1 * 8), ((1 + i ) * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
					MaxX = MinX + (2 * 8);
				}
				
				switch (PieceRotation) {
					case 0:
						Item = instance_create_layer(MinX + (0 * 8), (3 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 1:
						Item = instance_create_layer(MinX + (0 * 8), (1 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 2:
						Item = instance_create_layer(MinX + (2 * 8), (1 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 3:
						Item = instance_create_layer(MinX + (2 * 8), (3 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
				}
				break;
			case 5:
				if (PieceRotation == 0) {
					MinX -= 8;
				}
				switch (PieceRotation) {
					case 0:
						for (i=0; i<2; i++) {
							for (j=0; j<2; j++) {
								Item = instance_create_layer(MinX + (((1-i)+j) * 8), (2 + i) * 8, "Instances", blockObj);
								Item.image_index = 1;
								Item.Inplay = true;
							}
						}
						MaxX = MinX + (3 * 8);
						break;
					case 1:
						for (i=0; i<2; i++) {
							for (j=0; j<2; j++) {
								Item = instance_create_layer(MinX + ((1+i) * 8), (2 + i + j) * 8, "Instances", blockObj);
								Item.image_index = 1;
								Item.Inplay = true;
							}
						}
						MaxX = MinX + (2 * 8);
						break;
				}
				break;
			case 6:
				if (PieceRotation == 0) {
					MinX -= 8;
				}

				if (PieceRotation == 0 || PieceRotation == 2) {
					for (i=0; i<3; i++) {
						Item = instance_create_layer(MinX + (i * 8), (2 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
					MaxX = MinX + (3 * 8);
				} else {
					for (i=0; i<3; i++) {
						Item = instance_create_layer(MinX + (1 * 8), ((1 + i ) * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
					}
					MaxX = MinX + (2 * 8);
				}

				switch (PieceRotation) {
					case 0:
						Item = instance_create_layer(MinX + (1 * 8), (3 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 1:
						Item = instance_create_layer(MinX + (0 * 8), (2 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 2:
						Item = instance_create_layer(MinX + (1 * 8), (1 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
					case 3:
						Item = instance_create_layer(MinX + (2 * 8), (2 * 8), "Instances", blockObj);
						Item.image_index = 1;
						Item.Inplay = true;
						break;
				}
				break;
			case 7:
				if (PieceRotation == 0) {
					MinX -= 8;
				}
				switch (PieceRotation) {
					case 0:
						for (i=0; i<2; i++) {
							for (j=0; j<2; j++) {
								Item = instance_create_layer(MinX + ((i+j) * 8), (2 + i) * 8, "Instances", blockObj);
								Item.image_index = 1;
								Item.Inplay = true;
							}
						}
						MaxX = MinX + (3 * 8);
						break;
					case 1:
						for (i=0; i<2; i++) {
							for (j=0; j<2; j++) {
								Item = instance_create_layer(MinX + ((1+i) * 8), ((2 - i) + j) * 8, "Instances", blockObj);
								Item.image_index = 1;
								Item.Inplay = true;
							}
						}
						MaxX = MinX + (2 * 8);
						break;
				}
				break;
		}
	}

	// TO DO: this should be part of inplay bump
	if (MinX < CamPosX + 8 * 4) {
		RecalculateShadow = true;
	}

	// TO DO: this looks like it's in wrong place / could piggy-back inside other loops
	if (RecalculateShadow || MoveInplay != 0) {
		if (MoveInplay != 0) {
			PreviousKeypress = true;
			RecalculateShadow = true;
		}
		for (i=0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			if (MoveInplay != 0 && Item.Inplay) {
				Item.x += MoveInplay;
			}
			if (Item.Shadow) {
				Item.Destroyable = true;
				Item.image_alpha = 0;
			}
		}
	}
	
	if (!PalmsMoved && TimePassed > TimeMax / 2) {
		PalmsMoved = true;
		for (i=0; i < instance_number(palmtreesObj); i++) {
			Item = instance_find(palmtreesObj, i);
			Item.x -= 1;
		}
	}

	if (TimePassed > TimeMax) {
		PalmsMoved = false;	
		CamPosX += 1;
		camera_set_view_pos(view_camera[0], CamPosX, CamPosY);
		
		biker.x += 1;
		cityscape.x += 1;
		ui.x += 1;
		fuel.x += 1;
		fuelCover.x += 1;
	
		var PushFromLeft = false;
		for (i=0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			// TO DO: this looks like could already happen as part of other loops
			if (Item.Inplay && MinX < CamPosX + 8 * 4) {
				Item.x += 8;
				RecalculateShadow = true;
			}
			// TO DO: this looks like could already happen as part of other loops
			if (Item.x+8 < CamPosX) {
				if (irandom_range(1, 3) == 2) {
					instance_create_layer(CamPosX + room_width - 1, (9+irandom_range(1, 4)) * Item.sprite_height, "Instances", blockObj);
				}
				Item.Destroyable = true;
				Item.image_alpha = 0;
			}
		}

		if (MinX < CamPosX + 8 * 4) {
			MinX += 8;
			MaxX += 8;
		}

		TimePassed -= TimeMax;
	
		BikerMovesLeft--;
		if (BikerY != 0) {
			biker.y += BikerY;
		}
	
		// check if biker should react next step
	
		if (BikerMovesLeft < 1) {
			LevelBlocks -= 1;
			if (LevelBlocks < 1) {
				Level += 1;
				LevelBlocks = 13;
				TimeMax *= 0.935;
			}
			Score += 10;
			if (ScoreDelta < 1) {
				ScoreDelta = 1;
			}
			Fuel -= 1;
			
			// TO DO: checking values could be part of initial loop?
			var x1 = biker.x - 16;
			var x2 = x1 + 8;
			var x3 = x2 + 8;
			var x4 = x3 + 8;
			var y1 = biker.y - 16;
			var y2 = y1 + 8;
			var y3 = y2 + 8;

			var BlockA = -1;
			var BlockB = -1;
			var BlockC = -1;
			var BlockD = -1;
			var BlockE = -1;
			var BlockF = -1;

			for (i=0; i < instance_number(blockObj); i++) {
				Item = instance_find(blockObj, i);
				if (!Item.Destroyable && !Item.Shadow && !Item.Inplay) {
					if (Item.y == y3) {
						if (Item.x == x1) {
							BlockF = 1;
						} else if (Item.x == x2) {
							BlockE = 1;
						} else if (Item.x == x3) {
							BlockD = 1;
						}
					} else if (Item.y == y2) {
						if (Item.x == x3) {
							BlockB = 1;
						} else if (Item.x == x4) {
							BlockC = 1;
						}
					} else if (Item.y == y1 && Item.x == x3) {
						BlockA = 1;
					}
				}
			}

			if (fuelcan.x == biker.x) {
				if (fuelcan.y >= biker.y - 8 && fuelcan.y <= biker.y+8) {
					Fuel += 35;
					if (Fuel > MaxFuel) {
						Fuel = MaxFuel;
					}
					fuelcan.y = (5 + irandom_range(1, 7)) * 8;
					fuelcan.x += (irandom_range(25, 30)) * 8;
					Score += 100;
					ScoreDelta = 11;
					audio_play_sound(fuelPickupSnd, 5, false);
				}
			}

			if (Fuel >= 40) {
				fuel.image_index = 0;
			} else if (Fuel >= 20) {
				fuel.image_index = 1;
			} else {
				fuel.image_index = 2;
			}
			fuelCover.image_xscale = round(-40 * (1 - (Fuel / MaxFuel)));

			BikerMovesLeft = 8;
			BikerY = 0;
			
			if (Fuel < 1) {
				Crash = true;
			} else if (biker.y >= room_height) {
				Crash = true;
			} else if (!BlockF && !BlockE) {
				if (BlockD || BlockB) {
					Crash = true;
				} else {
					biker.sprite_index = bikerSpr;
					BikerY = 1;
				}
			} else if (BlockA) {
				Crash = true;
			} else if (BlockB) {
				if (biker.sprite_index == bikerBoostSpr) {
					BikerY = -1;
				} else {
					Crash = true;
				}
			} else if (BlockC) {
				biker.sprite_index = bikerBoostSpr;
				audio_play_sound(boostSnd, 5, false);
			} else if (BlockF) {
				biker.sprite_index = bikerSpr;
			}
		}
	
		if (Crash) {
			// game over
			BikerY = 0;
			biker.sprite_index = bikerCrashSpr;
			
			for (i=0; i < instance_number(blockObj); i++) {
				Item = instance_find(blockObj, i);
				if (Item.Shadow || Item.Inplay) {
					Item.Destroyable = true;
					Item.image_alpha = 0;
				}
			}
			
			overlay.DeltaAlpha = 0.1;
			overlay.x = CamPosX;
			
			instance_create_layer(0, 0, "Instances", bikerFlyingObj);
			
			audio_stop_sound(backgroundMsc);
			audio_stop_sound(engineSnd);
			audio_play_sound(screamSnd, 10, false);
			audio_play_sound(crashSnd, 10, false);
		}
	}

	// TO DO: this could probably live inside another loop
	if (RecalculateShadow) {
		var DropY = 0;
		var Positions = [];
		for (i = 0; i < room_width / 8; i++) {
			Positions[i, 0] = 0;
			Positions[i, 1] = room_height;
		}

		for (i = 0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			if (!Item.Destroyable && Item.x > CamPosX && Item.x < CamPosX + room_width) {
				var Pos = floor((Item.x-CamPosX) / 8);
				if (Item.Inplay) {
					var ShadowBlock = instance_create_layer(Item.x, Item.y, "Instances", blockObj);
					ShadowBlock.image_index = 2;
					ShadowBlock.Shadow = true;
					if (Pos > 0 && Positions[Pos, 0] < Item.y) {
						Positions[Pos, 0] = Item.y;
					}
				} else if (!Item.Shadow) {
					if (Pos > 0 && Positions[Pos, 1] > Item.y) {
						Positions[Pos, 1] = Item.y;
					}
				}
			}
		}
	
		DropY = room_height;
		for (i = 0; i < room_width / 8; i++) {
			if (Positions[i, 0] > 0) {
				var Diff = Positions[i, 1] - Positions[i, 0] - 8;
				if (Diff > 0 && Diff < DropY) {
					DropY = Diff;
				}
			}
		}

		if (DropY > 0) {
			for (i=0; i < instance_number(blockObj); i++) {
				Item = instance_find(blockObj, i);
				if (Item.Shadow) {
					Item.y += DropY;
				}
			}
		}
	}
} else {
	// crash, innit
}
