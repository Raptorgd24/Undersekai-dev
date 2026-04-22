// Estado inicial
state = "idle";
menu_index = 0;
menu_visible = false;
saved_state = false;
cooldown_timer = 0;
global.room_name = room_get_name(room)
// Tamaño y posición del menú
box_w = 420;
box_h = 160;
bx = 120;
by = 40;
gui_padding = 18;

switch (room) {
    case rm_Room666:
        dialogue_text = "You feel like you shouldn't be here.";
        room_name_text = "???";
        break;

    case rm_Room1:
        dialogue_text = "You feel a warm presence...";
        room_name_text = "Ruins - Entrance";
        break;

    case rm_ruins3:
        dialogue_text = "You lay in the dry leaves,\nit fills you with determination.";
        room_name_text = "Ruins - Entrance";
        break;

    case rm_StartingPointBeta:
        dialogue_text = "The flowers even if they \naren't blooming, they feel peaceful.";
        room_name_text = "Hole in the ceiling";
        break;

    default:
        dialogue_text = "You found a save point.";
        room_name_text = "Unknown Area";
        break;
}


// Leer datos de save.dat si existe
if (file_exists("save.dat")) {
    var file = file_text_open_read("save.dat");
    save_room = file_text_read_string(file); file_text_readln(file);
    save_name = file_text_read_string(file); file_text_readln(file);
    save_lv = real(file_text_read_string(file)); file_text_readln(file);
    save_hp = real(file_text_read_string(file)); file_text_readln(file);
    save_maxhp = real(file_text_read_string(file)); file_text_readln(file);
    save_gold = real(file_text_read_string(file)); file_text_readln(file);
    save_objects = file_text_read_string(file); file_text_readln(file);
    save_weapon = file_text_read_string(file); file_text_readln(file);
    save_armor = file_text_read_string(file); file_text_readln(file);
    save_time = real(file_text_read_string(file)); file_text_readln(file);
    save_zone = file_text_read_string(file); file_text_readln(file);
    file_text_close(file);
} else {
    // Inicializar con global solo si no hay archivo
    save_name = global.name;
    save_lv   = global.lv;
    save_hp   = global.healthu;
    save_maxhp   = global.maxHP;
    save_gold = global.gold;
    save_objects = global.objects;
    save_weapon  = global.weapon;
    save_armor   = global.armor;
    save_time    = global.play_time;
    save_zone    = global.room_name;
}

// Variables GUI iniciales, copiadas del archivo, NO del global
save_name_gui    = save_name;
save_lv_gui      = save_lv;
save_hp_gui      = save_hp;
save_gold_gui    = save_gold;
save_objects_gui = save_objects;
save_weapon_gui  = save_weapon;
save_armor_gui   = save_armor;
save_time_gui    = save_time;
save_zone_gui    = save_zone;
