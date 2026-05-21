
function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };


        array_push(dialogue_struct.messages, {
            text: "* Es otra foto de Miku.",
            character: "",
            face_index: 0,
            keep_box: true
        });

        array_push(dialogue_struct.messages, {
            text: "* Parece que esta en un escenario\n  colorido.",
            character: "",
            face_index: 0,
            keep_box: false
        });

    dialogue_start(dialogue_struct);
}