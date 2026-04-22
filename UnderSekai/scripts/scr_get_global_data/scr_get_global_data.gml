function scr_get_global_data(_key, _default = undefined) {
    if (!variable_global_exists("event_data_map") || !ds_exists(global.event_data_map, ds_type_map)) {
        return _default;
    }

    if (!ds_map_exists(global.event_data_map, _key)) {
        return _default;
    }

    return ds_map_find_value(global.event_data_map, _key);
}
