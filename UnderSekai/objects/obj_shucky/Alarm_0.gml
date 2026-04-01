snd = mus_shuck;
audio_play_sound(snd, 1, false);

sound_length = audio_sound_length(snd) * room_speed;
timer = 0;

done = false;