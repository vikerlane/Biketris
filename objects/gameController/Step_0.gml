TimePassed += delta_time;

var MoveInplay = 0;
var i, Item;

var MaxX = 0;
var MinX = room_width;

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
	}
} else {
	if (keyboard_check(vk_nokey)) {
		PreviousKeypress = false;
	}
}

if (MoveInplay != 0) {
	PreviousKeypress = true;
	for (i=0; i < instance_number(testObj); i++) {
		Item = instance_find(testObj, i);
		if (Item.Inplay) {
			Item.x += MoveInplay;
		}
	}
}

if (TimePassed > TimeMax) {
	for (i=0; i < instance_number(testObj); i++) {
		Item = instance_find(testObj, i);
		Item.x -= 1;
		if (Item.Inplay && MinX < 8 * 4) {
			Item.x += 8;
		}
		if (Item.x < -Item.sprite_width) {
			instance_create_layer(room_width, (4+irandom(9)) * Item.sprite_height, "Instances", testObj);
			instance_create_layer(room_width, (4+irandom(9)) * Item.sprite_height, "Instances", testObj);
			Item.Destroyable = true;
		}
	}
	TimePassed -= TimeMax;
}