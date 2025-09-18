function dialogue(_personaje, _cara, _mensaje, _seguir) {
    array_push(global.dialogue_personajes, _personaje);
    array_push(global.dialogue_caras, _cara);
    array_push(global.dialogue_mensajes, _mensaje);
    array_push(global.dialogue_seguir, _seguir);

    // Solo iniciar si no hay diálogo activo y no hay nada en cola
    if (!global.dialogue_active && array_length(global.dialogue_mensajes) == 1) {
        global.dialogue_current = 0;
        dialogue_next();
    }
}
