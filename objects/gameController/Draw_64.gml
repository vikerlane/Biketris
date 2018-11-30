if (!Crash) {
	var ScoreX = 85;

	draw_set_alpha(1);
	draw_set_font(scoreFnt);
	draw_set_colour(c_white);

	var ScoreString = string(DisplayScore);

	ScoreString = string_repeat("0", 6 - string_length(ScoreString)) + ScoreString;

	for (var i=1; i<=6; i++) {
		draw_text(ScoreX + i*7, 1, string_char_at(ScoreString, i));
	}
} else {
	draw_set_alpha(1);
	draw_set_font(normalFnt);
	draw_set_colour(c_white);
	
	if (RestartCooldown == 0) {
		draw_text(29, 1, "Press ANY key to restart");
	}
	
	if (HighScore) {
		draw_text(64, 80, "NEW High Score");
	} else {
		draw_text(74, 80, "Final Score");
	}

	var ScoreString = string(DisplayScore);
	ScoreString = string_repeat("0", 6 - string_length(ScoreString)) + ScoreString;

	draw_set_font(scoreFnt);
	draw_text(97, 92, ScoreString);
}