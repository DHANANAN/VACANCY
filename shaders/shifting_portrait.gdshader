shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform vec4 base_tint : source_color = vec4(0.85, 0.78, 0.65, 1.0);
uniform vec4 warped_tint : source_color = vec4(0.35, 0.25, 0.25, 1.0);
uniform float warp_intensity : hint_range(0.0, 1.0) = 0.0;
uniform float face_decay : hint_range(0.0, 1.0) = 0.0;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

void fragment() {
    vec2 uv = UV;
    
    // Subtle facial distortion based on time and decay
    float noise = hash(floor(uv * 40.0) + vec2(TIME * 0.05));
    float dist = distance(uv, vec2(0.5, 0.45)); // Face center region
    
    float blur_mask = smoothstep(0.35, 0.0, dist);
    vec2 warped_uv = uv + vec2(sin(uv.y * 10.0 + TIME) * 0.02 * warp_intensity * blur_mask);
    
    // Sepia antique photograph simulation with dark vignette border
    vec3 col = mix(base_tint.rgb, warped_tint.rgb, face_decay + (noise * 0.1 * warp_intensity));
    
    // Photo vignette frame
    float frame = smoothstep(0.7, 0.95, distance(uv, vec2(0.5)));
    col = mix(col, vec3(0.05, 0.04, 0.03), frame);
    
    ALBEDO = col;
    ROUGHNESS = 0.6;
}
