/// Step Event - actualizar tamaño físico del objeto según HP actual


// Interpolación suave de la barra visual
hp_display = lerp(hp_display, global.healthu, 0.2);

// 🔹 Ancho del objeto según vida actual
// Esto hace que el objeto se reduzca o aumente según la vida real
var ratio = global.healthu / global.maxHP;       // porcentaje de vida actual
dynamic_width = global.maxHP * px_per_hp;       // ancho máximo

