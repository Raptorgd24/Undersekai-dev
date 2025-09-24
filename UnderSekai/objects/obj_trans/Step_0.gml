// STEP - trigger eventos solo una vez mientras el jugador esté sobre el trigger
if (randomassbool == true) {
    if (place_meeting(x, y, obj_player)) {
		scr_trans(WhereTo); // fundido normal con velocidad por defecto
		
        randomassbool = false;
		
    }
}
