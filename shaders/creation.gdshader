shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 c;
	float l,z=TIME;
	for(int i=0;i<3;i++) {
		vec2 uv,p=UV.xy;
		uv=p;
		p-=.5;
		p.x*=UV.y/UV.y;
		z+=.10;
		l=length(p);
		uv+=p*abs(cos(l*1.-z-z));
		c[i]=.01/length(uv-.5);
	}
	COLOR=vec4(c/l,TIME);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
