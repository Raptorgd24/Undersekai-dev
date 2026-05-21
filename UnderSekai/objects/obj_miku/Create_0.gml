talk = 0;
image_index = 12;
function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };

    if (talk == 0) {

        array_push(dialogue_struct.messages, {
            text: "* Hola persona que nunca he\n  visto!",
            character: "miku",
            face_index: 0,
            keep_box: false
        });

        talk = 1;

    } else {

        array_push(dialogue_struct.messages, {
            text: "* Bienvenido a mi casa!!",
            character: "miku",
            face_index: 0,
            keep_box: false
        });

        talk = 0;
    }

    dialogue_start(dialogue_struct);
}