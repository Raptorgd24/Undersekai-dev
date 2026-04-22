function scr_advance_intro() {
    if (global.intro_state == "waiting_input") {
        // Verificar si hay más textos
        if (global.intro_current_text < array_length(global.intro_texts) - 1) {
            // Hay más textos, pasar al siguiente
            global.intro_current_text++;
            global.intro_char_index = 0;
            global.intro_display_text = "";
            global.intro_state = "writing";
        } else {
            // No hay más textos, iniciar transición de sprite
            global.intro_state = "sprite_transition";
            
            // Crear obj_menusprite para la transición
            var menu_sprite = instance_create_depth(0, 0, 0, obj_menusprite);
            menu_sprite.target_sprite = global.sprite_sequence[global.current_sprite_index];
            menu_sprite.fade_mode = "to_black";
            menu_sprite.fade_is_final = (global.current_sprite_index >= array_length(global.sprite_sequence) - 1);
            
            global.current_sprite_index++;
        }
    }
}