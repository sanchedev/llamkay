shader_type spatial;
render_mode blend_mix, cull_back, depth_draw_opaque, unshaded;

uniform vec4 stripe_color = vec4(0.5, 0.8, 1.0, 0.7); // celeste principal
uniform float bg_alpha = 0.2; // alpha del fondo celeste
uniform float speed = 1.0;     // velocidad de las barras
uniform float frequency = 5.0; // cantidad de barras
uniform float sharpness = 0.5; // suavidad de las barras (0=suave, 1=duro)

void fragment() {
    // Patrón animado con seno y coseno
    float wave = sin(UV.x * frequency + TIME * speed) + cos(UV.y * frequency + TIME * speed);

    // Normalizar de [-2, 2] a [0, 1]
    float pattern = (wave * 0.25) + 0.5;

    // Hacer que las barras tengan transiciones suaves o duras
    pattern = smoothstep(0.5 - sharpness * 0.5, 0.5 + sharpness * 0.5, pattern);

    // Fondo: mismo color pero alpha bajo
    vec4 bg_color = vec4(stripe_color.rgb, bg_alpha);

    // Barra: mismo color pero alpha alto
    vec4 bar_color = vec4(stripe_color.rgb, stripe_color.a);

    // Interpolación entre fondo y barra según el patrón
    vec4 final_color = mix(bg_color, bar_color, pattern);

    ALBEDO = final_color.rgb;
    ALPHA = final_color.a;
}
