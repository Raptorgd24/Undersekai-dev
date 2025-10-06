// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_load_game(){
if (!file_exists("save.dat")) {
    show_debug_message("No se puede cargar: save.dat no existe");
    exit;
}

var file = file_text_open_read("save.dat");

global.room_name = file_text_read_string(file); file_text_readln(file);
global.name = file_text_read_string(file); file_text_readln(file);
global.lv = real(file_text_read_string(file)); file_text_readln(file);
global.health = real(file_text_read_string(file)); file_text_readln(file);
global.gold = real(file_text_read_string(file)); file_text_readln(file);
global.objects = file_text_read_string(file); file_text_readln(file);
global.weapon = file_text_read_string(file); file_text_readln(file);
global.armor = file_text_read_string(file); file_text_readln(file);

file_text_close(file);
show_debug_message("Archivo save.dat cargado correctamente");

}