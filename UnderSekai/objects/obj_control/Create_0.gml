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
global.debug = false;
// Sistema de eventos (timeline por frames)
global.event_datalol = undefined;
global.event_time = 0;
global.event_step = 0;

// --- Transición ---
global.trans_active = false;
global.trans_alpha = 0;
global.trans_state = 0;    // 0 = fundido a negro, 1 = cambiar room, 2 = fundido de regreso
global.trans_target = Room666;
trans_speed = 0.05; // velocidad configurable

global.song = mus_sans;
global.song_volume=1;
global.song_next=noone;
global.song_speed=trans_speed;
global.song_target=1;
audio_play_sound(global.song, 1, true);