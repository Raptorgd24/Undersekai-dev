// CREATE EVENT
gpu_set_texfilter(false);
show_debug_message("=== INICIO INTRO ===");
image_alpha = 0;
intro_state = "writing";
intro_texts = [
    "In this timeline. Undertale has already happened",
    "But something happened after a certain \naccident with a truck.",
    "Something New was brewing in the \nUnderground..?"
];
intro_current_text = 0;
intro_display_text = "";
intro_char_index = 0;
intro_char_timer = 0;
intro_char_delay = 4;
intro_text_x = 60;
intro_text_y = 320;

// Sprites para cada texto
intro_sprites = [spr_mtsekai, spr_sansprophecy, spr_666];
current_sprite = noone;
fade_alpha = 0;
fade_speed = 0.03;

// Variables para música
music_fading = false;
music_volume = 1;
music_fade_speed = 0.02;

// Mostrar primer sprite inmediatamente
if (array_length(intro_sprites) > 0) {
    current_sprite = intro_sprites[0];
    show_debug_message("Sprite inicial: " + string(current_sprite));
}

// Iniciar música
	audio_play_sound(mus_doomsday,1,false)
	
	