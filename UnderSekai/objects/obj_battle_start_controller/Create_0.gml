// Variables de control
timer = 0;
phase = 0;
black_alpha = 0;
blink_count = 0;
blink_speed = 6;
once = false;
// Crear el corazón temporal para la transición
var px = obj_player.x + 3;
var py = obj_player.y + 15;

transition_heart = instance_create_layer(px, py, "Instances_1", obj_heart);
transition_heart.image_alpha = 0;

// Desactivar el jugador
with (obj_player) {
    can_move = false;
}
with (obj_usable) {
    can_use = false;
}
