if (x > game.CamPosX + room_width + 4) {
	instance_destroy();
} else {
	Timer += 1;
	if (Timer == 2) {
		x += VelocityX;
		y += Velocity;
		Velocity += Acceleration;
		if (y >= room_height) {
			y = room_height;
			Velocity = -Velocity * 0.65;
		}
		Timer = 0;
	}
}