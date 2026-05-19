// obj_heart - Create
mode = "intro"; // intro | select | enemy_select | fight | battle | ebd
parpadeos = 0;
alpha_state = 0;
last_room = room
target_x = x;
target_y = y;
image_alpha = 1;
move_speed = 0.2;
depth = -999999;

gui_x = 0;
gui_y = 0;
gui_scale = 2;

// Cooldown / ataque
global.atkcooldown = false; 
global.cooldowntimer = 0;
soulspeed = 1.5;
dead = false;
heart_speed_multiplier = 1;
show_debug_message("HI TWINN!!!!")