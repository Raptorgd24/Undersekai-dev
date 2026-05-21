talk = 0;
passable = true; // Declarar variable
function npc_dialogue() {
    var dialogue_struct = {
        messages: [],
        release_move: true
    };
    
    if (talk == 0) {
        array_push(dialogue_struct.messages, {
            text: "* Encuentras un arbol de puerros.",
            character: "",
            face_index: 0,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "Quieres coger uno?",
            character: "",
            face_index: 0,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "",
            character: "",
            face_index: 8,
            keep_box: false,
            choices: [
                {
                    text: "Coger uno",
                    action: function() {
                    //dar el puerro    
                    }
                },
                {
                    text: "Dejarlo",
                    action: function() { /* nada */ }
                }
            ]
        });
    }
    
    dialogue_start(dialogue_struct);
}
