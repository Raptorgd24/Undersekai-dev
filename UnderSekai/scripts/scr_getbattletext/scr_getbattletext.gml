// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_getbattletext(_i, _hit_count = 0){

show_debug_message(_i)
show_debug_message(_hit_count)
switch (global.enemy) {

    case "Sans":
        if (_hit_count == 0) {
            switch (_i) {
                case 0:
                    return {
                        face : 0,
                        voice: snd_sans,
                        text : "heya.\nyou've been busy, huh?",
                        cont : true
                    };
                case 1:
                    return {
                        face : 12,
                        voice: snd_sans,
                        text : "let's get this over\nwith.",
                        cont : false
                    };
            }
        } else if (_hit_count == 1) {
            switch (_i) {
                case 0:
                    return {
                        face : 0,
                        voice: snd_sans,
                        text : "not bad.\nbut can you keep up?",
                        cont : true
                    };
                case 1:
                    return {
                        face : 12,
                        voice: snd_sans,
                        text : "let's see if you survive this.",
                        cont : false
                    };
            }
        } else {
            // No more dialogue, go to battle
            return {
                face : 0,
                voice: snd_sans,
                text : "",
                cont : false
            };
        }
        break;

case "Mogus":
    switch (_i) {

        case 0: // SABOTAGE
            return {
                face : 0,
                voice: snd_txt2,
                text : "H-Huh!?.",
                cont : false
            };

        case 1: // TASK
            return {
                face : 0,
                voice: snd_txt2,
                text : "Oh thanks bro.",
                cont : false
            };
    }
    break;
}

// fallback
return {
    face : 0,
    voice: snd_txt2,
    text : "",
    cont : false
};
}