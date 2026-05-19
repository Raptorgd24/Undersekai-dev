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
    act_options = [];

    switch (global.enemy) {
        case "Sans":
            act_options = ["CHECK", "PUN", "JOKE", "SING"];
            break;
        case "Rory_Nyte":
            act_options = ["CHECK", "HOLDBREATH", "SING"];
            break;
        case "Mogus":
            act_options = ["CHECK", "SABOTAGE", "TASK", "SING"];
            break;
        default:
            act_options = ["CHECK","GIVE FAME", "ULTRA MERCY", "SING"];
    }

    selected_act_index = 0;
    act_row = 0;
    act_col = 0;

    // 🧠 TEXTO UI
    if (instance_exists(obj_thebox)) {
        var options_text = "";
        var len = array_length(act_options);

        for (var i = 0; i < len; i += 2) {
            var line = " * " + act_options[i];
            if (i + 1 < len) {
                line += "           * " + act_options[i + 1];
            }
            options_text += line + "\n";
        }

        with (obj_thebox) {
            text = options_text;
            display_text = "";
            text_index = 0;
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


case "MERCY":

    mercy_selection = 0;

    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            text = "*     Spare\n*     Flee";
            display_text = "";
            text_index = 0;
        }
    }

    mode = "mercy_menu";

break;
        }
    }

    // Actualizar sprites de botones (resaltado)
    for (var i = 0; i < array_length(menu_objs); i++) {
                menu_objs[i].image_index = (i == seleccion) ? 1 : 0;
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
			scr_trans(last_room, global.player_return_x, global.player_return_y)
		}
	}
}
else if (mode == "mercy_menu") {

    // --- POSICIONAR CORAZÓN ---
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "mercy";
            x = other.box_x + 23 ;
            y = other.box_y - 116 + other.mercy_selection * 14.2;
        }
    }

    // --- MOVIMIENTO ---
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        mercy_selection = 0;
        audio_play_sound(snd_menumove, 1, false);
    }

    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        mercy_selection = 1;
        audio_play_sound(snd_menumove, 1, false);
    }

    // --- CANCELAR ---
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {

        mode = "menu";

        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                text = other.text_to_show;
                display_text = "";
                text_index = 0;
            }
        }

        exit;
    }

    // --- CONFIRMAR ---
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
		obj_mercy.image_index = 0;
        audio_play_sound(snd_select, 1, false);

        // =========================
        // ======= SPARE ===========
        // =========================
        if (mercy_selection == 0) {
	    with (obj_heart) {
			show_debug_message("hello twin")
            x = other.box_x - 423;
            y = other.box_y - 115;
        }			

            if (enemy_mercy >= 100) {

                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "* You spared " + other.enemyName + ".";
                        display_text = "";
                        text_index = 0;
                    }
                }

                global.spares += 1;
                //global.fame += 5;
                was_spared = true;

                alarm[4] = room_speed * 2;

            } else {

                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "* " + other.enemyName + " won't accept your mercy!\n* Mercy: " + string(other.enemy_mercy) + "/100";
                        display_text = "";
                        text_index = 0;
                    }
                }

                mode = "dialogue";
                alarm[5] = 1;
            }
        }

        // =========================
        // ======= FLEE ============
        // =========================
        else {

            var chance = irandom_range(0, 100);

            if (chance < 50) {
				
			audio_stop_sound(songbattle)

                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "* You ran away!";
                        display_text = "";
                        text_index = 0;
                    }
                }


                mode = "end";

            } else {

                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "* You couldn't escape!";
                        display_text = "";
                        text_index = 0;
                    }
                }

                mode = "dialogue";
                alarm[5] = 1;
            }
        }
    }
}
else if (mode == "dialogue") {

    if (dialogue_box == noone || !instance_exists(dialogue_box)) {
        mode = "enemy_turn";
        exit;
    }

    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        // Solo permitir continuar si el texto está completo
        if (dialogue_box.text_index >= string_length(dialogue_box.text)) {
            // siguiente texto
            if (dialogue_data.cont) {
                dialogue_index++;
                dialogue_data = scr_getbattletext(dialogue_index, hit_count);

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
                dialogue_index=0;
                if (instance_exists(dialogue_box)) {
                    instance_destroy(dialogue_box);
                }
                dialogue_box = noone;
                
                // Iniciar turno enemigo vía alarma
                if (is_item_result) {
                    is_item_result = false;
                }
                mode = "enemy_turn";
                alarm[2] = 1;
            }
        } else {
            // completar texto si no está completo
            dialogue_box.text_index = string_length(dialogue_box.text);
            dialogue_box.display_text = dialogue_box.text;
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


else if (mode == "item_result") {
    if (instance_exists(obj_thebox)) {
        // Solo permitir input si el texto está completo
        if (obj_thebox.text_index >= string_length(obj_thebox.text)) {
            if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
                // fin del resultado del item
                is_item_result = false;
                mode = "dialogue";
                alarm[5] = 1;
            }
        }
        
        if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
            // completar texto
            if (obj_thebox.text_index < string_length(obj_thebox.text)) {
                obj_thebox.text_index = string_length(obj_thebox.text);
                obj_thebox.display_text = obj_thebox.text;
            }
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
		obj_item.image_index = 0;
        audio_play_sound(snd_select, 1, false);
		scr_destroy_menu_items()
        var item = global.objects[selected_item_index];
        var data = scr_item_data(item);

        var item_result = scr_useitem(item);

        // si es food → eliminar
        if (data.type == "food") {
            array_delete(global.objects, selected_item_index, 1);

            if (selected_item_index >= array_length(global.objects)) {
                selected_item_index = max(0, array_length(global.objects) - 1);
            }
        }

        // Mostrar resultado del item en obj_thebox
        mode = "item_result";
        is_item_result = true;
        
        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                text = item_result.text;
                display_text = "";
                text_index = 0;
            }
        }
    }
}




