talk = 0;

function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };

    if (talk == 0) {

        array_push(dialogue_struct.messages, {
            text: "* Si abres esta puerta terminaras\n  tu aventura.",
            character: "",
            face_index: 0,
            keep_box: true
        });

        array_push(dialogue_struct.messages, {
            text: "* Quieres finalizar la demo?",
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
                    text: "Entrar",
                    owner: id,

                    action: function() {
					scr_trans(rm_ruins13,78,172)
                    }
                },

                {
                    text: "Seguir Explorando",

                    action: function() {}
                }
            ]
        });

    }

    dialogue_start(dialogue_struct);
}