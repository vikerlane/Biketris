TimePassed += delta_time;

var MoveInplay = 0;
var i, Item;

if (PreviousKeypress == false) {
	if (keyboard_check(vk_left)) {
		MoveInplay = -8;
	} else if (keyboard_check(vk_right)) {
		MoveInplay = 8;
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
		if (Item.x < -Item.sprite_width) {
			instance_create_layer(room_width, (4+irandom(9)) * Item.sprite_height, "Instances", testObj);
			instance_create_layer(room_width, (4+irandom(9)) * Item.sprite_height, "Instances", testObj);
			Item.Destroyable = true;
		}
	}
	TimePassed -= TimeMax;
}