varying vec2 v_vTexcoord;

uniform sampler2D palette;

uniform float row;
uniform float total_rows;

uniform vec4 palette_uvs;

void main()
{
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);

    if (base.a <= 0.0)
    {
        gl_FragColor = base;
        return;
    }

    float index = -1.0;

    float eps = 0.05;

    if (distance(base.rgb, vec3(1.0, 0.0, 0.0)) < eps)
    {
        index = 0.0;
    }
    else if (distance(base.rgb, vec3(0.0, 1.0, 0.0)) < eps)
    {
        index = 1.0;
    }
    else if (distance(base.rgb, vec3(0.0, 0.0, 1.0)) < eps)
    {
        index = 2.0;
    }

    if (index < 0.0)
    {
        gl_FragColor = base;
        return;
    }

    float palette_width = 3.0;

    // UV LOCAL dentro de la paleta
    float local_x = (index + 0.5) / palette_width;
    float local_y = (row + 0.5) / total_rows;

    // Convertir a UV REAL del atlas
    float atlas_x = mix(palette_uvs.x, palette_uvs.z, local_x);
    float atlas_y = mix(palette_uvs.y, palette_uvs.w, local_y);

    vec4 pal = texture2D(palette, vec2(atlas_x, atlas_y));

    gl_FragColor = vec4(pal.rgb, base.a);
}