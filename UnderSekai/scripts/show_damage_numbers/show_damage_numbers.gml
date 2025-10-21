/// @function show_damage_numbers(x, y, damage)
/// @desc Crea números flotantes que muestran el daño infligido.
/// @param x posición x base
/// @param y posición y base
/// @param damage número de daño a mostrar

function show_damage_numbers(_x, _y, _damage) {
    var dmg_str = string(abs(_damage)); // convertimos a string
    var num_digits = string_length(dmg_str);
    var spacing = 21; // separación entre dígitos
    var total_width = (num_digits - 1) * spacing;
    var start_x = _x - total_width * 0.5; // centrar el texto

    for (var i = 1; i <= num_digits; i++) {
        var char = real(string_char_at(dmg_str, i));
        var xx = start_x + (i - 1) * spacing;
        var inst = instance_create_layer(xx, _y, "Instances_1", obj_number);
        inst.image_index = char;
    }
	
	
	with (obj_battle_menu){
	with (theEnemy){
		alarm[0] = room_speed / 2;
	}
}
}
