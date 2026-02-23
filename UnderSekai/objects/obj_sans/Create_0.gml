// obj_sans - Create (fragmento relevante)
origin_x = x;
origin_y = y;
t = 0.7;
amplitude_x = 1.8;
amplitude_y = 2.6;
shake_origin_x = x;
trail_timer = 0;
trail_interval = 6;
image_xscale = 1.3;
image_yscale = 1.3;

can_move = true;
is_hurt = false;

// Inicializar animación en estado neutral (velocidad por defecto para idle)
image_speed = 0;        // ahora tiene velocidad por defecto para que la animación avance
hurt_sound_played = false; // importante inicializar

lePrecision = 0;

// --- Variables para el shake ---
shake_time = 0;       // duración del shake
shake_power = 5;      // fuerza del movimiento lateral
   // posición base (por si se mueve)
shake_origin_x = x;
lecontinue =false;

torso = instance_create_layer(x-14, y + 30, "Instances", obj_sanstorso);
legs = instance_create_layer(x-6, y + 62, "Instances", obj_sanslegs);