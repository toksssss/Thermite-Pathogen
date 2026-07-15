shader_type canvas_item;
render_mode skip_vertex_transform;

uniform float speed : hint_range(0.0, 10.0, 0.5) = 1.0;

vec2 rotate(vec2 uv, vec2 p, float angle)
{
	mat2 rotation = mat2(vec2(cos(angle), -sin(angle)),
						vec2(sin(angle), cos(angle)));
	
	uv = uv * rotation;
	return uv;
}

void vertex() {
	vec2 pos = VERTEX;
	
	vec2 rotated_vertex = rotate(pos, vec2(0.5), TIME * speed);
	vec2 vertex = (MODEL_MATRIX * vec4(rotated_vertex, 0.0, 1.0)).xy;
	
	VERTEX = vertex;
}

void fragment() {
	
}
