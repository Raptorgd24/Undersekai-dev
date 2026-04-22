talk = 0;
passable = true; // Declarar variable
function npc_dialogue() {
    var dialogue_struct = {
        messages: [],
        release_move: true
    };
    
    if (talk == 0) {
        array_push(dialogue_struct.messages, {
            text: "hola, soy goku",
            character: "sans",
            face_index: 0,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "que porque tengo el sprite de sans?",
            character: "sans",
            face_index: 1,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "",
            character: "",
            face_index: 8,
            keep_box: false,
            choices: [
                {
                    text: "Si, dime",
                    action: function() {
                        talk = 1;
                        scr_start_battle("Goku");
                    }
                },
                {
                    text: "No me importa",
                    action: function() { /* nada */ }
                }
            ]
        });
    }
    
    dialogue_start(dialogue_struct);
}
