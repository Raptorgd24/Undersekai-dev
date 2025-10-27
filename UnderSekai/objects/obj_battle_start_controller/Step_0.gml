timer++;

switch (phase) {
    case 0:
        if (timer >= 30) {
            phase = 1;
            timer = 0;
        }
        break;
        
    case 1:
        if (timer >= blink_speed) {
            timer = 0;
            blink_count++;
            
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
                
                var cam = camera_get_active();
                var cam_x = camera_get_view_x(cam);
                var cam_y = camera_get_view_y(cam);
                var cam_width = camera_get_view_width(cam);
                var cam_height = camera_get_view_height(cam);
                
                global.target_gui_x = cam_x + 90;  
                global.target_gui_y = cam_y + cam_height - 250;
            }
        }
        break;

    case 2:
		audio_play_sound(snd_battlefall, 1, false);
        if (!variable_global_exists("target_gui_x")) {
            var cam = camera_get_active();
            var cam_x = camera_get_view_x(cam);
            var cam_y = camera_get_view_y(cam);
            var cam_width = camera_get_view_width(cam);
            var cam_height = camera_get_view_height(cam);
            
			global.target_gui_x = 20;  
			global.target_gui_y = display_get_gui_height() - 100;
			
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
        if (timer >= 15) {
 
            room_goto(rm_NormalBattle);
            instance_destroy();
        }
        break;
}