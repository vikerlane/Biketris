if (!Crash) {
	if (!instance_exists(countdown)) {
		TimePassed += delta_time;
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

			if (PreviousKeypress == false) {
				if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
					if (MinX > CamPosX + 8 * 5) {
						MoveInplay = -8;
						KeypressCooldown = 8;
					}
				} else if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
					if (MaxX < CamPosX + room_width - 8) {
						MoveInplay = 8;
						KeypressCooldown = 8;
					}
				} else if (keyboard_check(vk_up) || keyboard_check(vk_space) || keyboard_check(ord("W"))) {
					PieceRotation += 1;
					UpdatePiece = true;
					PreviousKeypress = true;
					KeypressCooldown = -1;
				} else if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
					Piece = -1;
					UpdatePiece = true;
					RecalculateShadow = true;
					PreviousKeypress = true;
					KeypressCooldown = -1;
					DropPiece = true;
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
				var Rotations = [];
				Rotations[1] = 0;
				Rotations[2] = 0;
				Rotations[3] = 3;
				Rotations[4] = 3;
				Rotations[5] = 1;
				Rotations[6] = 3;
				Rotations[7] = 1;
				PieceRotation = irandom_range(0, Rotations[Piece]);
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
							MinX -= 2 * 8;
							for (i=0; i<4; i++) {
								Item = instance_create_layer(MinX + (i * 8), 2 * 8, "Instances", blockObj);
								Item.image_index = 1;
								Item.Inplay = true;
							}
							MaxX = MinX + (4 * 8);
							break;
						case 1:
							MinX += 2 * 8;
							for (i=0; i<4; i++) {
								Item = instance_create_layer(MinX, (1 + i) * 8, "Instances", blockObj);
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
		
		var PushFromLeft = false;		
			
		var DropY = 0;
		var Pos;
		var Positions = [];
		for (i = 0; i < room_width / 8; i++) {
			Positions[i, 0] = 0;
			Positions[i, 1] = room_height;
		}
	
		if (MinX < CamPosX + 8 * 4) {
			MinX += 8;
			MaxX += 8;
			MoveInplay += 8;
			PushFromLeft = true;
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
				if (Item.Shadow && !Item.ShadowNew) {
					Item.Destroyable = true;
					Item.image_alpha = 0;
				}
				if (Item.x+8 == CamPosX) {
					if (irandom_range(1, 4) == 3) {
						instance_create_layer(CamPosX + room_width, (9+irandom_range(1, 4)) * Item.sprite_height, "Instances", blockObj);
					}
					Item.Destroyable = true;
					Item.image_alpha = 0;
				}		
				if (RecalculateShadow) {
					if (!Item.Destroyable && Item.x > CamPosX && Item.x < CamPosX + room_width) {
						Pos = floor((Item.x-CamPosX) / 8);
						if (Item.Inplay) {
							var ShadowBlock = instance_create_layer(Item.x, Item.y, "Instances", blockObj);
							ShadowBlock.image_index = 2;
							ShadowBlock.Shadow = true;
							ShadowBlock.ShadowNew = true;
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
			}
		}
		
		if (TimePassed > TreeCounter * (TimeMax / 4)) {
			show_debug_message(string(TreeCounter)+" "+string(TimePassed)+" "+string(TimeMax)+" "+string(TreeCounter * (TimeMax / 4)));
			TreeCounter += 1;
			for (i=0; i < instance_number(palmtreesObj); i++) {
				Item = instance_find(palmtreesObj, i);
				Item.x -= 2;
			}
			if (TreeCounter == 4) {
				TreeCounter = 0;
			}
		}

		if (TimePassed > TimeMax) {
			CamPosX += 1;
			camera_set_view_pos(view_camera[0], CamPosX, CamPosY);
		
			biker.x += 1;
			cityscape.x += 1;
			ui.x += 1;
			fuel.x += 1;
			fuelCover.x += 1;			

			/*
			for (i=0; i < instance_number(blockObj); i++) {
				Item = instance_find(blockObj, i);

				if (Item.Inplay && PushFromLeft) {
					Item.x += 8;
				}

				
			}*/

			TimePassed -= TimeMax;
	
			BikerMovesLeft--;
			if (BikerY != 0) {
				biker.y += BikerY;
			}
	
			// check if biker should react next step
			if (BikerMovesLeft < 1) {
				LevelBlocks -= 1;
				if (LevelBlocks < 1) {
					if (Level < MaxLevel-1) {
						audio_play_sound(gearchangeSnd, 5, false);
						Level += 1;
						TimeMax = (BaseLevel + MaxLevel - Level) * TimeBase;
						LevelBlocks = LevelBlockReset;
					}
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
				var xFinal = biker.x + room_width - (3 * 8);

				var BlockA = -1;
				var BlockB = -1;
				var BlockC = -1;
				var BlockD = -1;
				var BlockE = -1;
				var BlockF = -1;
				var BlockG = -1;
				
				var NextBlockY = room_height;

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
							} else if (Item.x == x4) {
								BlockG = 1;
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
						/*
						else if (Item.x == xFinal) {
							if (NextBlockY > Item.y) {
								NextBlockY = Item.y;
							}
						}*/
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
						// Score += 100;
						// ScoreDelta = 11;
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
						biker.sprite_index = bikerDropSpr;
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
				}  else if ((!BlockF && !BlockE) || (!BlockE && !BlockD) || (!BlockD && !BlockG)) {
					biker.sprite_index = bikerDropSpr;
				} else if (BlockF || BlockE) {
					biker.sprite_index = bikerSpr;
				}
	
				// Crash = true;
				if (Crash) {
					// game over
					if (PreviousHighScore < Score) {
						HighScore = true;
						highscore_add("", Score);
					}

					PreviousKeypress = false;
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
					instance_create_layer(0, 0, "Instances", skullObj);
					instance_create_layer(0, 0, "Instances", youloseObj);
					instance_create_layer(0, 0, "Instances", bikerWheelObj);

					audio_stop_sound(backgroundMsc);
					audio_stop_sound(engineSnd);
					audio_play_sound(screamSnd, 10, false);
					audio_play_sound(crashSnd, 10, false);
					// url_open_ext("http://yoyogames.com", "_blank");
				} else {
					// check if score sign should be posted
					if (Score < PreviousHighScore) {
						var ScorePoint = PreviousHighScore - (((CamPosX/8)+24)*10);
						switch (ScorePoint) {
							case 5000:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 1;
								break;
							case 3000:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 2;
								break;
							case 2500:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 3;
								break;
							case 1000:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 4;
								break;
							case 500:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 5;
								break;
							case 250:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 6;
								break;
							case 0:
								var Item = instance_create_layer(CamPosX + room_width, NextBlockY, "Instances", signsObj);
								Item.image_index = 9;
								break;
						}
					}
				}
			}
		}

		// TO DO: this could probably live inside another loop
		if (RecalculateShadow) {	
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
						Item.ShadowNew = false;
					}
				}
			}
		}
	}
} else {
	// crash, innit
	if (RestartCooldown > 0) {
		RestartCooldown -= 1;
		if (RestartCooldown == 0) {
			instance_create_layer(CamPosX+136, 40, "Instances", twitterObj);
			var Url = "https://twitter.com/intent/tweet?text=";
			Url += "I%20just%20scored%20";
			Url += string(game.DisplayScore);
			Url += "%20in%20%23biketris%20an%20%23indiegame%20by%20%40TooOldTooCold%20Check%20it%20out%20at%20https%3A%2F%2Fvikerlane.itch.io%2Fbiketris";
			TwitterHTMLElement = clickable_add_ext(137*3, 41*3, sprite_get_tpe(twitterHtmlSpr, 0), Url, "_blank", "", 1, 1);
		}
	} else {
		if (PreviousKeypress) {
			if (keyboard_check(vk_nokey)) {
				clickable_delete(TwitterHTMLElement);
				room_goto(gameRoom);
			}
		} else {
			if (keyboard_check(vk_anykey)) {
				PreviousKeypress = true;
			}
		}
	}
}
