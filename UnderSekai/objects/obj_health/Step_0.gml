/// Step Event - actualizar tamaño físico del objeto según HP actual


hp_display = lerp(hp_display, global.healthu, 0.2);

var ratio = global.healthu / global.maxHP;       // porcentaje de vida actual
dynamic_width = global.maxHP * px_per_hp;       // ancho máximo

show_debug_message("health visible: " + string(visible) + " | hp: " + string(global.healthu) + " | maxHP: " + string(global.maxHP) + " | name: " + string(global.name));