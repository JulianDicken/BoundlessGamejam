with (oLogo) {
	if (!transitioning) {
		other.pressed = true;
		fade_speed = -fade_speed;
		transitioning = true;
	}
}