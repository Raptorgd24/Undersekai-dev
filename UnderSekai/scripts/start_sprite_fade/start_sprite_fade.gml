/// start_sprite_fade(target_sprite, is_final)
/// Llama esto desde obj_controlMenu para iniciar el proceso.
/// target_sprite = resource index (o noone para final sin swap)
/// is_final = true si este fade debe terminar la intro y cambiar room
function start_sprite_fade(_target, _is_final) {
    fade_target_sprite = _target;
    fade_is_final = _is_final;
    fade_mode = "to_black";
    // fade_alpha se incrementa en Step
}
