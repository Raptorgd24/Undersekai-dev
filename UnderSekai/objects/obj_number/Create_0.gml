// obj_number - Create
// Control visual del número

// Variables de movimiento
vy = -3;                   // velocidad inicial hacia arriba
gravity = 0.2;             // gravedad para bajar
bounce_power = -2.5;       // fuerza del rebote
bounces = 0;               // contador de rebotes
max_bounces = 2;           // número máximo de rebotes
lifetime = room_speed * 2; // 2 segundos antes de eliminar

// Color opcional (si usas draw_self con shader o blending)
image_alpha = 1;
// Cambia el color del sprite completo
image_blend = c_red; // por ejemplo: rojo

// Alarma para eliminar tras el tiempo
alarm[0] = lifetime;
// obj_number - Create
image_xscale = 0.4;
image_yscale = 0.4;


