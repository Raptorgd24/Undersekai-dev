/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
// obj_gameover_controller - Alarm[1]
alarm[2] = room_speed*3; 
    audio_play_sound(snd_heart_shatter2, 1, false);
// Destruye el corazón y genera los pedazos
with (obj_heart) {
    var xx = x;
    var yy = y;
    instance_destroy();

    // Crear 5 piezas del corazón en direcciones aleatorias
    for (var i = 0; i < 5; i++) {
        var piece = instance_create_layer(xx, yy, "Instances", obj_heart_piece);
        
        // Movimiento inicial aleatorio
        piece.direction = irandom_range(0, 359);
        piece.speed = random_range(2, 4);
        piece.gravity = 0.3;
        piece.gravity_direction = 270; // hacia abajo
    }
}
