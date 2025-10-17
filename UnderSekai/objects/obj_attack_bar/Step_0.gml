/// obj_attack_bar - Step
show_debug_message("obj_attack_bar - Step start (moving:" + string(moving) + " stopped:" + string(stopped) + ")");

// 1) Obtener coordenadas desde battle_id si existe
    show_debug_message("battle_id existe, usando coordenadas del menú");
    with (battle_id) {
        // copiamos a las variables de la instancia actual (other)
        other.start_x = box_x -18;
        other.end_x   = box_x +246 ;
        other.y_pos   = box_y - 126;
    }


// 2) Inicializar la posición de la barra si no lo hemos hecho
if (!variable_instance_exists(id, "inited") || inited == false) {
    // fijamos la posición inicial solo una vez
    x = start_x;
    y = y_pos;
    inited = true;
    show_debug_message("Inicializada posición barra: x=" + string(x) + " y=" + string(y));
}

// 3) Centro y debug
center_x = (start_x + end_x) / 2;
show_debug_message("start_x: " + string(start_x) + ", end_x: " + string(end_x) + ", center_x: " + string(center_x));

// 4) Movimiento: solo incrementamos si moving==true y stopped==false
if (moving && !stopped) {
    x += speed;
    show_debug_message("Barra moviéndose, x=" + string(x));
    if (x >= end_x) {
        // llegó al final sin pulsar -> miss
        x = end_x;
        moving = false;
        stopped = true;
        did_hit = false;
        show_debug_message("Barra llegó al final sin pulsar, did_hit=false");

        // avisar al menú para iniciar turno enemigo mediante Alarm[2]
        if (variable_instance_exists(id, "battle_id") && instance_exists(battle_id)) {
            with (battle_id) {
                show_debug_message("Iniciando turno enemigo via Alarm[2]");
                alarm[2] = 1;
            }
        }
        // destruir la barra
        instance_destroy();
        exit;
    }
}

// 5) Detectar Z/Enter: AL PRESIONAR, la barra debe quedarse EXACTA donde está
if (!stopped && (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter))) {
	speed = 0;
    stopped = true;
    moving = false;     // aseguramos que NO vuelva a moverse
    did_hit = true;

    // calcular daño según cercanía al centro (usa la x actual)
    damage = max(1, 30 - abs(x - center_x) * 0.6);
    show_debug_message("Jugador presionó Z/Enter, daño calculado: " + string(damage) + " en x=" + string(x));

    // fijar comportamiento visual cuando está parado:
    // queremos que al quedarse quieto cambie de frame entre 0 y 1 constantemente
    // para eso ponemos image_speed > 0 y aseguramos que el sprite solo tenga 2 frames
    image_speed = 0.45; // ajusta la velocidad de parpadeo a tu gusto
    // forzamos que la animación solo sea entre frames 0 y 1:
    image_index = 0;

    // Crear slash sobre el enemigo (si existe battle_id y px/py accesibles)
    if (variable_instance_exists(id, "battle_id") && instance_exists(battle_id)) {
        with (battle_id) {
            var ex = px;
            var ey = py;
            var sl = instance_create_layer(ex+10 , ey - 10, "Instances", obj_slash);
            if (instance_exists(sl)) {
                sl.owner_bar = id;
                show_debug_message("obj_slash creado sobre el enemigo");
            }
        }
    } else {
        show_debug_message("battle_id no existe al crear obj_slash (fallback)");
        var sl2 = instance_create_layer(x, y, "Instances", obj_slash);
        if (instance_exists(sl2)) sl2.owner_bar = id;
    }

    // sonar slash y esperar alarma para aplicar daño
    audio_play_sound(snd_slash, 1, false);
    alarm[0] = ceil(room_speed * 0.25);
    show_debug_message("Alarm[0] configurada para aplicar daño y pasar turno");
}

// 6) Si ya está parado, mantener la animación "parpadeo" entre frame 0 y 1.
//    Si el sprite tiene más frames, forzamos clamping entre 0 y 1
if (stopped) {
    // Si sprite tiene >=2 frames, forzamos el loop entre 0-1:
    if (image_number >= 2) {
        // asegurar que no llegue a otros frames:
        if (image_index >= 2) image_index = 0;
        // image_speed ya fue puesto al parar; cuando destruimos la barra, volverá a 0
    } else {
        // si no tiene 2 frames, simplemente lo dejamos en el frame 0
        image_speed = 0;
        image_index = 0;
    }
}
