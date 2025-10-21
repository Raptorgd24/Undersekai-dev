// obj_Rory_Nyte - Create (fragmento relevante)
origin_x = x;
origin_y = y;
t = 0;
amplitude_x = 66;
amplitude_y = 65;

trail_timer = 0;
trail_interval = 2;
image_xscale = 1.5;
image_yscale = 1.5;

can_move = true;
is_hurt = false;

// Inicializar animación en estado neutral (velocidad por defecto para idle)
image_speed = 0.1;        // ahora tiene velocidad por defecto para que la animación avance
hurt_sound_played = false; // importante inicializar

lePrecision = 0;