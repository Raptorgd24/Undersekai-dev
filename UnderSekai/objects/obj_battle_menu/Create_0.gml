/// @desc Inicialización del menú de batalla

image_alpha = 0;
depth = -100;

x = 0;
y = 0;

// Opciones del menú
opciones = ["FIGHT", "ACT", "ITEM", "MERCY"];
seleccion = 0;

// Posiciones base de los botones
boton_y = 410; // posición vertical donde están las opciones
boton_espaciado = 145; // distancia entre opciones
boton_x_inicial = 45;  // posición X inicial (igual que la caja)

// --- Caja de texto ---
box_x = 45;
box_y = 245;
box_width = 550;
box_height = 150;

// Texto inicial
text_to_show = "* The Roaring Knight appears.";

// Enemigo
px = 128;
py = 32;

if (global.enemy == "Rory_Nyte") {
    audio_play_sound(mus_roaringfraud, 1, true);
    theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
    text_to_show = "* The Roaring Knight appears.";
} else {
    audio_play_sound(mus_roaringfraud, 1, true);
    text_to_show = "* The Roaring Knight doesn't appear.";
}

// --- Configurar obj_thebox ---
with (obj_thebox) {
    x = other.box_x;
    y = other.box_y;
    box_width = other.box_width;
    box_height = other.box_height;
    text = "";
    display_text = "";
    text_index = 0;
    scale_box = 1;
}

// --- Configurar obj_heart ---
if (instance_exists(obj_heart)) {
    with (obj_heart) {
        mode = "select";
    }
}

// --- Bloquear movimiento del jugador ---
with (obj_player) {
    can_move = false;
    visible = false;
}
