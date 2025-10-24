// obj_battle_menu - Create
/// @desc Inicialización del menú de batalla (controlador principal)
image_alpha = 0;
depth = -100;

// Estado / modos: "menu" | "enemy_select" | "attacking" | "enemy_turn"
mode = "menu";
seleccion = 0;
selected_obj = noone;
songbattle = mus_nuzzle;
// Opciones del menú
opciones = ["FIGHT","ACT","ITEM","MERCY"];

// Posiciones botones / caja de texto
boton_x_inicial = 45;
boton_y = 410;
boton_espaciado = 145;

box_x = 45;
box_y = 245;
box_width = 280;
box_height = 78;

// Enemigo por defecto (valores manejados desde aquí)
enemyName = "Test";
enemyHealth = 50;
enemyDefense = 0;
theEnemy = noone; // instancia real del enemigo (si existe)
px = 129; py = 27; // posiciones por defecto para crear enemigos
turntime= 5;

dmg = 0;
otraPrecisionSOB =0;
// Texto inicial
text_to_show = "* Random Encounter!";

lebox = instance_create_layer(0, -870, "Instances", obj_thebox);
//lebox.x = -50
//lebox.y = -500
// Guardamos referencia global para otros objetos (fallback)
global.battle_menu = id;

// Inicializar según global.enemy (mapeo simple -> añade más casos según necesites)
if (variable_global_exists("enemy")) {
    switch (global.enemy) {
        case "Rory_Nyte":
			songbattle = mus_roaringfraud
            audio_play_sound(songbattle, 1, true);
            theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
            text_to_show = "* The Roaring Knight appears.";
            enemyName = "Roaring Knight";
            enemyHealth = 40000;
			enemyDefense = -800;
            break;
        case "Negru":
            // ejemplo: si Negru comparte ciclo con Rory_Nyte de momento reutilizamos
            audio_play_sound(songbattle, 1, true);
            theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
            text_to_show = "* The Roaring Knight appears.";
            enemyName = "Roaring Knight";
            enemyHealth = 40000;
			enemyDefense = 300;
            break;
        case "Mogus":
            audio_play_sound(songbattle, 1, true);
			theEnemy = instance_create_layer(px, py, "Instances", obj_mogus);
            text_to_show = "* Something feels sus!";
            enemyName = "The Impostor";
            enemyHealth = 50;
			enemyDefense = -3;
            break;
		default:
		    audio_play_sound(songbattle, 1, true);
			theEnemy = instance_create_layer(px, py, "Instances", obj_mogus);
            text_to_show = "* The Roaring Knight doesn't appear.";
            enemyName = "Test";
            enemyHealth = 50;
			enemyDefense = 3;
            break;
    }
}

// Configurar obj_thebox (si existe) para mostrar texto
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

// Configurar obj_heart (posición inicial)
if (instance_exists(obj_heart)) {
    with (obj_heart) {
        mode = "select";
        // posicionarlo sobre la opción actual
        x = other.boton_x_inicial + other.seleccion * other.boton_espaciado + 4;
        y = other.boton_y + 6;
        target_x = x;
        target_y = y;
    }
}

// Bloquear movimiento del jugador fuera de batalla
if (instance_exists(obj_player)) {
    with (obj_player) {
        can_move = false;
        visible = false;
    }	
}

// Turno y control
turn = "player"; // "player" | "enemy"
fight_timer = 0;
attack_power = 0;
text_done = false;

// Alarma por defecto no usada (se usan alarm[2]/alarm[3] para turno enemigo)
alarm[0] = -1;
alarm[1] = -1;
alarm[2] = -1;
alarm[3] = -1;


// zoom cosos
default_cam_w = 320;
default_cam_h = 240;
zoom_target = 0.75;      // 0.75 = 75% del tamaño -> zoom in suave
zoom_speed = 0.02;
zooming = false;
zoom_current = 1.0;
zoom_sprite_id = noone;  // guardaremos la instancia del sprite central aquí

global.ps = part_system_create_layer("Particles", false);