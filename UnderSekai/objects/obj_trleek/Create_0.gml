talk = 0;
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
            text: "* Quieres coger uno?",
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
                    owner: id,

                    action: function() {

                        with (owner) {
                            image_index = 1;
                            talk = 1;
                        }

                        scr_giveitem("Puerro");
                    }
                },

                {
                    text: "Dejarlo",

                    action: function() {}
                }
            ]
        });

    } else {

        array_push(dialogue_struct.messages, {
            text: "* La avaricia rompe el saco.",
            character: "",
            face_index: 0,
            keep_box: false
        });
    }

    dialogue_start(dialogue_struct);
}