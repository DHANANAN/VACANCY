shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

// Visual Glitch: Subtle tile bleed from house wood/wallpaper to hospital sterile linoleum
uniform vec4 house_color : source_color = vec4(0.2, 0.16, 0.12, 1.0);
uniform vec4 hospital_linoleum : source_color = vec4(0.9, 0.92, 0.94, 1.0);
uniform float bleed_amount : hint_range(0.0, 1.0) = 0.0;
uniform float flicker_speed : hint_range(0.1, 10.0) = 2.0;

void fragment() {
	float flicker = sin(TIME * flicker_speed) * 0.5 + 0.5;
	float mix_factor = clamp(bleed_amount + (flicker * 0.08 * bleed_amount), 0.0, 1.0);
	
	vec4 final_color = mix(house_color, hospital_linoleum, mix_factor);
	ALBEDO = final_color.rgb;
	ROUGHNESS = mix(0.85, 0.15, mix_factor); // Linoleum is glossy, wood/plaster is rough
}

