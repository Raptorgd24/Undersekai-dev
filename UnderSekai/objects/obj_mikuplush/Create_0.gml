talk = 0;

function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };

    if (talk == 0) {

        array_push(dialogue_struct.messages, {
            text: "* Es un peluche de Miku gigante.",
            character: "",
            face_index: 0,
            keep_box: false
        });

        talk = 1;

    } else {

        array_push(dialogue_struct.messages, {
            text: "* Blandito...",
            character: "",
            face_index: 0,
            keep_box: false
        });

        talk = 0;
    }

    dialogue_start(dialogue_struct);
}