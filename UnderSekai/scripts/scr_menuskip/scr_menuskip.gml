function scr_menuskip(){
// scr_menuskip: skip inmediato
show_debug_message("=== SCR_MENUSKIP EJECUTADO ===");

if (instance_exists(obj_controlMenu)) {
    with (obj_controlMenu) {
        show_debug_message("Limpiando intro...");
        
        // Limpiar todo inmediatamente
        intro_display_text = "";
        intro_char_index = 0;
        
        // Destruir cualquier obj_menusprite existente
        with (obj_menusprite) {
            show_debug_message("Destruyendo menusprite");
            instance_destroy();
        }
        
        // Activar fade final INMEDIATAMENTE
        show_debug_message("Activando fade final");
        scr_introfade("full_on");
        intro_state = "final_fade";
        pending_final = false;
    }
}
}