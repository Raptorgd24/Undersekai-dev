// Asegúrate de que el objeto a seguir existe
if (instance_exists(obj_player)) {
    // Interpolación suave hacia la posición del objetivo
    x = lerp(x, obj_player.x, seguir_velocidad);
    y = lerp(y, obj_player.y, seguir_velocidad);
}
