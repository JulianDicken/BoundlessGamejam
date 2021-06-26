anchor_y = y;
osc_speed = 0.001;
amp = 16;

fade = 0;
fade_speed = 0.01;
transitioning = false;
audio_sound_gain(sfx_swamp, 0, room_speed * 25);
audio_play_sound(sfx_main_score, 1, true);
audio_sound_gain(sfx_main_score, 0, 0);
audio_sound_gain(sfx_main_score, 0.05, room_speed * 25);