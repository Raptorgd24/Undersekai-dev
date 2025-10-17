/// @desc Inicialización del menú de batalla
image_alpha = 0; // invisible al principio
depth = -100;

// --- Estado del menú ---
mode = "menu"; // "menu" | "enemy_select" | "attacking" | "enemy_turn"
seleccion = 0;

selected_obj =noone;
// --- Opciones del menú ---
opciones = ["FIGHT", "ACT", "ITEM", "MERCY"];

// --- Posiciones de botones ---
boton_x_inicial = 45;
boton_y = 410;
boton_espaciado = 145;

// --- Caja de texto ---
box_x = 45;
box_y = 245;
box_width = 550;
box_height = 150;

// --- Enemigo por defecto ---
enemyName = "Test";
enemyHealth = 50;
px = 118;
py = 27;

// --- Texto inicial ---
text_to_show = "* What will you do?";

// --- Configurar enemigo según global.enemy ---
if (global.enemy == "Rory_Nyte") {
    audio_play_sound(mus_roaringfraud, 1, true);
    theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
    text_to_show = "* The Roaring Knight appears.";
    enemyName = "Roaring Knight";
    enemyHealth = 40000;
} else if 
(global.enemy == "Negru") {
    audio_play_sound(mus_roaringfraud, 1, true);
    theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
    text_to_show = "* The Roaring Knight appears.";
    enemyName = "Roaring Knight";
    enemyHealth = 40000;
} else {
    audio_play_sound(mus_roaringfraud, 1, true);
    text_to_show = "* The Roaring Knight doesn't appear.";
    enemyName = "Test";
    enemyHealth = 50;
}

// --- Configurar obj_thebox ---
if (instance_exists(obj_thebox)) {
    with (obj_thebox) {
        x = other.box_x;
        y = other.box_y;
        box_width = other.box_width;
        box_height = other.box_height;
        text = other.text_to_show;
        display_text = "";
        text_index = 0;
        scale_box = 1;
    }
}

// --- Configurar obj_heart ---
if (instance_exists(obj_heart)) {
    with (obj_heart) {
        mode = "select";
        x = 0;
        y = 0;
        target_x = 0;
        target_y = 0;
    }
}

// --- Bloquear movimiento jugador ---
if (instance_exists(obj_player)) {
    with (obj_player) {
        can_move = false;
        visible = false;
    }
}

// --- Turno y control interno ---
turn = "player";
fight_timer = 0;
attack_power = 0;
text_done = false;
