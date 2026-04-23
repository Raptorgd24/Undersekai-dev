if (use_palette) {
    // ✅ Bug 4: Desactivar interpolación para evitar sangrado entre colores
    gpu_set_tex_filter(false);
// Justo antes de shader_set(shd_palette)
var uvs = sprite_get_uvs(spr_palette, 0);
show_debug_message("UVs: " + string(uvs[0]) + ", " + string(uvs[1]) + ", " + string(uvs[2]) + ", " + string(uvs[3]));
show_debug_message("my_row: " + string(my_row) + " / total: " + string(total_sets));
    shader_set(shd_palette);

    var u_row   = shader_get_uniform(shd_palette, "row");
    var u_total = shader_get_uniform(shd_palette, "total_rows");
    shader_set_uniform_f(u_row,   my_row);
    shader_set_uniform_f(u_total, total_sets);

    var u_palette = shader_get_sampler_index(shd_palette, "palette");
    texture_set_stage(u_palette, sprite_get_texture(spr_palette, 0));

    draw_self();

    shader_reset();
} else {
    draw_self();
}