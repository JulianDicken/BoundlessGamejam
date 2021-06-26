y = cos(current_time * osc_speed) * amp + anchor_y;

fade += fade_speed;
fade = clamp(fade, 0 , 1);
image_alpha = fade;
