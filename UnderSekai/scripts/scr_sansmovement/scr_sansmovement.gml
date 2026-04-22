// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_sansmovement(_aja){
with (obj_sans){
can_move = _aja;
with (torso){
	can_move = _aja;
}
with (legs){
	can_move = _aja;
}
}
}