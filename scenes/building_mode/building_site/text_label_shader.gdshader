shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D font_atlas;
uniform vec2 atlas_grid = vec2(16.0, 16.0);  // celdas X, Y
uniform vec2 glyph_size = vec2(0.0625, 0.0625);

uniform int text_length : hint_range(0,32);
uniform int text_chars[32];

uniform vec4 font_color;
uniform float outline_width : hint_range(0.0,0.2) = 0.03;

void fragment() {
    // UV.x recorre el ancho completo (0..1) que mapearemos a caracteres
    float pos = UV.x * float(text_length);
    int idx = int(floor(pos));
    if (idx < 0 || idx >= text_length) {
        discard;
    }

    // UV local dentro del glifo (0..1 en X, Y)
    vec2 local_uv = vec2(fract(pos), UV.y);

    // Código ASCII del char
    int code = text_chars[idx];

    // Coordenada de celda en el atlas
    float col = float(code % int(atlas_grid.x));
    float row = float(code / int(atlas_grid.x));

    vec2 base_uv = vec2(col, row) * glyph_size;
    vec2 uv_atlas = base_uv + local_uv * glyph_size;

    // Muestreamos SDF desde canal rojo
    float sdf = texture(font_atlas, uv_atlas).r;

    // Generamos alpha con smoothstep (umbral 0.5)
    float alpha = smoothstep(0.5 - outline_width, 0.5 + outline_width, sdf);
    ALBEDO = font_color.rgb;
    ALPHA  = font_color.a * alpha;
}
