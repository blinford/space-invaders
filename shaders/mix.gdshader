shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

vec3 hsb2rgb(in vec3 c) {
	vec3 rgb = clamp(abs(mod(c.x*6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
	rgb = rgb*rgb*(3.0-2.0*rgb);
	return c.z * mix(vec3(1.0), rgb, c.y);
}

void fragment() {
	vec2 st = UV.xy;
	vec3 color = vec3(0.0);

	// convert to polar coordinates
	vec2 to_center = vec2(0.5)-st;
	float angle = mod(atan(to_center.x, to_center.y) - TIME, 6.28);
	float radius = length(to_center)*2.0;

	angle += tan(radius);
	color = hsb2rgb(vec3((angle/6.28)+0.5, radius, 1.0));
	COLOR = vec4(color, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
