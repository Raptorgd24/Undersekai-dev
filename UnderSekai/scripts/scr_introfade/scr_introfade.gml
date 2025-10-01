function scr_introfade(_mode){

switch (_mode) {
    case "half_on":
        half_active = true;
        full_active = false;
        half_fade = 0;
    break;

    case "half_off":
        half_active = false;
    break;

    case "full_on":
        full_active = true;
        half_active = false;
        full_fade = 0;
    break;

    case "update":
        // Animación de los fades
        if (half_active) {
            half_fade = clamp(half_fade + fade_speed, 0, 1);
        } else if (!full_active) {
            half_fade = clamp(half_fade - fade_speed, 0, 1);
        }

        if (full_active) {
            full_fade = clamp(full_fade + fade_speed, 0, 1);
        }
    break;
}
}