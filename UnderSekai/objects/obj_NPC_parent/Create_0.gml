
// Crear 

function npc_dialogue() {

    var _talked   = scr_get_global_data("tutorial_talked",  false);
    var _skipped  = scr_get_global_data("tutorial_skipped", false);
    var _done     = _talked || _skipped;

    if (_done) {
        var dialogue_post = {
            messages: [
                {
                    text: "hey.\nrecuerdas lo que te enseñé?",
                    character: "sans",
                    face_index: 0,
                    keep_box: true
                },
                {
                    text: "bien.\nsigue practicando.",
                    character: "sans",
                    face_index: 4,
                    keep_box: false
                }
            ],
            release_move: true
        };
        dialogue_start(dialogue_post);
        return;
    }

    var dialogue_intro = {
        messages: [
            {
                text: "hey, chico.\nbienvenido al underground.",
                character: "sans",
                face_index: 0,
                keep_box: true
            },
            {
                text: "este sitio... no es exactamente\nlo que esperabas, ¿verdad?",
                character: "sans",
                face_index: 3,
                keep_box: true
            },
            {
                text: "aquí la gente te conoce\npor lo que cantas.\no por lo que luchas.",
                character: "sans",
                face_index: 0,
                keep_box: true
            },
            {
                text: "si llegas a cantar lo suficiente...\npuedes llegar a ser famoso\nen este sekai.",
                character: "sans",
                face_index: 12,
                keep_box: true
            },
            {
                text: "pero eso lo aprenderás\ncuando te lo demuestre.\n¿listo?",
                character: "sans",
                face_index: 0,
                keep_box: false
            }
        ],
        release_move: false
    };

    dialogue_start(dialogue_intro, function() {
        scr_set_global_data("tutorial_talked", true);
        scr_start_battle("Sans_Tutorial");
    });
}


npc_id = "default"; // Declarar variable
NPCmoving     = false;
NPCdirection  = "down";
NPCframes     = 0;
NPCspeed      = 1;
NPCmoonwalk   = false;


anim_timer    = 0;
anim_speed    = 0.1; 
last_dir      = "down";

post_walk_dialogues = false;
has_talked_extra = false;
can_walk_event = false;

show_debug_message("[obj_NPC_parent:Create] NPC creado con npc_id=" + string(npc_id));
