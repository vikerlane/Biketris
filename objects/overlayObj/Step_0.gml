if (DeltaAlpha > 0) {
	if (image_alpha < 1) {
		image_alpha += DeltaAlpha;
		if (image_alpha >= 1) {
			DeltaAlpha = 0;
			image_alpha = 1;
		}
	}
}