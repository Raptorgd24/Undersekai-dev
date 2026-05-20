hsp = 0.5;
dir = 1;
trail_timer = 0;
trail_interval = 6;
is_waiting    = false;
move_timer    = irandom_range(90, 200);
wait_timer    = irandom_range(60, 150);

detected      = false;
followPlayer  = false;

current_speed = 0;
le_speed      = 4;

detect_range  = 100;

show_alert    = false;
alert_sound   = snd_encounter;
canCollide    = true;

spawn_x = x;
spawn_y = y;

zone_x1 = spawn_x - zone_half_w;
zone_y1 = spawn_y - zone_half_h;
zone_x2 = spawn_x + zone_half_w;
zone_y2 = spawn_y + zone_half_h;

returning   = false;
return_wait = 0;

anim_timer  = 0;
move_dir    = "down";

enemy_unique_id = string(room_get_name(room)) + "_" + string(x) + "_" + string(y);

if (scr_get_global_data(enemy_unique_id, false)) {
    instance_destroy();
}

use_palette = false;

if (whoAreYou == "Mogus") {
    use_palette  = true;
    sprite_index = spr_mogusoverworl;
    total_sets   = 3;
    my_row       = irandom(total_sets - 1);
}