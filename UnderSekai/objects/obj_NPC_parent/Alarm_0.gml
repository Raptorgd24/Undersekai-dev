/* Crear explosión en la posición del NPC -20,-20
var boom = instance_create_layer(x - 20, y - 20, "Instances_1", obj_boom_temp);

// Guardar referencia de este NPC en el boom
if (variable_instance_exists(boom, "parent_npc")) {
    boom.parent_npc = id;
}

// Reproducir sonidos
audio_play_sound(snd_sansing, 1, false);
audio_play_sound(snd_boom, 1, false);

// Diálogo final
scr_dialogue("noone", 8, "What the fuck.", false);

// Liberar al jugador
if (instance_exists(obj_player)) {
    obj_player.can_move = true;
}
if (instance_exists(obj_usable)) {
    obj_usable.can_use = true;
}