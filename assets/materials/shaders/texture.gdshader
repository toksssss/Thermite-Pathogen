shader_type spatial;
render_mode specular_disabled, specular_occlusion_disabled;

uniform sampler2D _MainTex : source_color, repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//vec3 albedo = texture(_MainTex, UV).rgb;
	vec3 color = vec3(1, 0, 0);
	
	ALPHA = 0.5;
	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
