shader_type canvas_item;

// Psychological horror post-processing: film grain, chromatic aberration, lens distortion
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.35;
uniform float chromatic_aberration : hint_range(0.0, 0.02) = 0.003;
uniform float grain_intensity : hint_range(0.0, 0.1) = 0.025;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // Chromatic aberration (color channel separation)
    vec2 dist = uv - 0.5;
    vec2 offset = dist * chromatic_aberration;
    
    float r = texture(SCREEN_TEXTURE, uv - offset).r;
    float g = texture(SCREEN_TEXTURE, uv).g;
    float b = texture(SCREEN_TEXTURE, uv + offset).b;
    vec3 color = vec3(r, g, b);
    
    // Film grain
    float noise = (random(uv + vec2(TIME * 0.1, TIME * 0.05)) - 0.5) * grain_intensity;
    color += noise;
    
    // Vignette
    float vig = length(dist);
    color *= 1.0 - smoothstep(0.3, 0.85, vig) * vignette_intensity;
    
    COLOR = vec4(color, 1.0);
}
