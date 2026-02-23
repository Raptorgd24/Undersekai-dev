/// @description Inserte aquí la descripción
// Create

row = 0;      // fila seleccionada
col = 0;      // columna seleccionada

text_input = "";   // texto que va escribiendo el jugador
max_chars = 10;    // límite opcional

keyboard = [
    ["Q","W","E","R","T","Y","U","I","O","P"],
    ["A","S","D","F","G","H","J","K","L"],
    ["Z","X","C","V","B","N","M"],
    ["ENTER","RETURN"]
];


image_alpha = 0; // El objeto empieza invisible

enum MenuState {
    INPUT,      // elegir letras
    CONFIRM     // ¿Seguro? Sí / No
}

menu_state = MenuState.INPUT;

confirm_option = 0; // 0 = Sí, 1 = No
name_scale = 1;     // para el tween del nombre
