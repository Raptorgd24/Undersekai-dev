/// @function scr_events(_event)
/// @desc Maneja secuencias de eventos con tiempos.
/// @param _event -> número de evento a lanzar

function scr_events(_event) {
    
    // Cada evento tiene una lista de pasos [tiempo, acción]
    switch (_event) {
        
        case 1:
            global.event_time = 0;        // reinicia el contador
            global.event_step = 0;        // en qué paso vamos
            
            global.event_datalol = [
                [0,   function() { scr_dialogue("noone", 8, "The flowers aren't blooming lmao", false); }],
                [120, function() { scr_dialogue("noone", 8, "Maybe they need water?", false); }],
                [240, function() { scr_dialogue("noone", 8, "Or maybe it's just winter...", false); }]
            ];

            // Cambiar randomassbool a false después de 5 segundos
            alarm[0] = room_speed * 5;
        break;
    }
}

// En el objeto donde defines randomassbool, agrega:
alarm[0] = function() {
    randomassbool = false;
}
