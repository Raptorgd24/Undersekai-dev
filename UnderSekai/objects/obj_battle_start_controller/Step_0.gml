timer++;

var cam   = camera_get_active();
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var player_gui_x = ((obj_player.x - cam_x) / cam_w) * gui_w;
var player_gui_y = ((obj_player.y - cam_y) / cam_h) * gui_h;

switch (phase) {
case 0:
        heart_alpha = 0;

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
                heart_alpha = 0;
                with (obj_player) visible = true;
                audio_play_sound(snd_noise, 1, false);
            } else {
                black_alpha = 1;
                heart_alpha = 1;
                with (obj_player) visible = false;
                audio_play_sound(snd_noise, 1, false);
            }

            if (blink_count >= 5) {
                phase       = 2;
                timer       = 0;
                black_alpha = 1;
                heart_alpha = 1;
                with (obj_player) visible = false;
                audio_pause_sound(global.song_inst);
            }
        }
        break;

    case 2:
        if (!once) {
            once = true;
            audio_play_sound(snd_battlefall, 1, false);
        }

        heart_gui_x = lerp(heart_gui_x, target_gui_x, 0.1);
        heart_gui_y = lerp(heart_gui_y, target_gui_y, 0.1);

        if (point_distance(heart_gui_x, heart_gui_y, target_gui_x, target_gui_y) < 2) {
            heart_gui_x = target_gui_x;
            heart_gui_y = target_gui_y;
            phase       = 3;
            timer       = 0;
        }
        break;

    case 3:
        if (timer >= 15) {
            room_goto(rm_NormalBattle);
            instance_destroy();
        }
        break;
}