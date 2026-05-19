function scr_save_game(){
/// scr_save_game()
var file = file_text_open_write("save.dat");

//
file_text_write_string(file, global.room_name); file_text_writeln(file);
file_text_write_string(file, global.name); file_text_writeln(file);
file_text_write_string(file, string(global.lv)); file_text_writeln(file);
file_text_write_string(file, string(global.healthu)); file_text_writeln(file);
file_text_write_string(file, string(global.maxHP)); file_text_writeln(file);
file_text_write_string(file, string(global.gold)); file_text_writeln(file);
file_text_write_string(file, global.objects); file_text_writeln(file);
file_text_write_string(file, global.weapon); file_text_writeln(file);
file_text_write_string(file, global.armor); file_text_writeln(file);
file_text_write_string(file, floor(string(global.play_time))); file_text_writeln(file);
//
file_text_write_string(file, string(global.events_done)); file_text_writeln(file);

file_text_write_string(file, string(global.xp)); file_text_writeln(file);
file_text_write_string(file, string(global.fame)); file_text_writeln(file);
file_text_write_string(file, string(global.route)); file_text_writeln(file);
file_text_write_string(file, string(global.kills)); file_text_writeln(file);
file_text_write_string(file, string(global.spares)); file_text_writeln(file);
file_text_write_string(file, string(global.deaths)); file_text_writeln(file);

if (variable_global_exists("event_data_map") && ds_exists(global.event_data_map, ds_type_map)) {
    var map_str = ds_map_write(global.event_data_map);
    file_text_write_string(file, map_str); file_text_writeln(file);
} else {
    file_text_write_string(file, ""); file_text_writeln(file);
}

file_text_close(file);

show_debug_message("Guardado: " + room_get_name(room));


}