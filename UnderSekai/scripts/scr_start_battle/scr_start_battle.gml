function scr_start_battle(le_enemy, _enemy_id="") {
	if (!layer_exists("Instances")) {
    layer_create(0, "Instances");
}
if (!layer_exists("Instances_1")) {
    layer_create(0, "Instances_1");
}
    /// @desc Inicia la secuencia de entrada a batalla
	 if (instance_exists(obj_player)) {
        obj_player.can_move = false;
        
        // ✅ Guardar posición y room del jugador para volver tras la batalla
        global.player_return_x    = obj_player.x;
        global.player_return_y    = obj_player.y;
        global.player_return_room = room;
    }
	
    if (instance_exists(obj_usable)) obj_usable.can_use = false;
    audio_play_sound(snd_encounter, 1, false);
    
    // Guardar enemigo global
    global.enemy = le_enemy;
    global.enemy_id = _enemy_id;
    
    // Crear el controlador de la transición
    instance_create_layer(0, 0, "Instances", obj_battle_start_controller);
}