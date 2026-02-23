// obj_Rory_Nyte - Step

if (can_move) {
    t += 0.02;
    var sin_t = sin(t), cos_t = cos(t);
    x = origin_x + amplitude_x * sin_t / (1 + sqr(cos_t));
    y = origin_y + amplitude_y * sin_t * cos_t / (1 + sqr(cos_t));

}

// --- Aplicar el efecto de shake si está activo ---
if (shake_time > 0) {
    shake_time -= 1;
    x = shake_origin_x + random_range(-shake_power, shake_power);
}
shake_origin_x = x;