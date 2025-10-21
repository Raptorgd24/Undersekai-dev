/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
// Step Event
// Aumentar alpha y escala suavemente
if (image_alpha < 1) {
    image_alpha = clamp(image_alpha + fade_speed, 0, 1);
}

