room_speed = 60;

var Scale = 4;

for (var i = 1; i <= room_last; i++) {
	if (room_exists(i)) {
		room_set_width(i, room_width);
		room_set_height(i, room_height);
	}
}

window_set_size(room_width * Scale, room_height * Scale);

room_goto(room_next(room));

