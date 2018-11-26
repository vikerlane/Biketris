if (Time != -1) {
	Time += 1;
	Time2 = Time / Duration;
	y = -Change * Time2*(Time2-2) + StartValue;
	x += DeltaX;
	if (Time == Duration) {
		sprite_index = bikerFallingSpr;
	}
	if (y > StopPosition) {
		y = StopPosition;
		Time = -1;
		sprite_index = bikerFlatSpr;
		audio_play_sound(punchSnd, 1, false);
	}
}