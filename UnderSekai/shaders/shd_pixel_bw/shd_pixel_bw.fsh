varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float pixel_size;

void main()
{
    // Obtener tamaño de un pixel en coordenadas UV
    vec2 pixel = vec2(pixel_size / 360.0, pixel_size / 360.0);

    // Pixelado manual
    vec2 uv = floor(v_vTexcoord / pixel) * pixel;

    vec4 color = texture2D(gm_BaseTexture, uv);

    // Blanco y negro
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    gl_FragColor = v_vColour * vec4(vec3(gray), color.a);
}