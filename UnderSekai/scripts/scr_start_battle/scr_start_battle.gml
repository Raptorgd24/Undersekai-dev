function scr_start_battle(le_enemy) {
    /// @desc Inicia la secuencia de entrada a batalla
    audio_play_sound(snd_encounter, 1, false);
    
    // Guardar enemigo global
    global.enemy = le_enemy;
    
    // Crear el controlador de la transición
    instance_create_layer(0, 0, "Instances", obj_battle_start_controller);
}