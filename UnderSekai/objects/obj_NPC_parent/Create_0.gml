
// Crear 

function npc_dialogue() {
    var dialogue_struct = {
        messages: [],
        release_move: true
    };
    
    if (global.name == "SANS") {
        array_push(dialogue_struct.messages, {
            text: "hola, yo.",
            character: "sans",
            face_index: 0,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "yo de tu me cambiaba el nombre.",
            character: "sans",
            face_index: 3,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "porfa",
            character: "sans",
            face_index: 7,
            keep_box: false
        });
    } else {
        array_push(dialogue_struct.messages, {
            text: "hey, soy un texto de ejemplo.",
            character: "sans",
            face_index: 0,
            keep_box: true
        });
        array_push(dialogue_struct.messages, {
            text: "te lo puedes creer?",
            character: "sans",
            face_index: 4,
            keep_box: false
        });
    }
    
    dialogue_start(dialogue_struct);
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
