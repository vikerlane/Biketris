Counter += 1;

if (Counter == 180) {
	image_speed = 0;
	biker.sprite_index = bikerSpr;
	instance_destroy();
}