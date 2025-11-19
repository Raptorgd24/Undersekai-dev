/// @description Inserte aquí la descripción
// obj_mknife step
if (mode == "appear") {
    if (image_alpha < 1) {
        image_alpha += 0.015;
    }
    if (image_angle < 720) {
        image_angle += 15;
    }
    if (image_angle >= 720) {
        mode = "lock";
        alarm[0] = room_speed * 0.5; // activa alarma una sola vez
    }
}

if (mode == "lock") {
    // mientras está en lock, sigue mirando al corazón
    image_angle = point_direction(x, y, obj_heart.x, obj_heart.y);
}

if (mode == "shoot") {
    // usa el ángulo que guardamos antes de disparar
    x += lengthdir_x(sped, target_angle);
    y += lengthdir_y(sped, target_angle);
}

if (place_meeting(x, y, obj_heart)){
    if (!global.atkcooldown){
		audio_play_sound(snd_hurt,1,false)
        global.healthu -= max(1, global.enemydmg - global.DEF);
        global.atkcooldown = true;
        global.cooldowntimer = room_speed * 1.25; // 1 segundos de cooldown
		layer_set_visible("Shake", true);
		with (obj_heart)
		shake_timer = 10;
    }
}

