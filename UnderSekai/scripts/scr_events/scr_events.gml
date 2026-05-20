function scr_events(_event) {
    switch (_event) {
        case 1:
            var event_struct = {
                steps: [
                    {
                        action: function() {
                            // Bloquear movimiento
                            obj_player.can_move = false;
                            obj_usable.can_use = false;
                            
                            // Diálogo inicial
                            var dialogue = {
                                messages: [
                                    { text: "don't make another step kid...", character: "sans", face_index: 10, keep_box: true },
                                    { text: "this time i'm serious", character: "sans", face_index: 7, keep_box: true },
                                    { text: "so serious I could eat a horse", character: "sans", face_index: 4, keep_box: false }
                                ],
                                release_move: false
                            };
                            dialogue_start(dialogue, function() {
                                global.event_manager.waiting_for_dialogue = true;
                            });
                        }
                    },
                    {
                        action: function() {
                            // Buscar NPC
                            global.event_manager.npc = noone;
                            with (obj_NPC_parent) {
                                if (variable_instance_exists(id, "npc_id") && npc_id == "sans") {
                                    global.event_manager.npc = id;
                                }
                            }
                            
                            if (global.event_manager.npc != noone) {
                                scr_npcwalk(global.event_manager.npc, "left", 180, 1, false);
                                global.event_manager.waiting_for_walk = true;
                            }
                        }
                    },
                    {
                        action: function() {
                            // Segundo diálogo
                            var dialogue = {
                                messages: [
                                    { text: "anyway kid...", character: "sans", face_index: 0, keep_box: true },
                                    { text: "im going to fly away", character: "sans", face_index: 0, keep_box: true },
                                    { text: "wooooo", character: "sans", face_index: 0, keep_box: false }
                                ],
                                release_move: false
                            };
                            dialogue_start(dialogue, function() {
                                global.event_manager.waiting_for_dialogue = true;
                            });
                        }
                    },
                    {
                        action: function() {
                            // Sonido y boom
                            audio_play_sound(snd_sansing, 1, false);
                            global.event_manager.boom_frames = 42;
                            global.event_manager.waiting_for_boom = true;
                        }
                    },
                    {
                        action: function() {
                            // Diálogo final
                            var dialogue = {
                                messages: [
                                    { text: "...", character: "noone", face_index: 8, keep_box: true },
                                    { text: "Huh...", character: "noone", face_index: 8, keep_box: false }
                                ],
                                release_move: true
                            };
                            dialogue_start(dialogue, function() {
                                array_push(global.events_done, "Test");
                                obj_player.can_move = true;
                                obj_usable.can_use = true;
                                global.event_manager.npc = noone;
                            });
                        }
                    }
                ]
            };
            event_start(event_struct);
            break;
		case 2:
    var _talked  = scr_get_global_data("tutorial_talked",  false);
    var _skipped = scr_get_global_data("tutorial_skipped", false);

    if (_talked || _skipped) {
        obj_player.can_move = true;
        obj_usable.can_use  = true;
        break;
    }

    var event_skip = {
        steps: [
            {
                action: function() {
                    obj_player.can_move = false;
                    obj_usable.can_use  = false;

                    var dialogue = {
                        messages: [
                            {
                                text: "hey hey hey.\n¿a dónde crees que vas?",
                                character: "sans",
                                face_index: 7,
                                keep_box: true
                            },
                            {
                                text: "no sabes que es de mala educación\npasar sin saludar?",
                                character: "sans",
                                face_index: 10,
                                keep_box: true
                            },
                            {
                                text: "ven.\nserá rápido.",
                                character: "sans",
                                face_index: 0,
                                keep_box: false
                            }
                        ],
                        release_move: false
                    };
                    dialogue_start(dialogue, function() {
                        global.event_manager.waiting_for_dialogue = true;
                    });
                }
            },
            {
                action: function() {
                    scr_set_global_data("tutorial_skipped", true);
                    scr_start_battle("Sans_Tutorial");
                }
            }
        ]
    };
    event_start(event_skip);
    break;
		
		break;
		case 3:
		
		break;
    }
}