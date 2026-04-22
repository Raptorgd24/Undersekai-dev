// scr_dialogue_manager.gml
// Sistema mejorado de diálogos con soporte para ramas y rutas

// Estructura global para el manager de diálogos
global.dialogue_manager = {
    active: false,
    current_dialogue: undefined,
    current_index: 0,
    text_index: 0,
    timer: 0,
    text_speed: 210,
    queue: [],
    on_complete: undefined,
    choices: [],
    selected_choice: -1,
    waiting_for_choice: false,
    font: -1,
    sound: -1,
    sprite: noone,
    face_index: 0,
    character: "",
    keep_box: false,
    release_move: true
};

// Función para iniciar un diálogo estructurado
function dialogue_start(_dialogue_struct, _on_complete = undefined) {
    if (global.dialogue_manager.active) return false;
    
    global.dialogue_manager.current_dialogue = _dialogue_struct;
    global.dialogue_manager.current_index = 0;
    global.dialogue_manager.on_complete = _on_complete;
    global.dialogue_manager.active = true;
    global.dialogue_manager.waiting_for_choice = false;
    global.dialogue_manager.selected_choice = -1;
    
    // Bloquear jugador
    if (instance_exists(obj_player)) obj_player.can_move = false;
    if (instance_exists(obj_usable)) obj_usable.can_use = false;
    
    dialogue_next();
    return true;
}

// Avanzar al siguiente mensaje
function dialogue_next() {
    if (!global.dialogue_manager.active) return;
    
    var mgr = global.dialogue_manager;
    var dialogue = mgr.current_dialogue;
    if (!is_struct(dialogue)) return;
    
    var messages = variable_struct_get(dialogue, "messages");
    if (mgr.current_index >= array_length(messages)) {
        dialogue_end();
        return;
    }
    
    var msg = messages[mgr.current_index];
    
    // Configurar display
    mgr.text_index = 0;
    mgr.timer = 0;
    mgr.keep_box = variable_struct_get(msg, "keep_box") ?? false;
    mgr.release_move = variable_struct_get(dialogue, "release_move") ?? true;
    mgr.character = variable_struct_get(msg, "character") ?? "";
    
    // Sprite de cara
    var face_name = "spr_" + mgr.character;
    var spr_id = asset_get_index(face_name);
    mgr.sprite = (spr_id != -1) ? spr_id : noone;
    mgr.face_index = variable_struct_get(msg, "face_index") ?? 0;
    
    // Fuente
    var font_name = "ft_" + mgr.character;
    var font_id = asset_get_index(font_name);
    mgr.font = (font_id != -1) ? font_id : asset_get_index("ft_determinationmono");
    
    // Sonido
    var sound_name = "snd_" + mgr.character;
    var sound_id = asset_get_index(sound_name);
    mgr.sound = (sound_id != -1) ? sound_id : asset_get_index("snd_txt1");
    
    // Si hay opciones, esperar selección
    if (variable_struct_exists(msg, "choices") && array_length(variable_struct_get(msg, "choices")) > 0) {
        mgr.choices = variable_struct_get(msg, "choices");
        mgr.waiting_for_choice = true;
        mgr.selected_choice = 0; // Default first
    } else {
        mgr.choices = [];
        mgr.waiting_for_choice = false;
    }
    
    mgr.current_index++;
}

// Terminar diálogo
function dialogue_end() {
    var mgr = global.dialogue_manager;
    mgr.active = false;
    
    // Liberar movimiento si corresponde
    if (mgr.release_move) {
        if (instance_exists(obj_player)) obj_player.can_move = true;
        if (instance_exists(obj_usable)) obj_usable.can_use = false;
    }
    
    // Timer de seguridad
    global.dialogue_use_timer = 5;
    
    // Limpiar
    mgr.current_dialogue = undefined;
    mgr.current_index = 0;
    mgr.text_index = 0;
    mgr.choices = [];
    mgr.waiting_for_choice = false;
    
    // Callback si existe
    if (mgr.on_complete != undefined) {
        mgr.on_complete();
    }
}

// Seleccionar opción
function dialogue_select_choice(_index) {
    var mgr = global.dialogue_manager;
    if (!mgr.waiting_for_choice || _index < 0 || _index >= array_length(mgr.choices)) return;
    
    var choice = mgr.choices[_index];
    mgr.selected_choice = _index;
    mgr.waiting_for_choice = false;
    
    // Ejecutar acción de la opción
    if (variable_struct_exists(choice, "action")) {
        choice.action();
    }
    
    // Si hay next_dialogue, iniciar nuevo diálogo
    if (variable_struct_exists(choice, "next_dialogue")) {
        dialogue_start(choice.next_dialogue);
    } else {
        dialogue_next();
    }
}

