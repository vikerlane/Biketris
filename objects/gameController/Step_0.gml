TimePassed += delta_time;

if (!Crash) {
	var MoveInplay = 0;
	var i, Item;

	var MaxX = 0;
	var MinX = room_width;

	var RecalculateShadow = true;

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

	if (PreviousKeypress == false) {
		if (keyboard_check(vk_left)) {
			if (MinX > 8 * 5) {
				MoveInplay = -8;
			}
		} else if (keyboard_check(vk_right)) {
			if (MaxX < room_width - 16) {
				MoveInplay = 8;
			}
		} else if (keyboard_check(vk_down)) {
			RecalculateShadow = true;
			PreviousKeypress = true;
			for (i=0; i < instance_number(blockObj); i++) {
				Item = instance_find(blockObj, i);
				if (Item.Shadow) {
					Item.image_index -= 10;
					Item.Shadow = false;
				} else if (Item.Inplay) {
					Item.Inplay = false;
					Item.image_alpha = 0;
					Item.Destroyable = true;
				}
			}
			
			var Length = irandom_range(2, 3);
			for (i = 0; i<Length; i++) {
				Item = instance_create_layer(MinX + (8 * i), 8, "Instances", blockObj);
				Item.image_index += 5;
				Item.Inplay = true;
			}
		}
	} else {
		if (keyboard_check(vk_nokey)) {
			PreviousKeypress = false;
		}
	}

	if (MinX < 8 * 4) {
		RecalculateShadow = true;
	}

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

	if (TimePassed > TimeMax) {
		for (i=0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			Item.x -= 1;
			if (Item.Inplay && MinX < 8 * 4) {
				Item.x += 8;
				RecalculateShadow = true;
			}
			if (Item.x < -Item.sprite_width) {
				instance_create_layer(room_width, (8+irandom(5)) * Item.sprite_height, "Instances", blockObj);
				instance_create_layer(room_width, (8+irandom(5)) * Item.sprite_height, "Instances", blockObj);
				Item.Destroyable = true;
				Item.image_alpha = 0;
			}
		}
		TimePassed -= TimeMax;
	
		BikerMovesLeft--;
		if (BikerY != 0) {
			biker.y += BikerY;
		}
	
		// check if biker should react next step
	
		if (BikerMovesLeft < 1) {
			BikerMovesLeft = 8;
			BikerY = 0;

			var NextBlockX00 = biker.x-16;
			var NextBlockX0 = biker.x-8;
			var NextBlockX1 = biker.x;
			var NextBlockX2 = biker.x+8;		
			var NextBlockY1 = biker.y - 8;
			var NextBlockY2 = biker.y;
			var Next = -1;
			var NextAfter = -1;
			var NextBelow1 = -1;
			var NextBelow2 = -1;
			var NextBelow3 = -1;
			for (i=0; i < instance_number(blockObj); i++) {
				Item = instance_find(blockObj, i);
				if (!Item.Shadow && !Item.Inplay) {
					if (Item.y == NextBlockY1) {
						if (Item.x == NextBlockX1) {
							Next = Item.image_index;
						} else if (Item.x == NextBlockX2) {
							NextAfter = Item.image_index;
						}
					} else if (Item.y == NextBlockY2) {
						if (Item.x == NextBlockX00) {
							NextBelow1 = 1;
						} else if (Item.x == NextBlockX0) {
							NextBelow2 = 1;
						} else if (Item.x == NextBlockX1) {
							NextBelow3 = 1;
						}
					}
				}
			}
			
			// if bottom row, crash
			// else if next is block
			//    if not up, crash, else go up
			// if bottom is solid
			//    if up, go normal
			
			if (biker.y >= room_height) {
				Crash = true;
			} else if (Next != -1) {
				if (biker.sprite_index == bikerBoostSpr) {
					BikerY = -1;
				} else {
					Crash = true;
				}
			} else if (NextAfter != -1) {
				biker.sprite_index = bikerBoostSpr;
			} else if (NextBelow1 == -1 && NextBelow2 == -1) {
				biker.sprite_index = bikerSpr;
				BikerY = 1;
			} else if (NextBelow1 != -1) {
				biker.sprite_index = bikerSpr;
			}
			
			/* show_debug_message(string(NextBelow1));
			show_debug_message(string(NextBelow2));
			show_debug_message(string(NextBelow3));
			show_debug_message(string(NextBlockX00));
			show_debug_message(string(NextBlockY2));
			game_end(); */
			/*if (biker.y >= room_height) {
				Crash = true;
			} else if (Next != -1) {
				Crash = true;
			} else if (NextAfter != -1) {
				BikerY = -1;
				biker.sprite_index = bikerBoostSpr;
			} else if (NextBelow1 == -1 && NextBelow2 == -1) {
				/*if (NextBelow3 != -1) {
					Crash = true;
				} else  {
					BikerY = 4;
				}
			} */
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
		}
	}

	if (RecalculateShadow) {
		var DropY = 0;
		var Positions = [];
		for (i = 0; i < room_width / 8; i++) {
			Positions[i, 0] = 0;
			Positions[i, 1] = room_height;
		}

		for (i = 0; i < instance_number(blockObj); i++) {
			Item = instance_find(blockObj, i);
			var Pos = floor(Item.x / 8);
			if (Item.Inplay) {
				var ShadowBlock = instance_create_layer(Item.x, Item.y, "Instances", blockObj);
				ShadowBlock.image_index = Item.image_index + 5;
				ShadowBlock.Shadow = true;
				if (Pos > 0 && Positions[Pos, 0] < Item.y) {
					Positions[Pos, 0] = Item.y + 8;
				}
			} else if (!Item.Shadow) {
				if (Pos > 0 && Positions[Pos, 1] > Item.y) {
					Positions[Pos, 1] = Item.y;
				}
			}
		}
	
		DropY = room_height;
		for (i = 0; i < room_width / 8; i++) {
			if (Positions[i, 0] > 0) {
				var Diff = Positions[i, 1] - Positions[i, 0];
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
