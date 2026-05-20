if (use_palette)
{

    shader_set(shd_palette);

    // uniforms
    var u_row   = shader_get_uniform(shd_palette, "row");
    var u_total = shader_get_uniform(shd_palette, "total_rows");
    var u_uvs   = shader_get_uniform(shd_palette, "palette_uvs");

    shader_set_uniform_f(u_row, my_row);
    shader_set_uniform_f(u_total, total_sets);

    // ENVIAR UVS
    var uvs = sprite_get_uvs(spr_palette, 0);

    shader_set_uniform_f(
        u_uvs,
        uvs[0],
        uvs[1],
        uvs[2],
        uvs[3]
    );

    // textura
    var tex = sprite_get_texture(spr_palette, 0);

    var sampler = shader_get_sampler_index(shd_palette, "palette");

    texture_set_stage(sampler, tex);

    draw_self();

    shader_reset();

}
else
{
    draw_self();
}
if (global.debug) {
    draw_set_alpha(0.25);
    draw_set_color(c_green);
    draw_rectangle(zone_x1, zone_y1, zone_x2, zone_y2, false);

    draw_set_alpha(0.5);
    draw_set_color(returning ? c_orange : (followPlayer ? c_red : c_green));
    draw_circle(x, y, detect_range, true);

    draw_set_alpha(1);
    draw_set_color(c_white);
}

if (show_alert)
{
    draw_sprite(spr_exclamation, 0, x+5, y - 13);
}