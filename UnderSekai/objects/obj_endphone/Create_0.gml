scr_api_init();

fade_alpha = 0;
fade_speed = 1 / 180;
fading = false;
api_done = false;

if (instance_exists(obj_player)) obj_player.can_move = false;
if (instance_exists(obj_usable)) obj_usable.can_use = false;

scr_save_game();

pending_req = scr_api_save_game(global.name, global.play_time, global.route);