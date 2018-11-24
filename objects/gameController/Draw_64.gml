var ScoreX = 85;

draw_set_alpha(1);
draw_set_font(scoreFnt);
draw_set_colour(c_white);

var ScoreString = string(DisplayScore);

ScoreString = string_repeat("0", 6 - string_length(ScoreString)) + ScoreString;

for (var i=1; i<=6; i++) {
	draw_text(ScoreX + i*7, 1, string_char_at(ScoreString, i));
}