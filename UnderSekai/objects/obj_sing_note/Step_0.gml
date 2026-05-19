// obj_sing_note - Step

if (sing_manager == noone || !instance_exists(sing_manager)) {
    instance_destroy();
    return;
}

// Mover la nota hacia abajo
y += speed_y;

// Si la nota salió de la pantalla, destruir
if (y > 500) {
    instance_destroy();
}
