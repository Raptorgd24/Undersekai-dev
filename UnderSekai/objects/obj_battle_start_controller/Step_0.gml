timer++;

switch (phase) {
    case 0:
        // Espera 30 frames después del sonido
        if (timer >= 30) {
            phase = 1;
            timer = 0;
        }
        break;
        
    case 1:
        // Parpadeo de la pantalla + sonido + corazón visible sólo cuando está negro
        if (timer >= blink_speed) {
            timer = 0;
            blink_count++;
            
            // Alternar visibilidad
            if (black_alpha == 1) {
                black_alpha = 0;
                heart.image_alpha = 0;
				audio_play_sound(snd_sans, 1, false);
				with (obj_player) {
			    visible = true;
			}
            } else {
                black_alpha = 1;
                heart.image_alpha = 1;
                audio_play_sound(snd_sans, 1, false);
				with (obj_player) {
			    visible = false;
			}
            }

            if (blink_count >= 5) { // 5 parpadeos (2 fases por parpadeo)
                phase = 2;
                timer = 0;
                heart.image_alpha = 1;
                black_alpha = 1;
            }
        }
        break;

    case 2:
        // Mover suavemente el corazón hacia la posición de FIGHT
		with (obj_player) {
		visible = false;
		}		
        var target_x = obj_player.x + 100; // posición adyacente a "FIGHT"
        var target_y = obj_player.y;

        heart.x = lerp(heart.x, target_x, 0.1);
        heart.y = lerp(heart.y, target_y, 0.1);

        if (point_distance(heart.x, heart.y, target_x, target_y) < 2) {
            phase = 3;
            timer = 0;
        }
        break;

    case 3:
        // Pequeña pausa antes del cambio de habitación
        if (timer > 15) {
            room_goto(rm_NormalBattle);
            instance_destroy();
        }
        break;
}
