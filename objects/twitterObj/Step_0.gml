if (mouse_y > y && mouse_y < y + sprite_height && mouse_x - 8 > x - game.CamPosX && mouse_x - 8 < x - game.CamPosX + sprite_width) {
	image_index = 1;
} else {
	image_index = 0;
}