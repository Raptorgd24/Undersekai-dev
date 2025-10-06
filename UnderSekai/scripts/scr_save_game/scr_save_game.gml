// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_save_game(){

var file = file_text_open_write("save.dat");

file_text_write_string(file, string(global.room_name)); file_text_writeln(file);
file_text_write_string(file, global.name); file_text_writeln(file);
file_text_write_string(file, string(global.lv)); file_text_writeln(file);
file_text_write_string(file, string(global.health)); file_text_writeln(file);
file_text_write_string(file, string(global.gold)); file_text_writeln(file);
file_text_write_string(file, global.objects); file_text_writeln(file);
file_text_write_string(file, global.weapon); file_text_writeln(file);
file_text_write_string(file, global.armor); file_text_writeln(file);

file_text_close(file);
show_debug_message("Archivo save.dat guardado correctamente");

}