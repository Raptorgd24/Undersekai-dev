// obj_Rory_Nyte - Step
if (can_move) {
    t += 0.02;
    var sin_t = sin(t), cos_t = cos(t);
    x = origin_x + amplitude_x * sin_t / (1 + sqr(cos_t));
    y = origin_y + amplitude_y * sin_t * cos_t / (1 + sqr(cos_t));

}

// Si recibió daño, reproducir animación de golpe
if (is_hurt) {
    // reproducir sonido de slash una sola vez cuando se marca is_hurt
    if (!variable_instance_exists(id, "hurt_sound_played") || hurt_sound_played == false) {
        //show_damage_numbers(x+60, y+20, round(obj_battle_menu.dmg));
		        with (obj_battle_menu) {
					var ex = px;
					var ey = py;
					instance_create_layer(ex + 10, ey - 10, "Instances_1", obj_miss);
					
				}

        
        if (lePrecision >= 0.95){
           // audio_play_sound(snd_megaslashed, 1, false);

            with(obj_battle_menu){
                alarm[0] = ceil(room_speed * 0.00001);
            }
            lePrecision =0;
        }
        else{
            //audio_play_sound(snd_slashed, 1, false);
        }
        hurt_sound_played = true;

        // --- Activar el shake al recibir daño ---
        //shake_time = 30; // frames de duración
    }


} 


// --- Aplicar el efecto de shake si está activo ---
if (shake_time > 0) {
    shake_time -= 1;
    x = shake_origin_x + random_range(-shake_power, shake_power);
}

if (sans_miss) {

    switch (move_state) {

        case 0: // moverse rápido a la izquierda
            x += move_speed;

            // empezar a frenar cuando ya ha avanzado un poco
            if (x < origin_x - 80) {
                move_state = 1;
            }
        break;

        case 1: // desacelerar hasta 0
            move_speed = lerp(move_speed, 0, 0.1);
            x += move_speed;

            if (abs(move_speed) < 0.1) {
                move_speed = 0;
                move_state = 2;
            }
        break;

        case 2: // volver a la derecha
            move_speed = lerp(move_speed, 6, 0.05);
            x += move_speed;

            if (x >= target_x) {
                x = target_x;
                move_state = 3;
                // cambiar sprite de las piernas
                with (legs) {
                    image_index = 0;
                }
            }
        break;

        case 3:
		sans_miss = false;
            can_move = true;
    with (torso) { 
		can_move = true;
    }

    with (legs) {
        can_move = true;
    }			
        break;
    }

    // mover también torso y piernas
    with (torso) {
        x = other.x - 14;
    }

    with (legs) {
        x = other.x - 6;
    }
}