if (Time < Duration) {
	Time += 1;
	Time2 = Time / Duration;
	y = -Change * Time2*(Time2-2) + StartValue;
}