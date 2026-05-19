// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_hurt(_damage=1,_cd=2){
/// @description Aplica daño al corazón global con cooldown
/// @param damage        Daño base a aplicar
/// @param cooldown_sec  Duración del cooldown en segundos



// Inicializar cooldown si no existe
if (!variable_global_exists("atkcooldown")) global.atkcooldown = false;
if (!variable_global_exists("cooldowntimer")) global.cooldowntimer = 0;

// Solo aplicar daño si no hay cooldown
if (!global.atkcooldown){
    global.healthu -= max(1, _damage - global.DEF);
    global.atkcooldown = true;
    global.cooldowntimer = room_speed * _cd; // convertir segundos a 
	audio_play_sound(snd_hurt,1,false)

}

// Reducir cooldown cada step/
/*
if (global.atkcooldown){
    global.cooldowntimer -= 1;
    if (global.cooldowntimer <= 0){
        global.atkcooldown = false;
    }
}
*/
}