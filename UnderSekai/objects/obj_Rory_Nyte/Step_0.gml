// obj_Rory_Nyte - Step

if (can_move) {
    t += 0.02;
    var sin_t = sin(t), cos_t = cos(t);
    x = origin_x + amplitude_x * sin_t / (1 + sqr(cos_t));
    y = origin_y + amplitude_y * sin_t * cos_t / (1 + sqr(cos_t));

    // Trail visual
    trail_timer++;
    if (trail_timer >= trail_interval) {
        trail_timer = 0;
        instance_create_layer(x, y, layer, obj_trail);
    }
}

// Si recibió daño, reproducir animación de golpe
if (is_hurt) {
    // reproducir sonido de slash una sola vez cuando se marca is_hurt
    if (!variable_instance_exists(id, "hurt_sound_played") || hurt_sound_played == false) {
        show_damage_numbers(x+60, y+20, round(obj_battle_menu.dmg));
        part_particles_burst(global.ps, x+20, y+20, ef_enemyDamageTest);

        image_index = 14
        if (lePrecision >= 0.95){
            audio_play_sound(snd_megaslashed, 1, false);

            with(obj_battle_menu){
                alarm[0] = ceil(room_speed * 0.00001);
            }
            lePrecision =0;
        }
        else{
            audio_play_sound(snd_slashed, 1, false);
        }
        hurt_sound_played = true;

        // --- Activar el shake al recibir daño ---
        shake_time = 30; // frames de duración
    }

    // Aseguramos que image_speed sea positivo para que la animación avance
    if (image_speed <= 0) image_speed = 0.1;

    // animar frames de daño hasta el final (ej: frame 16)
    if (image_index < 16) {
        image_index += image_speed;
    }
} 
else
{
    if (image_index < 3) {
        image_index += image_speed;
    } 
    else{
        image_index = 0;
    }
}

// --- Aplicar el efecto de shake si está activo ---
if (shake_time > 0) {
    shake_time -= 1;
    x = shake_origin_x + random_range(-shake_power, shake_power);
}
shake_origin_x = x;