image_alpha = 0; 
function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };

        array_push(dialogue_struct.messages, {
            text: "* 1...2...3...5...6...",
            character: "",
            face_index: 0,
            keep_box: true
        });


    dialogue_start(dialogue_struct);
}