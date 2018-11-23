draw_set_alpha(1);
draw_set_font(scoreFnt);

var ScoreText = "Score: "+string(Score);

draw_set_colour(make_colour_rgb(63, 40, 50));
draw_text(1, -3, ScoreText);
draw_text(1, -1, ScoreText);
draw_text(3, -1, ScoreText);
draw_text(3, -3, ScoreText);

draw_text(2, -3, ScoreText);
draw_text(2, -1, ScoreText);
draw_text(1, -2, ScoreText);
draw_text(3, -2, ScoreText);


draw_set_colour(c_white);
draw_set_colour(make_colour_rgb(255, 255, 255));
draw_text(2, -2, ScoreText);


// draw_text(0, 0, string(Fuel));
/*
draw_text(room_width - 50, 0, string(instance_number(blockObj)));
*/
