/// scr_npcwalk(_target, _dir, _frames, _speed, _moonwalking)
/// _target: id de la instancia NPC
/// _dir: "left","right","up","down"
/// _frames: cantidad de frames a moverse
/// _speed: velocidad
/// _moonwalking: bool (si true mueve/animación invertida)

function scr_npcwalk(_target, _dir, _frames, _speed, _moonwalking) {
    // Comprobación de existencia del target
    if (!instance_exists(_target)) {
        show_debug_message("[scr_npcwalk] Error: objetivo no existe: " + string(_target));
        return;
    }

    // Asignar las variables EN la instancia objetivo
    with (_target) {
        NPCmoving    = true;
        NPCdirection = _dir;
        NPCframes    = _frames;
        NPCspeed     = _speed;
        NPCmoonwalk  = _moonwalking;

        // Inicializar frame/imagen según dirección
        switch (_dir) {
            case "down":  image_index = 0;  break;
            case "left":  image_index = 5;  break;
            case "right": image_index = 9;  break;
            case "up":    image_index = 13; break;
        }

        // Debug: confirmación de asignación de variables
        show_debug_message("[scr_npcwalk] variables asignadas a " + string(npc_id) +
            " | direction=" + string(NPCdirection) +
            " frames=" + string(NPCframes) +
            " speed=" + string(NPCspeed) +
            " moonwalk=" + string(NPCmoonwalk));

        // Debug: inicio de caminata
        show_debug_message("[scr_npcwalk] " + string(npc_id) + 
            " comienza a caminar hacia " + string(_dir) + 
            " por " + string(_frames) + " frames a velocidad " + string(_speed) + 
            " moonwalk=" + string(_moonwalking));
    }
}
