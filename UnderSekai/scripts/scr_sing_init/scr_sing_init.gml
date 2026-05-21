function scr_sing_init(_battle_id) {

	if (instance_exists(obj_sing_manager)) {
		with (obj_sing_manager) {
			if (ds_exists(notes, ds_type_list)) ds_list_destroy(notes);
			instance_destroy();
		}
	}

	if (instance_exists(obj_sing_ui)) {
		with (obj_sing_ui) instance_destroy();
	}

	if (!instance_exists(_battle_id)) {
		show_debug_message("sing init fallo, battle_id no existe");
		return noone;
	}

	var _song_inst = -1;
	if (variable_instance_exists(_battle_id, "song_instance")) {
		_song_inst = _battle_id.song_instance;
	}

	var sing_mgr = instance_create_layer(0, 0, "Instances", obj_sing_manager);
	if (!instance_exists(sing_mgr)) {
		show_debug_message("sing manager no quiso nacer");
		return noone;
	}

	sing_mgr.battle_id = _battle_id;
	sing_mgr.song_instance = _song_inst;

	var _songbattle = noone;
	if (variable_instance_exists(_battle_id, "songbattle")) {
		_songbattle = _battle_id.songbattle;
	}

	if (_songbattle != noone && audio_exists(_songbattle)) {
		var _len = audio_sound_length(_songbattle);
		sing_mgr.song_duration = (_len > 0) ? (_len * 1000) : 30000;
	} else {
		sing_mgr.song_duration = 30000;
	}

	sing_mgr.song_position = 0;
	sing_mgr.chart_active = false;

	instance_create_layer(0, 0, "Instances", obj_sing_ui);

	show_debug_message("sing listo, song=" + string(_song_inst));
	return sing_mgr;
}
