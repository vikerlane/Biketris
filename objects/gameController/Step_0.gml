TimePassed += delta_time;

var MoveInplay = 0;
var i, Item;

var MaxX = 0;
var MinX = room_width;

var RecalculateShadow = true;

for (i=0; i < instance_number(testObj); i++) {
	Item = instance_find(testObj, i);
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
		for (i=0; i < instance_number(testObj); i++) {
			Item = instance_find(testObj, i);
			if (Item.Shadow) {
				Item.image_index -= 10;
				Item.Shadow = false;
			}
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
	for (i=0; i < instance_number(testObj); i++) {
		Item = instance_find(testObj, i);
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
	for (i=0; i < instance_number(testObj); i++) {
		Item = instance_find(testObj, i);
		Item.x -= 1;
		if (Item.Inplay && MinX < 8 * 4) {
			Item.x += 8;
			RecalculateShadow = true;
		}
		if (Item.x < -Item.sprite_width) {
			instance_create_layer(room_width, (8+irandom(5)) * Item.sprite_height, "Instances", testObj);
			instance_create_layer(room_width, (8+irandom(5)) * Item.sprite_height, "Instances", testObj);
			Item.Destroyable = true;
			Item.image_alpha = 0;
		}
	}
	TimePassed -= TimeMax;
}

if (RecalculateShadow) {
	var DropY = 0;
	var Positions = [];
	for (i = 0; i < room_width / 8; i++) {
		Positions[i, 0] = 0;
		Positions[i, 1] = room_height;
	}

	for (i = 0; i < instance_number(testObj); i++) {
		Item = instance_find(testObj, i);
		var Pos = floor(Item.x / 8);
		if (Item.Inplay) {
			var ShadowBlock = instance_create_layer(Item.x, Item.y, "Instances", testObj);
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
		for (i=0; i < instance_number(testObj); i++) {
			Item = instance_find(testObj, i);
			if (Item.Shadow) {
				Item.y += DropY;
			}
		}
	}
}

