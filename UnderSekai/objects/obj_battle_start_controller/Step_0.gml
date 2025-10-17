timer++;

switch (phase) {
    case 0:
        // Espera inicial después del sonido
        if (timer >= 30) {
            phase = 1;
            timer = 0;
        }
        break;
        
    case 1:
        // Parpadeo de la pantalla
        if (timer >= blink_speed) {
            timer = 0;
            blink_count++;
            
            // Alternar visibilidad
            if (black_alpha == 1) {
                black_alpha = 0;
                transition_heart.image_alpha = 0;
                audio_play_sound(snd_noise, 1, false);
                with (obj_player) {
                    visible = true;
                }
            } else {
                black_alpha = 1;
                transition_heart.image_alpha = 1;
                audio_play_sound(snd_noise, 1, false);
                with (obj_player) {
                    visible = false;
                }
            }

            if (blink_count >= 5) {
                phase = 2;
                timer = 0;
                transition_heart.image_alpha = 1;
                black_alpha = 1;
                
                // Pre-calcular posición objetivo usando la cámara
                var cam = camera_get_active();
                var cam_x = camera_get_view_x(cam);
                var cam_y = camera_get_view_y(cam);
                var cam_width = camera_get_view_width(cam);
                var cam_height = camera_get_view_height(cam);
                
                // Calcular posición GUI relativa a la cámara
                global.target_gui_x = cam_x + 90;  // Offset desde borde izquierdo de la cámara
                global.target_gui_y = cam_y + cam_height - 250; // Cerca de la parte inferior
            }
        }
        break;

    case 2:
        // Mover corazón a posición GUI calculada con cámara
		audio_play_sound(snd_battlefall, 1, false);
        if (!variable_global_exists("target_gui_x")) {
            // Fallback si no se calcularon las variables globales
            var cam = camera_get_active();
            var cam_x = camera_get_view_x(cam);
            var cam_y = camera_get_view_y(cam);
            var cam_width = camera_get_view_width(cam);
            var cam_height = camera_get_view_height(cam);
            
			// En phase 2, calcular como coordenadas GUI:
			global.target_gui_x = 20;  // Coordenada GUI directa, no relativa a cámara
			global.target_gui_y = display_get_gui_height() - 100;
			
			// Y en el movimiento:
			transition_heart.gui_x = lerp(transition_heart.gui_x, global.target_gui_x, 0.1);
			transition_heart.gui_y = lerp(transition_heart.gui_y, global.target_gui_y, 0.1);
			
        }
        
        transition_heart.x = lerp(transition_heart.x, global.target_gui_x, 0.1);
        transition_heart.y = lerp(transition_heart.y, global.target_gui_y, 0.1);

        if (point_distance(transition_heart.x, transition_heart.y, global.target_gui_x, global.target_gui_y) < 2) {
            phase = 3;
            timer = 0;
           
        }
        break;

    case 3:
        // Pausa final y terminar transición
        if (timer >= 15) {
 
            // Cambiar a la habitación de batal
            room_goto(rm_NormalBattle);
            instance_destroy();
        }
        break;
}