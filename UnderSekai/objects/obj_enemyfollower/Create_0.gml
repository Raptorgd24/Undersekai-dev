// Movimiento base
hsp = 0.5;
dir = 1;

// Estado de patrulla: dos timers independientes
is_waiting = false;
move_timer = irandom_range(90, 200);   // frames moviéndose antes de parar
wait_timer = irandom_range(60, 150);   // frames parado antes de moverse

// Detección
detected    = false;
followPlayer = false;

// Velocidad persecución
current_speed = 0;
le_speed      = 4;

detect_range = 100;
show_alert   = false;
alert_sound  = snd_encounter;
canCollide   = true;

enemy_unique_id = string(room_get_name(room)) + "_" + string(x) + "_" + string(y);

if (scr_get_global_data(enemy_unique_id, false)) {
    instance_destroy();
}

// ── MOGUS SHADER SETUP ─────────────────────────────
use_palette = false;

if (whoAreYou == "Mogus") {
    use_palette = true;
    sprite_index = spr_mogusoverworl; // ← el sprite con los key colors, no el normal
    total_sets = 3;
    my_row = irandom(total_sets - 1);
}