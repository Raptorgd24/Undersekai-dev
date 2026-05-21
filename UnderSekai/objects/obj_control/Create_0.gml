image_alpha = 0;
// --------------------- CREATE ---------------------

global.dialogue_manager = {
    active: false,
    current_dialogue: undefined,
    current_index: 0,
    text_index: 0,
    timer: 0,
    speed: 1,
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

global.event_manager = {
    active: false,
    current_event: undefined,
    step: 0,
    time: -1,
    waiting_for_dialogue: false,
    waiting_for_walk: false,
    waiting_for_boom: false,
    npc: noone,
    boom_frames: 0
};

// Variables globales para intro
global.intro_state = "idle";
global.intro_current_text = 0;
global.intro_texts = [];
global.intro_char_index = 0;
global.intro_display_text = "";
global.sprite_sequence = [];
global.current_sprite_index = 0;

// Variables globales para menús
global.sel_left = noone;
global.sel_mid = noone;
global.sel_right = noone;

// Variables globales para leveling
global.currentlevel = 1;
global.levelup = 0;

// Variables legacy (por compatibilidad)
global.dialogue_active = false;   
global.dialogue_text = "";
global.dialogue_index = 0;      
global.dialogue_cooldown = 0;       
global.dialogue_timer = 0;
global.dialogue_speed = 4;     
global.dialogue_face = -1;
global.dialogue_sprite = spr_noone;
global.dialogue_active = false;   
global.dialogue_text = "";
global.dialogue_index = 0;      
global.dialogue_cooldown = 0;       
global.dialogue_timer = 0;
global.dialogue_speed = 4;     
global.dialogue_face = -1;
global.dialogue_sprite = spr_noone;
global.dialogue_font = ft_determinationmono;
global.dialogue_sound = snd_txt1;
global.dialogue_keep = false;
global.dialogue_character = "noone";
global.playing = false;
global.dialogue_personajes = [];
global.dialogue_caras = [];
global.dialogue_mensajes = [];
global.dialogue_seguir = [];
global.liberar_move = [];
global.dialogue_current = 0;      
global.coroutines = [];
global.debug = false;

global.event_datalol = undefined;
global.event_time = 0;
global.event_step = 0;

global.trans_active = false;
global.trans_alpha = 0;
global.trans_state = 0;   
global.trans_target = rm_Room666;
global.trans_speed = 0.05; 


musi_speed = 60;

global.song_inst  = noone;               
global.song_volume = 1;                  
global.song_target = 1;                  
global.song_next  = noone;              
global.song_fade_frames = 60;            
global.song_fade_delta  = 1 / max(1, global.song_fade_frames); 

if (!is_undefined(global.song_asset)) {
    var _asset = global.song_asset;
    if (is_string(_asset)) _asset = asset_get_index(_asset);
    if (_asset != -1) {
        global.song_asset = _asset;
        global.song_inst = audio_play_sound(global.song_asset, 1, true);
        audio_sound_gain(global.song_inst, global.song_volume, 0);
    } else {
        show_debug_message("obj control CREATE: no se pudo iniciar música, asset inválido: " + string(global.song_asset));
        global.song_inst = noone;
    }
}


global.zone_TestRooms    = [rm_Room1, rm_RoomTest, rm_ruins2, rm_ruins3, rm_ruins4, rm_ruins5];
global.zone_MysteryRooms = [rm_Room666];
global.zone_Silence = [rm_StartingPointBeta, rm_ruins1];

// Canciones por zona → usar ds_map para índices tipo string
global.zone_music = ds_map_create();
ds_map_add(global.zone_music, "TestRooms", mus_ruins);
ds_map_add(global.zone_music, "MysteryRooms", mus_666);
ds_map_add(global.zone_music, "Silence", mus_silence);

// Zona actual
global.current_zone = "";


global.event_npc = noone;


// Sistema de eventos (timeline por frames)
global.event_datalol = undefined;
global.event_time = 0;
global.event_step = 0;

// --- Nuevas variables para esperas ---
global.waiting_for_walk = false;
global.waiting_for_boom = false;
global.boom_wait_frames = 0;

// AÑADIR al final del obj_control:CREATE (o pegar en Create si quieres reemplazar)
// Inicialización adicional y comprobación de save.dat
if (!variable_global_exists("play_time")) global.play_time = 0;
if (!variable_global_exists("fame")) global.fame = 0;
if (!variable_global_exists("route")) global.route = "neutral";
if (!variable_global_exists("kills")) global.kills = 0;
if (!variable_global_exists("spares")) global.spares = 0;
if (!variable_global_exists("deaths")) global.deaths = 0;
if (!variable_global_exists("room_name") || global.room_name == "") {
    if (function_exists(asset_get_name)) global.room_name = asset_get_name(room);
    else global.room_name = "rm_Room1";
}

if (file_exists("save.dat")) {
    global.has_save = true;
    show_debug_message("obj_control: save.dat detectado ✅ -> Continue disponible");
} else {
    global.has_save = false;
    show_debug_message("obj_control: No se encontró save.dat ❌ -> Solo START disponible");
}

shake_timer = 20;
shake_layer = -1;

_x=0;
_y=0;