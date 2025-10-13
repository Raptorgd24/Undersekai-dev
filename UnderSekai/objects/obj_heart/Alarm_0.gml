if (mode == "intro") {
    if (parpadeos < 5) {
        // Parpadear alternando alpha
        if (alpha_state == 0) {
            image_alpha = 1;
            alpha_state = 1;
        } else {
            image_alpha = 0;
            alpha_state = 0;
        }
        parpadeos += 1;
        alarm[0] = 10;  // tiempo entre parpadeos, ajustar según rapidez deseada
    } else {
        // Terminó intro, pasar a modo select (selección de acción)
        mode = "select";
        image_alpha = 1;
    }
}