else if (mode == "act_select") {
    // Navegación por filas y columnas
    var len = array_length(act_options);
    var num_rows = ceil(len / 2.0);
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        act_col = min(act_col + 1, 1);
    }
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
        act_col = max(act_col - 1, 0);
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        act_row = (act_row + 1) % num_rows;
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        act_row = (act_row - 1 + num_rows) % num_rows;
    }
    // Calcular selected_act_index
    selected_act_index = act_row * 2 + act_col;
    if (selected_act_index >= len) {
        selected_act_index = len - 1;
        act_col = (len % 2 == 0) ? 1 : 0;
    }

    // Posicionar corazón según fila y columna (hardcodeado)
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "act_select";
            x = 35 + other.act_col * 135;
            y = 129 + other.act_row * 14.2;
        }
    }

    // Salir
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        mode = "menu";
        if (instance_exists(obj_thebox)) with (obj_thebox) {
            text = other.text_to_show;
            display_text = "";
            text_index = 0;
        }
    }

    // Seleccionar
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
		obj_act.image_index = 0;
		    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            //mode = "enemy_select"; // reutilizamos estado ya existente
            x = other.box_x - 423;
            y = other.box_y - 115;
        }
    }

        audio_play_sound(snd_select, 1, false);
        selected_act = act_options[selected_act_index];
        switch (selected_act) {
            case "CHECK":
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* " + other.enemyName + " - ATK " + string(other.enemyAttack) + " DEF " + string(other.enemyDefense);
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "HOLDBREATH":
                if (instance_exists(obj_heart)) {
                    obj_heart.heart_speed_multiplier += 0.5;
                }
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* You take a deep breath.\n* Your movement speed increased.";
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "PUN":
                enemyHealth -= 5;
                enemy_mercy += 10;
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* You tell a pun.\n* " + other.enemyName + " seems annoyed.";
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "JOKE":
                enemyHealth -= 3;
                global.fame += 5;
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* You tell a joke.\n* The crowd laughs.";
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "SABOTAGE":
                enemy_mercy = min(enemy_mercy + 100, 100);
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* You sabotage the lights!";
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "ULTRA MERCY":
                enemy_mercy = min(enemy_mercy + 100, 100);
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* Super test mercy, mercy set at 100";
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "GIVE FAME":
                global.fame += 125;
                if (instance_exists(obj_thebox)) with (obj_thebox) {
                    text = "* GIMME YOUR FAME (given 125 fame)";
                    display_text = "";
                    text_index = 0;
                }
                mode = "act_result";
                break;
            case "TASK":
                if (!task_used) {
                    global.fame += 2;
                    task_used = true;
                    if (instance_exists(obj_thebox)) with (obj_thebox) {
                        text = "* You helped them complete a task!";
                        display_text = "";
                        text_index = 0;
                    }
                } else {
                    if (instance_exists(obj_thebox)) with (obj_thebox) {
                        text = "* You already helped them.";
                        display_text = "";
                        text_index = 0;
                    }
                }
                mode = "act_result";
                break;
case "SING":
    if (instance_exists(obj_thebox)) with (obj_thebox) {
        text         = "";
        display_text = "";
        text_index   = 0;
    }

    // Inicializar el sistema (scr_sing_init ahora retorna el manager)
    var sing_mgr = scr_sing_init(id);

    if (instance_exists(sing_mgr)) {
        // Cargar chart de prueba (reemplazar con chart del enemigo según global.enemy)
        var chart = scr_sing_create_test_chart();
        scr_sing_load_chart(sing_mgr, chart);

        // Activar DESPUÉS de cargar el chart para evitar que el Step corra con lista vacía
        sing_mgr.chart_active = true;

        mode = "sing_chart";
    } else {
        // Fallback si el manager no se pudo crear
        show_debug_message("[battle_menu] ERROR: sing_mgr no se pudo crear, saltando a act_result.");
        if (instance_exists(obj_thebox)) with (obj_thebox) {
            text         = "* The song got stuck in your throat...";
            display_text = "";
            text_index   = 0;
        }
        mode = "act_result";
        selected_act = "SING";
    }
    break;
        }
    }
}
else if (mode == "act_result") {
    if (instance_exists(obj_thebox)) {

        // esperar a que termine el texto
        if (obj_thebox.text_index >= string_length(obj_thebox.text)) {

            // esperar INPUT del jugador
            if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {

                dialogue_index = 0;

                switch (selected_act) {
                    case "SABOTAGE":
                        dialogue_index = 0;
                        break;

                    case "TASK":
                        dialogue_index = 1;
                        break;
                    
                    case "SING":
                        // Reanudar la música después de sing
                        audio_resume_sound(song_instance);
                        dialogue_index = -1;
                        break;

                    default:
					if (global.enemy !="Sans")
                        dialogue_index = -1;
                        break;
                }

                // cerrar caja ANTES de cualquier cosa
                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        // opcional: ocultar instantáneo
                        text = "";
                        display_text = "";
                        text_index = 0;
                    }
                }

                alarm[5] = 1;
            }
        }

        // skip texto
        if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
            obj_thebox.text_index = string_length(obj_thebox.text);
            obj_thebox.display_text = obj_thebox.text;
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

// MODO CHARTING (SING)
else if (mode == "sing_chart") {
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            target_y = 300;
        }
    }
    
    if (!instance_exists(obj_sing_manager)) {
        if (instance_exists(obj_thebox)) {
            with (obj_thebox) {
                target_y = 110;
            }
        }
        mode = "act_result";
    }
}

// MODO TURNO ENEMIGO
else if (mode == "enemy_turn") {
    bulletcooldown -= 1;
    if (bulletcooldown <= 0) {
        bulletcooldown = bulletcooldownOG;
        bullets = instance_create_layer(choose(bullet_x, bullet_x2), choose(bullet_y, bullet_y2), "Instances_1", bullet);
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