// Actualizar (llamar en Step)
function dialogue_update() {
    var mgr = global.dialogue_manager;
    if (!mgr.active) return;
    
    // Si esperando opción, no avanzar texto
    if (mgr.waiting_for_choice) return;
    
    var dialogue = mgr.current_dialogue;
    if (!is_struct(dialogue)) return;
    if (!variable_struct_exists(mgr, "text_speed")) mgr.text_speed = 4;
    var messages = variable_struct_get(dialogue, "messages");
    var msg = messages[mgr.current_index - 1];
    var full_text = variable_struct_get(msg, "text");
    
    // Avanzar letra por letra
    mgr.timer++;
    if (mgr.timer >= mgr.text_speed && mgr.text_index < string_length(full_text)) {
        mgr.text_index++;
        mgr.text_index++;
        mgr.timer = 0;
        // Reproducir sonido exactamente cuando aparece la letra
        if (mgr.sound != -1) {
            audio_play_sound(mgr.sound, 10, false);
        }
    }
}

// Dibujar (llamar en Draw GUI)
function dialogue_draw() {
    var mgr = global.dialogue_manager;
    if (!mgr.active) return;
    
    var dialogue = mgr.current_dialogue;
    if (!is_struct(dialogue)) return;
    var messages = variable_struct_get(dialogue, "messages");
    var msg = messages[mgr.current_index - 1];
    var visible_text = string_copy(variable_struct_get(msg, "text"), 1, mgr.text_index);
    
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var margin = 16;
    
    // Sprite caja
    var spr_idx = asset_get_index("spr_dialoguebox");
    var box_w = (spr_idx != -1) ? sprite_get_width(spr_idx) : (gui_w - margin*2);
    var box_h_default = 80;
    
    // Posición según cámara
    var use_legacy = true;
    if (instance_exists(obj_player)) {
        var cam = view_camera[0];
        if (!is_undefined(cam) && cam != -1) {
            var view_y = camera_get_view_y(cam);
            var view_h = camera_get_view_height(cam);
            var cam_mid_y = view_y + view_h/2;
            use_legacy = (obj_player.y < cam_mid_y);
        } else if (instance_exists(obj_cam)) {
            use_legacy = (obj_player.y < obj_cam.y);
        }
    }
    
    var base_x = 0;
    var base_y = use_legacy ? 105 : 105 - 300;
    var face_x = 54;
    var face_y = use_legacy ? 350 : 350 - 300;
    var text_x = mgr.sprite != noone ? 160 : 64;
    var text_y = use_legacy ? 340 : 340 - 300;
    
    // Ajuste para character "none": mover texto más atrás
    if (mgr.character == "none" || mgr.character == "noone" || mgr.character == "") {
        text_x -= 5; // Mover más a la derecha
    }
    
    // Dibujar caja
    if (spr_idx != -1) {
        draw_sprite(spr_idx, 0, base_x, base_y);
    } else {
        draw_set_alpha(0.9);
        draw_rectangle(base_x, base_y, base_x + box_w, base_y + box_h_default, false);
        draw_set_alpha(1);
    }
    
    // Dibujar cara
    if (mgr.sprite != noone) {
        draw_sprite_ext(mgr.sprite, mgr.face_index, face_x, face_y, 2.3, 2.3, 0, $FFFFFF, 1);
    }
    
    // Fuente
    if (mgr.font != -1) draw_set_font(mgr.font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    
    // Texto
    draw_text(text_x, text_y, visible_text);
    
    // Opciones con corazón (solo en la seleccionada)
    if (mgr.waiting_for_choice) {
        var heart_spr = asset_get_index("spr_heart"); // Sprite de corazón
        var choice_y = text_y + 20;
        for (var i = 0; i < array_length(mgr.choices); i++) {
            // Solo dibujar corazón para la opción seleccionada
            if (i == mgr.selected_choice) {
                if (heart_spr != -1) {
                    draw_sprite_ext(heart_spr, 0, text_x - 20, 4+choice_y + i * 20, 2, 2, 0, c_yellow, 1);
                }
                draw_set_color(c_yellow);
            } else {
                draw_set_color(c_white);
            }
            
            draw_text(text_x + 10, choice_y + i * 20, mgr.choices[i].text);
        }
        draw_set_color(c_white);
    }
    
    // No dibujar triángulo
}