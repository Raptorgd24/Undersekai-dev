// Create Event
//normal player stuff lmao
global.ATK = (8 + (global.lv * 2))
global.DEF = (9 + ceil((global.lv / 4)))
show_debug_message("ROOM: " + string(global.room_name));
show_debug_message("NAME: " + string(global.name));
show_debug_message("LV: " + string(global.lv));
show_debug_message("HP: " + string(global.healthu));
show_debug_message("GOLD: " + string(global.gold));
show_debug_message("OBJECTS: " + string(global.objects));
show_debug_message("WEAPON: " + string(global.weapon));
show_debug_message("ARMOR: " + string(global.armor));
show_debug_message("EVENTCOSO: " + string(global.events_done));
show_debug_message("EXP: " + string(global.xp));
show_debug_message("FAME: " + string(global.fame));
show_debug_message("ROUTE: " + string(global.route));
show_debug_message("KILLS: " + string(global.kills));
show_debug_message("SPARES: " + string(global.spares));
show_debug_message("DEATHS: " + string(global.deaths));
base_vel = 2;
velocidad_actual = base_vel;
mx = 0;
my = 0;
// Control de animación
anim_speed = 0.07;   // qué tan rápido cambian los frames
anim_timer = 0;
last_dir = "down";
can_move = true;


