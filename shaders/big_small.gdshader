shader_type canvas_item;

vec2 scale(vec2 uv, float x, float y) {
	mat2 scale = mat2(vec2(x, 0.0), vec2(0.0, y));
	//uv -= 0.5;
	uv = uv * scale;
	//uv += 0.5;
	return uv;
}

void vertex() {
	VERTEX.xy = VERTEX.xy;
}

void fragment() {
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
