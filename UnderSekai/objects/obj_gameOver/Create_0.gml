/// @description Inserte aquí la descripción
// obj_gameover - Create Event

global.cooldowntimer = 0;
image_alpha = 0; 
alarm[0] = room_speed; 

with (obj_heart){
    mode = "dead";
}

once = false;
deathsong = noone;

// Control del menú
menu_options = ["CONTINUE", "GIVE UP"];
menu_index = 0; // 0 = CONTINUE, 1 = GIVE UP

// Fuente y colores
font_menu = ft_determinationmono;
color_selected = c_yellow;
color_unselected = c_white;

// Control de transición
fade_alpha = 0; // para fundido negro
fade_speed = 0.02;
fading = false;
fade_action = ""; // "continue" o "giveup"

// Variables para sprites decorativos
spr_glow_alpha = 0;
spr_ble_alpha = 0;

// Crea los sprites base (puedes ponerlos en Draw también si prefieres)

;