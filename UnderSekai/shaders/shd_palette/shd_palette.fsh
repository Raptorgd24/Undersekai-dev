varying vec2 v_vTexcoord;
uniform sampler2D palette;
uniform float row;
uniform float total_rows;
uniform vec4 palette_uvs;

void main() {
    vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord);

    if (base_color.a < 0.01) {
        gl_FragColor = vec4(0.0);
        return;
    }

    float r = base_color.r;
    float g = base_color.g;
    float b = base_color.b;

    float index = -1.0;

    // ✅ Canal dominante: el ganador debe duplicar a los otros dos
    if      (r > 0.5 && r > g * 2.0 && r > b * 2.0) index = 0.0; // rojo
    else if (g > 0.5 && g > r * 2.0 && g > b * 2.0) index = 1.0; // verde
    else if (b > 0.5 && b > r * 2.0 && b > g * 2.0) index = 2.0; // azul

    if (index < 0.0) {
        gl_FragColor = base_color;
        return;
    }

    float palette_width = 3.0;
    float norm_x = (index + 0.5) / palette_width;
    float norm_y = (row   + 0.5) / total_rows;

    float atlas_x = palette_uvs.x + norm_x * (palette_uvs.z - palette_uvs.x);
    float atlas_y = palette_uvs.y + norm_y * (palette_uvs.w - palette_uvs.y);

    vec3 new_color = texture2D(palette, vec2(atlas_x, atlas_y)).rgb;
    gl_FragColor = vec4(new_color, base_color.a);
}