function scr_set_global_data(_key, _value) {
    if (!variable_global_exists("event_data_map") || !ds_exists(global.event_data_map, ds_type_map)) {
        global.event_data_map = ds_map_create();
    }

    ds_map_replace(global.event_data_map, _key, _value);
    return _value;
}
