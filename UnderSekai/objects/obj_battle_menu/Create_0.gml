// obj_battle_menu - Create
/// @desc 
image_alpha = 0;
depth = -100;

mode = "menu";
seleccion = 0;
songbattle = mus_nuzzle;
opciones = ["FIGHT","ACT","ITEM","MERCY"];

// --- Dialogue system ---
dialogue_index = 0;
dialogue_data = undefined;
dialogue_box = noone;
dialogue_active = false;
hit_count = 0;
is_item_result = false;
enemy_turn_text_complete = false;

act_options = [];
selected_act_index = 0;
act_row = 0;
act_col = 0;
task_used = false; // Rastrear si TASK ya fue usado en esta batalla
selected_act = ""; // Acción seleccionada en ACT


selected_index = 0;        

sel_left  = noone;
sel_mid   = noone;
sel_right = noone;

selected_item_index = 0;

boton_x_inicial = 45;
boton_y = 410;
boton_espaciado = 145;

box_x = 45;
box_y = 245;
box_width = 280;
box_height = 78;

enemyName = "Test";
enemyHealth = 50;
enemyDefense = 0;
enemyAttack = 5;
enemy_mercy = 0;
was_spared = false; // Bandera para saber si el enemigo fue perdonado
player_fame = 0;
theEnemy = noone; 
px = 129; py = 27; 
global.enemydmg =0;

goldGiven = 0;
expgiven =0;

attack_name = "knifeda"
turntime= 10;
bullet = obj_mknife;
bullets = noone;
bulletcooldown = 50;
bulletcooldownOG = bulletcooldown;
bullet_x = 30;
bullet_x2 = 300;
bullet_y = 30;
bullet_y2 = 200;

shake_timer = 20;
shake_layer = -1;

dmg = 0;
otraPrecisionSOB =0;
text_to_show = "* Random Encounter!";

// Instancia de sonido para el charting
song_instance = -1;

lebox = instance_create_layer(0, -870, "Instances", obj_thebox);
//lebox.x = -50
//lebox.y = -500
global.battle_menu = id;

if (variable_global_exists("enemy")) {
    switch (global.enemy) {
        case "Rory_Nyte":
			songbattle = mus_roaringfraud
            song_instance = audio_play_sound(songbattle, 1, true);
            theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
            text_to_show = "* The Roaring Knight appears.";
            enemyName = "Roaring Knight";
            enemyHealth = 10000;
			enemyDefense = -800;
			expgiven = 10000;
			goldGiven = 9999;
			global.enemydmg = 50
			bulletcooldown = 20;
			bulletcooldownOG = bulletcooldown;
            break;
        case "Negru":
            
            song_instance = audio_play_sound(songbattle, 1, true);
            theEnemy = instance_create_layer(px, py, "Instances", obj_Rory_Nyte);
            text_to_show = "* The Roaring Knight appears.";
            enemyName = "Roaring Knight";
            enemyHealth = 40000;
			enemyDefense = 300;
			expgiven = 10000;
			goldGiven = 9999;
            break;
        case "Mogus":
            song_instance = audio_play_sound(songbattle, 1, true);
			theEnemy = instance_create_layer(px, py, "Instances", obj_mogus);
            text_to_show = "* Something feels sus!";
            enemyName = "The Impostor";
            enemyHealth = 50;
			enemyDefense = -3;
			expgiven = 8;
			goldGiven = 12;
			global.enemydmg = 5
            break;
        case "Goku":
			songbattle = mus_ultrainstinct
            song_instance = audio_play_sound(songbattle, 1, true);
			theEnemy = instance_create_layer(px, py-20, "Instances", obj_goku);
            text_to_show = "* WHAT THE FUCK";
            enemyName = "Goku";
            enemyHealth = 999999999999;
			enemyDefense = 1000;
			expgiven = 0;
			goldGiven = 0;
			bulletcooldown = 0;
			bulletcooldownOG = bulletcooldown;
			global.enemydmg = 100
            break;
        case "Sans":
			songbattle = mus_megalovania
            song_instance = audio_play_sound(songbattle, 1, true);
			theEnemy = instance_create_layer(px, py-20, "Instances", obj_sans);
            text_to_show = "* You feel your crawling sinsing \n  in your back";
            enemyName = "Sans";
            enemyHealth = 100;
			enemyDefense = 1;
			expgiven = 600;
			goldGiven = 600;
			bulletcooldown = 45;
			bulletcooldownOG = bulletcooldown;
			global.enemydmg = 1
            break;
		default:
		    song_instance = audio_play_sound(songbattle, 1, true);
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
zooming = false;
zoom_current = 1;
zoom_target = 1;
zoom_speed = 0.05;
zoom_target = 0.75;      // 0.75 = 75% del tamaño -> zoom in suave
zoom_speed = 0.02;
zooming = false;
zoom_current = 1.0;
zoom_sprite_id = noone;  // guardaremos la instancia del sprite central aquí

global.ps = part_system_create_layer("Particles", false);


function generate_item_text() {
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {

            var page = other.current_item_page;
            var per_page = other.max_items_per_page;

            var start = page * per_page;
            var endo = min(start + per_page, array_length(global.objects));

            var _txt = "";

            for (var i = start; i < endo; i++) {

                var index_in_page = i - start;
                var row = index_in_page mod 3;
                var column = index_in_page div 3;

                if (column == 0)
                    _txt += "  * " + string(global.objects[i]);
                else
                    _txt += "         * " + string(global.objects[i]);

                if (column == 1 || i == endo - 1)
                    _txt += "\n";
            }

            text = _txt;
            display_text = "";
            text_index = 0;
        }
    }
}

/// get_item_page_text(page) -> string
function get_item_page_text(_page) {
    var per_page = max_items_per_page; // 6
    var start = _page * per_page;
    var total = array_length(global.objects);
    var endo = min(start + per_page, total);

    var rows = 3;
    // Inicializar líneas
    var lines = [];
    for (var r = 0; r < rows; r++) {
        array_push(lines, "");
    }

    // Para cada elemento de la página, calcular fila y columna (row-major)
    for (var i = start; i < endo; i++) {
        var index_in_page = i - start;         // 0..(per_page-1)
        var row = index_in_page div 2;        // 0..2 (cada 2 items avanzamos fila)
        var col = index_in_page mod 2;        // 0 = izquierda, 1 = derecha

        var item_name = string(global.objects[i]);

        if (col == 0) {
            // columna izquierda
            lines[row] += "  * " + item_name;
        } else {
            // columna derecha: ponemos un espaciado fijo antes
            // ajusta el número de espacios (aquí 10) si necesitas más separación
            lines[row] += "          " + "  * " + item_name;
        }
    }

    // Concatenar sólo las líneas que tengan contenido
    var out = "";
    for (var r = 0; r < rows; r++) {
        if (string_length(lines[r]) > 0) {
            out += lines[r] + "\n";
        }
    }

    return out;
}
