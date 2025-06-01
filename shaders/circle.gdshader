shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}


float circle(in vec2 _st, in float _radius) {
	return sin(200.*length(abs(_st)-0.5)-10.*TIME);
}
void fragment() {
	vec2 st = UV.xy;
	
	vec3 color = vec3(circle(st, 0.9));
	
	COLOR = vec4(color, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
