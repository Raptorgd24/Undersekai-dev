function scr_advance_intro() {
    if (intro_state == "waiting_input") {
        // Verificar si hay más textos
        if (intro_current_text < array_length(intro_texts) - 1) {
            // Hay más textos, pasar al siguiente
            intro_current_text++;
            intro_char_index = 0;
            intro_display_text = "";
            intro_state = "writing";
        } else {
            // No hay más textos, iniciar transición de sprite
            intro_state = "sprite_transition";
            
            // Crear obj_menusprite para la transición
            var menu_sprite = instance_create_depth(0, 0, 0, obj_menusprite);
            menu_sprite.target_sprite = sprite_sequence[current_sprite_index];
            menu_sprite.fade_mode = "to_black";
            menu_sprite.fade_is_final = (current_sprite_index >= array_length(sprite_sequence) - 1);
            
            current_sprite_index++;
        }
    }
}