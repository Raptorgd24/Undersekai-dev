// Variables de control
timer = 0;
phase = 0; // 0 = espera sonido, 1 = parpadeos, 2 = mover corazón, 3 = cambiar room
black_alpha = 0;
blink_count = 0;
blink_speed = 6; // frames entre parpadeos

// Crear el corazón
var px = obj_player.x+3;
var py = obj_player.y+15;

heart = instance_create_layer(px, py, "Instances", obj_heart);
heart.image_alpha = 0;
heart.depth = -2;
// Desactivar el jugador
with (obj_player) {
    can_move = false;
}
with (obj_usable) {
    can_use = false;
}
