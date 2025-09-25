function npc_dialogue() {
    scr_dialogue("sans", 0, "hey, soy un texto de ejemplo.", true);
    scr_dialogue("sans", 4, "te lo puedes creer?", false);
}

// --------------------- CREATE EVENT de obj_NPC_parent ---------------------

// --- Movimiento estilo player ---
base_vel = 2;
velocidad_actual = base_vel;

mx = 0;
my = 0;

// Animación
anim_speed = 0.07;   // velocidad de animación
anim_timer = 0;
last_dir = "down";
can_move = true;

// Movimiento automático
npc_state = "Idle";       // "Idle", "Up", "Down", "Left", "Right"
npc_timer = 0;            // tiempo que lleva moviéndose
npc_duration = 0;         // duración del movimiento en frames
npc_next_action = noone;  // función que se ejecuta al terminar
