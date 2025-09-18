function dialogue(_personaje, _cara, _mensaje, _seguir) {
    array_push(global.dialogue_personajes, _personaje);
    array_push(global.dialogue_caras, _cara);
    array_push(global.dialogue_mensajes, _mensaje);
    array_push(global.dialogue_seguir, _seguir);

    // Si no hay diálogo activo, iniciar
    if (!global.dialogue_active) {
        global.dialogue_current = 0;
        dialogue_next();
    }
}