shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform vec4 screen_glow : source_color = vec4(0.7, 0.8, 0.95, 1.0);
uniform float static_intensity : hint_range(0.0, 1.0) = 0.85;
uniform float scanline_count : float = 120.0;
uniform float flicker_speed : float = 24.0;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;
    
    // Analog static noise
    float noise = rand(uv + vec2(sin(TIME * flicker_speed), cos(TIME * flicker_speed * 0.7)));
    
    // Scanlines
    float scanline = sin(uv.y * scanline_count * 3.14159) * 0.5 + 0.5;
    
    vec3 col = mix(vec3(0.05), screen_glow.rgb, noise * static_intensity);
    col *= (0.75 + scanline * 0.25);
    
    ALBEDO = col;
    EMISSION = col * 1.5;
    ROUGHNESS = 0.2;
}

