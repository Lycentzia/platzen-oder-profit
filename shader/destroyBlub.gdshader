shader_type spatial;

uniform sampler2D noise_texture;
uniform sampler2D color;
uniform float smoothness : hint_range(0.0,1.0, 0.05);

varying vec3 world_position;

float fresnel(vec3 normal, mat4 camera_matrix){
	vec3 view_direction_world = (camera_matrix * vec4(0.0,0.0,1.0, 0.0)).xyz;
	vec3 normal_world = (camera_matrix * vec4(normal, 0.0)).xyz;

	float fresnel = dot(view_direction_world, normal_world);
	fresnel = clamp(abs(fresnel), 0.0, 1.0);
	return 1.0 - fresnel;
}

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float height = texture(noise_texture, VERTEX.xz * smoothness + vec2(TIME * 0.05)).r;
	VERTEX += NORMAL * height;
	// Called for every vertex the material is visible on.
}

uniform vec2 fragment_number = vec2(20,20);
uniform float dissolve_state : hint_range(0.0, 1.1) = 1;

void fragment() {
	float fresnel = fresnel(NORMAL, INV_VIEW_MATRIX);
	ALBEDO = texture(color, world_position.xy + vec2(TIME * 0.1)).rgb;
	ROUGHNESS = 0.0f;
	ALPHA = fresnel;

	vec2 pixelFract = fract(UV * fragment_number);
	float pixelDist = distance(pixelFract, vec2(0.5,0.5));
	ALPHA *= step(pixelDist, dissolve_state);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
