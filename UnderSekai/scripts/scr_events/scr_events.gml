
function scr_events(_event) {
    
    // Cada evento tiene una lista de pasos [tiempo, acción]
    switch (_event) {
        
		case 1:
			show_debug_message("scr_events: arrancando evento 1; event_time reset a -1; alarm puesta");
			obj_player.can_move = false;
			// Mostrar primer mensaje inmediatamente
			scr_dialogue("noone", 8, "The flowers aren't blooming lmao", false);

			global.event_datalol = [
			    ["after_dialogue", function() {
					// Crear explosión en la posición del jugador (obj_boom_temp debe existir)
					if (instance_exists(obj_player)) {
					    instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_boom_temp);
					    audio_play_sound(snd_boom, 1, false);
					}

			        // luego mostrar más diálogo si quieres
			        scr_dialogue("noone", 8, "Maybe they need water?", false);
			    }]
			];



		    // scr_events configura la alarma sobre la instancia que llama (alarm[0] = room_speed * 5;)
		    alarm[0] = room_speed * 5;
			obj_player.can_move = true;
		break;

    }
}

// En el objeto donde defines randomassbool, agrega:
alarm[0] = function() {
    obj_eventTrigger.randomassbool = false;
}
