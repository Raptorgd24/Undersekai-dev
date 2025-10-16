/// @desc Lógica de actualización del HUD

// Asegurar que la vida esté en rango
global.health = clamp(global.health, 0, global.maxHP);

// Transición suave del HP visual (puedes ajustar el 0.15)
hp_display = lerp(hp_display, global.health, 0.15);
