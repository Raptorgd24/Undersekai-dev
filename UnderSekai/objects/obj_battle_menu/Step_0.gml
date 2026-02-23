// obj_battle_menu - Step
/// @desc Control principal de estados/modos del combate

var menu_objs = [obj_fight, obj_act, obj_item, obj_mercy];

if (mode == "menu") {
    // Navegación del cursor (L/R)
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        audio_play_sound(snd_menumove, 1, false);
        seleccion = (seleccion + 1) mod array_length(opciones);
    }
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
        audio_play_sound(snd_menumove, 1, false);
        seleccion = (seleccion - 1 + array_length(opciones)) mod array_length(opciones);
    }

    // Confirmar opción
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
        audio_play_sound(snd_select, 1, false);
        var opcion = opciones[seleccion];
        switch (opcion) {
            case "FIGHT":
                // pasar a selección de enemigo / pantalla de ataque
                mode = "enemy_select";
                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "  * " + other.enemyName;
                        display_text = "  * " + other.enemyName;
                        text_index = 999;
                    }
                }
                break;
            case "ACT":
                mode = "act_select";
                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "  * " + other.enemyName;
                        display_text = "  * " + other.enemyName;
                        text_index = 999;
                    }
                }			
			break;
				
case "ITEM":
    mode = "item_select";
		if (instance_exists(obj_thebox)) {
			with (obj_thebox) {
				text = "";
                display_text = "";
                text_index = 0;
             }
        }

	selected_item_index = 0;

	if (array_length(global.objects) > 0) {
		scr_create_menu_items();
	} else {
		mode = "menu";
	}

	
break;


            case "MERCY": if (instance_exists(obj_mercy)) with (obj_mercy) { execute_action(); } break;
        }
    }

    // Actualizar sprites de botones (resaltado)
    for (var i = 0; i < array_length(menu_objs); i++) {
                menu_objs[i].image_index = (i == other.seleccion) ? 1 : 0;
    }

    // Actualizar posición del corazón sobre la opción seleccionada
    if (instance_exists(obj_heart)) {
        var target = menu_objs[seleccion];
        if (instance_exists(target)) {
            selected_obj = target;
            with (obj_heart) {
                mode = "select";
                x = other.selected_obj.x + 4;
                y = other.selected_obj.y + 6;
            }
        }
    }
}
else if (mode == "end"){
	if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
		with (obj_heart){
			
			audio_resume_sound(global.song_inst);
			scr_trans(last_room)
		}
	}
}

else if (mode == "dialogue") {

    if (!instance_exists(dialogue_box)) exit;

    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {

        // completar texto
       if (dialogue_box.text_index < string_length(dialogue_box.text)) {
            /* dialogue_box.text_index = string_length(dialogue_box.text);
            dialogue_box.display_text = dialogue_box.text;*/
        }
        else {
            // siguiente texto
            if (dialogue_data.cont) {
                dialogue_index++;
                dialogue_data = scr_getbattletext(dialogue_index);

                dialogue_box.text = dialogue_data.text;
                dialogue_box.display_text = "";
                dialogue_box.text_index = 0;
                dialogue_box.voice = dialogue_data.voice;

                if (instance_exists(theEnemy)) {
                    theEnemy.image_index = dialogue_data.face;
                }
            }
            else {
                // fin del diálogo
                if (instance_exists(dialogue_box))
                    instance_destroy(dialogue_box);

                mode = "enemy_turn";
                alarm[5] = room_speed * 1;
            }
        }
    }
	
	if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)){
	        // completar texto
        if (dialogue_box.text_index < string_length(dialogue_box.text)) {
            dialogue_box.text_index = string_length(dialogue_box.text);
            dialogue_box.display_text = dialogue_box.text;
        }
	}
}


