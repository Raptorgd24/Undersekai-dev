// Create Event de obj_boom_temp
sprite_index = spr_boom;
image_index = 0;
image_speed = 1;
depth = -100;
//audio_play_sound(snd_boom, 1, false);

parent_npc = noone; // Inicializar

// Asegurarnos de que la variable global esté limpia
if (variable_global_exists("sans_destroyed")) {
    global.sans_destroyed = undefined;
}