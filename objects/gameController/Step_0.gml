TimePassed += delta_time;

if (TimePassed > TimeMax) {
	for (var i, i = 0; i < instance_number(testObj); i += 1) {
		var Item = instance_find(testObj, i);
		Item.x -= 1;
		if (Item.x < -Item.sprite_width) {
			instance_create_layer(room_width, (4+irandom(9)) * Item.sprite_height, "Instances", testObj);
			instance_destroy(Item);
			
		}
	}
	TimePassed -= TimeMax;
}