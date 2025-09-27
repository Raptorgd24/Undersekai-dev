// Create Event

//normal player stuff lmao
global.health = 20
global.LV = 1
global.ATK = 1
global.DEF = 1


base_vel = 2;
velocidad_actual = base_vel;

mx = 0;
my = 0;

// Control de animación

anim_speed = 0.07;   // qué tan rápido cambian los frames
anim_timer = 0;
last_dir = "down";
can_move = true;
