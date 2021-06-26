if (!audio_is_playing(sfx_croak) && state.state_is( states.idle )) {
	audio_sound_pitch(sfx_croak, random_range(0.7, 1));
	audio_play_sound(sfx_croak, 1, false);
	alarm[5] = random_range(0.85 * cutscene_jump_delta, cutscene_jump_delta * 3) * room_speed;
}