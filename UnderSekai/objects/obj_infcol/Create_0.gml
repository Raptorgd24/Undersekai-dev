/// Tamaño lógico del patrón
lesize = hahasize; // cámbialo a 0.5, 2, etc. según necesites

/// Velocidad del scroll
scroll_speed = hahaspeed;

/// Escala final (lesize * escala de la room)
final_xscale = image_xscale * lesize;
final_yscale = image_yscale * lesize;

/// Altura real del sprite ya escalado
sprite_height_bg = sprite_get_height(sprite_index) * final_yscale;
