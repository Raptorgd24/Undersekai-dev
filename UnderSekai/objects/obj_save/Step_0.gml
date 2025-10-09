if (!instance_exists(obj_player)) exit;
    if (obj_player.y < y) {
        depth = obj_player.depth - 1;
    } else {
        depth = obj_player.depth + 1;
    }
// Variables persistentes
if (!variable_instance_exists(id, "cooldown_timer")) cooldown_timer = 0;
if (!variable_instance_exists(id, "saved_state")) saved_state = false;

// Reducir cooldown
if (cooldown_timer > 0) cooldown_timer -= 1;

// Interacción inicial — abrir diálogo
if (!menu_visible && !global.dialogue_active && cooldown_timer <= 0) {
    if ((keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) &&
        instance_exists(obj_usable) && obj_usable.can_use) {
        if (place_meeting(x, y, obj_usable)) {
            scr_dialogue("noone", 0, dialogue_text, false, false);
            state = "dialogue";
        }
    }
}

// Esperar a que termine el diálogo y timer de seguridad
if (state == "dialogue" && !global.dialogue_active &&
    (!variable_global_exists("dialogue_use_timer") || global.dialogue_use_timer <= 0)) {
    state = "open_menu_wait";
    cooldown_timer = 1; // abrir menú casi inmediatamente
}

// Abrir menú tras cooldown rápido
if (state == "open_menu_wait" && cooldown_timer <= 0) {
    menu_visible = true;
    state = "menu";
    menu_index = 0;
    saved_state = false;
    if (instance_exists(obj_player)) obj_player.can_move = false;
    if (instance_exists(obj_usable)) obj_usable.can_use = false;
}

// Menú activo
if (state == "menu" && menu_visible) {

    // Si ya se guardó, permitir salir con Z
    if (saved_state && (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter))) {
        menu_visible = false;
        state = "idle";
        saved_state = false;
        if (instance_exists(obj_player)) obj_player.can_move = true;
        if (instance_exists(obj_usable)) obj_usable.can_use = true;
        exit;
    }

    // Navegación y confirmación
    if (!saved_state) {
        var moved = false;

        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
            menu_index = max(0, menu_index - 1);
            moved = true;
        }
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
            menu_index = min(1, menu_index + 1);
            moved = true;
        }

        if (moved && asset_get_index("snd_menumove") >= 0)
            audio_play_sound(snd_menumove, 1, false);

        // Confirmar selección
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            if (asset_get_index("snd_select") >= 0)
                audio_play_sound(snd_select, 1, false);

            // Opción SAVE → actualizar desde global y guardar
            if (menu_index == 0) {
                save_name    = global.name;
                save_lv      = global.lv;
                save_hp      = global.health;
                save_maxhp   = global.maxHP;
                save_gold    = global.gold;
                save_objects = global.objects;
                save_weapon  = global.weapon;
                save_armor   = global.armor;
                save_time    = global.play_time;
                save_zone    = global.room_name;

                // Actualizar variables de GUI
                save_name_gui    = save_name;
                save_lv_gui      = save_lv;
                save_hp_gui      = save_hp;
                save_maxhp_gui   = save_maxhp;
                save_gold_gui    = save_gold;
                save_objects_gui = save_objects;
                save_weapon_gui  = save_weapon;
                save_armor_gui   = save_armor;
                save_time_gui    = save_time;
                save_zone_gui    = save_zone;

                // Guardar en archivo
                scr_save_game();

                global.health = global.maxHP; // regenerar HP

                saved_state = true;
                cooldown_timer = 2; // post-save rápido
            }

            // Opción RETURN → cerrar menú sin guardar
            else {
                menu_visible = false;
                state = "idle";
                if (instance_exists(obj_player)) obj_player.can_move = true;
                if (instance_exists(obj_usable)) obj_usable.can_use = true;
            }
        }
    }
}
