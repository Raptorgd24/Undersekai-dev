
function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };


        array_push(dialogue_struct.messages, {
            text: "* No deberias tocar esta cama...",
            character: "",
            face_index: 0,
            keep_box: true
        });

        array_push(dialogue_struct.messages, {
            text: "* De todas formas es bastante\n  comoda.",
            character: "",
            face_index: 0,
            keep_box: false
        });

    dialogue_start(dialogue_struct);
}