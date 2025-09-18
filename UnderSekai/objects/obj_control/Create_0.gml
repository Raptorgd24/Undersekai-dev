// --------------------- CREATE ---------------------
global.dialogue_active = false;   // ¿Hay diálogo abierto?
global.dialogue_text = "";
global.dialogue_index = 0;        // Para mostrar letra a letra
global.dialogue_timer = 0;
global.dialogue_speed = 4;        // Velocidad de escritura
global.dialogue_face = -1;
global.dialogue_sprite = spr_noone;
global.dialogue_font = ft_determinationmono;
global.dialogue_sound = snd_txt1;
global.dialogue_keep = false;
global.dialogue_character = "";

// Sistema de diálogos con arrays
global.dialogue_personajes = [];
global.dialogue_caras = [];
global.dialogue_mensajes = [];
global.dialogue_seguir = [];
global.dialogue_current = 0;      // Índice del diálogo actual
