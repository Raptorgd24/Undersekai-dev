/// @desc Control del menú de batalla

// === MODO MENÚ PRINCIPAL ===
if (mode == "menu") {
    // Movimiento del cursor
	
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        audio_play_sound(snd_menumove, 1, false);
        seleccion = (seleccion + 1) mod 4;
		show_debug_message("Cursor derecha → seleccion: " + string(seleccion));
    }
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
        audio_play_sound(snd_menumove, 1, false);
        seleccion = (seleccion + 3) mod 4;
		show_debug_message("Cursor izquierda → seleccion: " + string(seleccion));
    }

    // Confirmar opción
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
        audio_play_sound(snd_select, 1, false);
        var opcion = opciones[seleccion];
        show_debug_message("Seleccion: " + opcion);

        switch (opcion) {
            case "FIGHT":
                mode = "enemy_select";
				show_debug_message("Entrando a modo ENEMY_SELECT");
                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "  * " + other.enemyName;
                        display_text = "  * " + other.enemyName;
                        text_index = 999;
						show_debug_message("Texto del enemigo actualizado en obj_thebox");
                    }
                }

                break;
            case "ACT":   with (obj_act)   { execute_action(); } break;
            case "ITEM":  with (obj_item)  { execute_action(); } break;
            case "MERCY": with (obj_mercy) { execute_action(); } break;
        }
    }

    // Actualizar botones
    var objs = [obj_fight, obj_act, obj_item, obj_mercy];
    for (var i = 0; i < 4; i++) {
        with (objs[i]) {
            image_index = (i == other.seleccion) ? 1 : 0;
        }
    }

    // Actualizar corazón
    if (instance_exists(obj_heart)) {
        var objs = [obj_fight, obj_act, obj_item, obj_mercy];
         selected_obj = objs[seleccion];
        
            with (obj_heart) {
                mode = "select";
                x = other.selected_obj.x + 4;
                y = other.selected_obj.y + 6;
            }
        
    }
}


// === MODO SELECCIÓN DE ENEMIGO ===
else if (mode == "enemy_select") {
    // Regresar al menú
	
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
		show_debug_message("Jugador canceló selección de enemigo, volviendo a MENU");
        mode = "menu";
        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                text = other.text_to_show;
                display_text = "";
                text_index = 0;
            }
        }
    }

    // Confirmar ataque
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
		show_debug_message("Jugador confirma ataque al enemigo");
        // Crear barra de ataque
		// en obj_battle_menu - Step, case enemy_select -> al confirmar:
		if (!instance_exists(obj_attack_bar)) {
		    var ab = instance_create_layer(-540, -540, "Instances", obj_attack_bar);
		    if (instance_exists(ab)) {
		        ab.battle_id = id; // referencia al menú
		        show_debug_message("obj_attack_bar creado por obj_battle_menu y battle_id asignado");
		    }
		}


        // Limpiar texto
        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                text = "";
                display_text = "";
                text_index = 0;
            }
        }

        mode = "attacking";

		
    }

    // Mover corazón frente al enemigo
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "enemy_select";
            x = other.box_x -3;
            y = other.box_y - 115;
        }
    }
}

// === MODO ATAQUE ===
else if (mode == "attacking") {
			with (obj_heart) {
            mode = "enemy_select";
            x = other.box_x -423;
            y = other.box_y - 115;
        }
				with (selected_obj){
			image_index = 0
		}
		
	
}

// === TURNO ENEMIGO ===

