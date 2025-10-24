// obj_attack_bar - Step
// ======================

// Inicialización de posición (solo una vez)
if (!inited) {
    x = start_x;
    y = y_pos;
    inited = true;
}

// Calcular el centro y movimiento
center_x = (start_x + end_x) / 2;

// Movimiento de la barra
if (moving && !stopped) {
    x += speed;
    if (x >= end_x) {
        // Llegó al final sin presionar: MISS
        x = end_x;
        moving = false;
        stopped = true;
        did_hit = false;

        // Notificar al menú que empiece turno enemigo


        instance_destroy();
        exit;
    }
}

// Input Z/Enter para detener la barra (ataque)
if (!stopped && (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter))) {
    // Parar la barra
    stopped = true;
    moving = false;
    speed = 0;

    // === NUEVA LÓGICA DE DAÑO (tipo Undertale, precisa y escalada) ===

    var dist = abs(x - center_x);   // distancia del golpe al centro
    var max_range = 60;             // rango máximo donde aún hay daño (ajustable)
    precision = clamp(1 - (dist / max_range), 0, 1); // 1 = perfecto, 0 = lejos
	if (precision >= 0.95) {
		with(obj_battle_menu){
		alarm[1] = ceil(room_speed * 0.00001);
		}
	}
	with (obj_battle_menu){
		 otraPrecisionSOB = other.precision
	with (theEnemy){
		lePrecision = other.otraPrecisionSOB;
	}
	}
    // Parámetros ajustables para daño
    var min_mult = 0.25;            // daño mínimo relativo al ATK
    var max_mult = 2.5;             // daño máximo relativo al ATK
    var flat_bonus = 8;             // bono plano extra para el centro

    // Calcular min y max posibles antes de defensa
    var min_damage = max(1, round(global.ATK * min_mult));
    var max_damage = max(1, round(global.ATK * max_mult + flat_bonus));

    // Interpolación entre min y max según precisión
    var raw_damage = lerp(min_damage, max_damage, precision);

    // Obtener defensa del enemigo
    var defense = 0;
    if (instance_exists(battle_id)) {
        with (battle_id) {
            defense = enemyDefense;
        }
    }

    // Daño final (restando defensa)
    damage = max(1, round(raw_damage) - defense);

    // === FIN DE LÓGICA DE DAÑO ===

    did_hit = true;

    // Animación visual del ataque (parpadeo o frames)
    image_speed = 0.45;
    image_index = 0;

    // Crear efecto visual (slash) en el enemigo si existe el menú de batalla
    if (instance_exists(battle_id)) {
        with (battle_id) {
            var ex = px;
            var ey = py;
            var sl = instance_create_layer(ex + 10, ey - 10, "Instances", obj_slash);
            if (instance_exists(sl)) {
                sl.owner_bar = id;        // referencia a esta barra
                sl.battle_id = other.id;  // referencia al menú de batalla
            }
        }
    } else {
        // Fallback: crear el slash en la posición de la barra
        var sl2 = instance_create_layer(x, y, "Instances", obj_slash);
        if (instance_exists(sl2)) {
            sl2.owner_bar = id;
            sl2.battle_id = noone;
        }
    }

    // Sincronizar: aplicar daño tras un pequeño retraso (para que el slash se vea)
    alarm[0] = ceil(room_speed * 0.35);

    // (Opcional) feedback visual del golpe según precisión
    if (precision >= 0.95) {
        image_blend = c_yellow;
		audio_play_sound(snd_noise, 1, false);
		audio_play_sound(snd_slash, 1, false,1,0,0.8);

	}
	else{
	audio_play_sound(snd_slash, 1, false);
	image_blend = c_white;
	
	}


}
