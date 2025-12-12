function scr_save_game(){
/// scr_save_game()
var file = file_text_open_write("save.dat");

// Guardar el nombre de la room actual (como string)
file_text_write_string(file, global.room_name); file_text_writeln(file);
file_text_write_string(file, global.name); file_text_writeln(file);
file_text_write_string(file, string(global.lv)); file_text_writeln(file);
file_text_write_string(file, string(global.healthu)); file_text_writeln(file);
file_text_write_string(file, string(global.maxHP)); file_text_writeln(file);
file_text_write_string(file, string(global.gold)); file_text_writeln(file);
file_text_write_string(file, global.objects); file_text_writeln(file);
file_text_write_string(file, global.weapon); file_text_writeln(file);
file_text_write_string(file, global.armor); file_text_writeln(file);
file_text_write_string(file, string(global.play_time)); file_text_writeln(file);
//test icle
file_text_write_string(file, string(global.events_done)); file_text_writeln(file);

file_text_write_string(file, string(global.xp)); file_text_writeln(file);

file_text_close(file);

show_debug_message("Guardado: " + room_get_name(room));


}