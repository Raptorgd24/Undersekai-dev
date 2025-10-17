// obj_slash - Step
// cuando la animación termina, reproducimos snd_slashed y destruimos
if (image_index >= image_number - 1) {
    audio_play_sound(snd_slashed, 1, false);
    instance_destroy();
}
