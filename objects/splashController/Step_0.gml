if (PreviousKeypress) {
	if (keyboard_check(vk_nokey)) {
		room_goto(gameRoom);
	}
} else {
	if (keyboard_check(vk_anykey)) {
		PreviousKeypress = true;
	}
}