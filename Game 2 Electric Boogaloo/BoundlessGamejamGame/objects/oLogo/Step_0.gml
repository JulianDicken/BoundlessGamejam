y = cos(current_time * osc_speed) * amp + anchor_y;

fade += fade_speed;
fade = clamp(fade, 0 , 1);
image_alpha = fade;

if (fade == 0 && transitioning && audio_is_playing(sfx_swamp)) {
	audio_stop_sound(sfx_swamp);	
}