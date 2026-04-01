snd = mus_shuck;
//audio_play_sound(snd, 1, false);
sound_length = audio_sound_length(snd) * room_speed;
timer = 0;

done = false;

video_open("shucky.mp4");
video_set_volume(0);

video_surface = -1;
alarm[0] = room_speed * 2.74;
shader = shd_pixel_bw;
