room_speed = 60;

var Scale = 3;

for (var i = 1; i <= room_last; i++) {
	if (room_exists(i)) {
		room_set_width(i, room_width);
		room_set_height(i, room_height);
	}
}

// window_set_position(100, 100); // comment out for HTML import
window_set_size(room_width * Scale, room_height * Scale);
display_set_gui_size(room_width, room_height);

room_goto(room_next(room));
