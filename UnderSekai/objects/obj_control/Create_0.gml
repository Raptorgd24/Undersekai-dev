// --------------------- CREATE ---------------------
global.dialogue_active = false;   // ¿Hay diálogo abierto?
global.dialogue_text = "";
global.dialogue_index = 0;        // Para mostrar letra a letra
global.dialogue_cooldown = 0;       
global.dialogue_timer = 0;
global.dialogue_speed = 4;        // Velocidad de escritura
global.dialogue_face = -1;
global.dialogue_sprite = spr_noone;
global.dialogue_font = ft_determinationmono;
global.dialogue_sound = snd_txt1;
global.dialogue_keep = false;
global.dialogue_character = "noone";

// Sistema de diálogos con arrays
global.dialogue_personajes = [];
global.dialogue_caras = [];
global.dialogue_mensajes = [];
global.dialogue_seguir = [];
global.dialogue_current = 0;      // Índice del diálogo actual
global.coroutines = [];
global.debug = true;
// Sistema de eventos (timeline por frames)
global.event_datalol = undefined;
global.event_time = 0;
global.event_step = 0;

// --- Transición ---
global.trans_active = false;
global.trans_alpha = 0;
global.trans_state = 0;    // 0 = fundido a negro, 1 = cambiar room, 2 = fundido de regreso
global.trans_target = Room666;
global.trans_speed = 0.05; // velocidad configurable


// --- Música: separar asset / instancia y usar fade por frames ---
musi_speed = 60; // (no lo usamos para lerp directamente; lo dejamos si lo usas en otro sitio)

// recurso (asset) actual y la instancia reproducida
global.song_asset = mus_sans;            // asset (ej: mus_sans)
global.song_inst  = noone;               // instancia (lo seteará audio_play_sound)
global.song_volume = 1;                  // volumen actual (0..1)
global.song_target = 1;                  // objetivo (0 o 1)
global.song_next  = noone;               // asset en cola
global.song_fade_frames = 60;            // duración del fade en frames (por defecto 60 -> 1s si 60fps)
global.song_fade_delta  = 1 / max(1, global.song_fade_frames); // cambio por frame

// iniciar la canción inicial de forma segura
if (!is_undefined(global.song_asset)) {
    var _asset = global.song_asset;
    if (is_string(_asset)) _asset = asset_get_index(_asset);
    if (_asset != -1) {
        global.song_asset = _asset;
        global.song_inst = audio_play_sound(global.song_asset, 1, true);
        audio_sound_gain(global.song_inst, global.song_volume, 0);
    } else {
        show_debug_message("⚠️ CREATE: no se pudo iniciar música, asset inválido: " + string(global.song_asset));
        global.song_inst = noone;
    }
}


// Arrays de habitaciones por zona
global.zone_TestRooms    = [Room1, RoomTest];
global.zone_MysteryRooms = [Room666];
global.zone_Silence = [StartingPointBeta];

// Canciones por zona → usar ds_map para índices tipo string
global.zone_music = ds_map_create();
ds_map_add(global.zone_music, "TestRooms", mus_sans);
ds_map_add(global.zone_music, "MysteryRooms", mus_666);
ds_map_add(global.zone_music, "Silence", mus_silence);

// Zona actual
global.current_zone = "TestRooms";


global.event_npc = noone;