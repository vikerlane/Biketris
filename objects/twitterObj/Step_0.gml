if (mouse_y > y && mouse_y < y + sprite_height - 5 && mouse_x > x + 3 && mouse_x < x + sprite_width - 3) {
	image_index = 1;
	if (!TwitterOpened) {
		if (mouse_check_button_released(mb_left)) {
			TwitterOpened = true;

			var Url = "https://twitter.com/intent/tweet?text=";
			Url += "I%20just%20scored%20";
			Url += string(game.DisplayScore);
			Url += "%20in%20%23biketris%20an%20%23indiegame%20by%20%40TooOldTooCold%20Check%20it%20out%20at%20https%3A%2F%2Fvikerlane.itch.io%2Fbiketris";
			
			url_open_ext(Url, "_blank");
		}
	}
} else {
	TwitterOpened = false;
	image_index = 0;
}