// Crear 

function npc_dialogue() {
    scr_dialogue("sans", 0, "hey, soy un texto de ejemplo.", true,false);
    scr_dialogue("sans", 4, "te lo puedes creer?", false,true);
}


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
