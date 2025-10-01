// CREATE EVENT
show_debug_message("=== INICIO INTRO ===");
image_alpha = 0; // El objeto empieza invisible
intro_state = "writing";
intro_texts = [
    "Long ago, two my dih ruled over Earth:\nVEINY and LONG.",
    "One day, war broke out between the two\nraces.",
    "After a long battle, the humans were\nvictorious."
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
scr_menudialogue();