else if (mode == "enemy_select") {
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        mode = "menu";
        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                text = other.text_to_show;
                display_text = "";
                text_index = 0;
            }
        }
        if (instance_exists(obj_heart)) {
            with (obj_heart) {
                mode = "select";
                x = other.boton_x_inicial + other.seleccion * other.boton_espaciado + 4;
                y = other.boton_y + 6;
            }
        }
    }

    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
        if (!instance_exists(obj_attack_bar)) {
            var ab = instance_create_layer(-500, 0, "Instances", obj_attack_bar);
            if (instance_exists(ab)) {
                ab.battle_id = id;     
                ab.start_x = box_x - 18;
                ab.end_x   = box_x + 240;
                ab.y_pos   = box_y - 126;
            }
        }
        // Limpiar cuadro de texto
        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                text = "";
                display_text = "";
                text_index = 0;
            }
			
			obj_fight.image_index = 0	
			
        }
        mode = "attacking";
    }

    // Mover corazón frente al enemigo (UI)
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "enemy_select";
            x = other.box_x - 3;
            y = other.box_y - 115;
        }
    }
}



else if (mode == "item_select")
{
    // reposicionar corazón
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "item_select";
            x = other.box_x - 423;
            y = other.box_y - 115;
        }
    }

    var len = array_length(global.objects);

    if (len <= 0) {
        scr_destroy_menu_items();
        mode = "menu";
        return;
    }

    // --- SALIR ---
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        audio_play_sound(snd_select, 1, false);
        scr_destroy_menu_items();
        mode = "menu";

        if (instance_exists(obj_thebox)) with (obj_thebox) {
            text = other.text_to_show;
            display_text = "";
            text_index = 0;
        }
        return;
    }

    // --- DERECHA ---
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        audio_play_sound(snd_menumove, 1, false);
        selected_item_index = (selected_item_index + 1) mod len;
        scr_update_menu_items();
    }

    // --- IZQUIERDA ---
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
        audio_play_sound(snd_menumove, 1, false);
        selected_item_index = (selected_item_index - 1 + len) mod len;
        scr_update_menu_items();
    }

    // --- USAR ITEM ---
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_select, 1, false);
		scr_destroy_menu_items()
        var item = global.objects[selected_item_index];
        var data = scr_item_data(item);

        scr_useitem(item);

        // si es food → eliminar
        if (data.type == "food") {
            array_delete(global.objects, selected_item_index, 1);

            if (selected_item_index >= array_length(global.objects)) {
                selected_item_index = max(0, array_length(global.objects) - 1);
            }
        }

        if (array_length(global.objects) <= 0) {
            scr_destroy_menu_items();
            mode = "menu";
        } else {
            scr_update_menu_items();
        }

        alarm[5] = 1;
    }
}




else if (mode == "act_select") {
	    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "act_select";
            x = other.box_x - 3;
            y = other.box_y - 115;
        }
    }

    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        mode = "menu";
        audio_play_sound(snd_select, 1, false);

        if (instance_exists(obj_thebox)) with (obj_thebox) {
            text = other.text_to_show;
            display_text = "";
            text_index = 0;
        }
    }
}
else if (mode == "attacking") {
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "enemy_select";
            x = other.box_x - 423;
            y = other.box_y - 115;
        }
    }

}

// MODO TURNO ENEMIGO
else if (mode == "enemy_turn") {

			bulletcooldown -= 1
		if (bulletcooldown <= 0){
			bulletcooldown = bulletcooldownOG
			bullets = instance_create_layer(choose(bullet_x, bullet_x2),choose(bullet_y, bullet_y2),"Instances_1",bullet)
		}
	
	

}


// Control del zoom suave
if (zooming) {
    // Suavizado hacia el objetivo
    zoom_current = lerp(zoom_current, zoom_target, zoom_speed);

    // Mantener relación 4:3
    var new_w = default_cam_w * zoom_current;
    var new_h = default_cam_h * zoom_current;

    // Calcular posición centrada
    var center_x = (default_cam_w - new_w) / 2;
    var center_y = (default_cam_h - new_h) / 2;

    // Aplicar tamaño y posición al view 0
    camera_set_view_size(view_camera[0], new_w, new_h);
    camera_set_view_pos(view_camera[0], center_x, center_y);

    // Si llegamos al zoom deseado, pasar a la siguiente alarma

}


if (shake_timer <= 0){	
	if (shake_layer != -1)
	layer_set_visible("Shake", false);
} else{
	shake_timer--	
}

