function npc_dialogue() {
    var dialogue = {
        messages: [
            { text: "Son unas flores muy bonitas.", face_index: 8 }
        ],
        character: "noone",
        on_end: function() { /* nada */ }
    };
    dialogue_start(dialogue);
}

image_alpha = 0; // El objeto empieza invisible
