function scr_screenshake(_time = 20, _magn = 3, _vel = 1.4)
{
		if (!layer_exists("Instances")) {
    layer_create(0, "Instances");
}
if (!layer_exists("Instances_1")) {
    layer_create(0, "Instances_1");
}
    var _layerName = "Shake";
    var _layerId = layer_get_id(_layerName);

    if (_layerId == -1) {
        _layerId = layer_create(-1000, _layerName);
    }

    layer_set_visible(_layerId, true);

    var _fx = layer_get_fx(_layerId);

    if (_fx < 0) {
        _fx = fx_create("_filter_screenshake");
        layer_set_fx(_layerId, _fx);
    }

    fx_set_parameter(_fx, "g_Magnitude", _magn);
    fx_set_parameter(_fx, "g_Speed", _vel);

    if (instance_exists(obj_control)) {
        with (obj_control) {
            shake_timer = _time;
            shake_layer = _layerId;
        }
    }
    else if (instance_exists(obj_battle_menu)) {
        with (obj_battle_menu) {
            shake_timer = _time;
            shake_layer = _layerId;
        }
    }
}
