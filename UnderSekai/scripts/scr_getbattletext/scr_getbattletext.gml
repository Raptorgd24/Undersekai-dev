// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_getbattletext(_i){
switch (global.enemy) {

    case "Sans":
        switch (_i) {
            case 0:
                return {
                    face : 0,
                    voice: snd_sans,
                    text : "* heya.\n* you've been busy, huh?",
                    cont : true
                };
            case 1:
                return {
                    face : 12,
                    voice: snd_sans,
                    text : "* let's get this over with.",
                    cont : false
                };
        }
        break;

    case "Mogus":
        switch (_i) {
            case 0:
                return {
                    face : 0,
                    voice: snd_txt2,
                    text : "* Something feels...\n* very sus.",
                    cont : false
                };
        }
        break;
}

// fallback
return {
    face : 0,
    voice: snd_txt2,
    text : "* ...",
    cont : false
};
}