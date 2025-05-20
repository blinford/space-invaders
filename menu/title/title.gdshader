shader_type canvas_item;

uniform vec2 center = vec2(100.);

void vertex() {
	//VERTEX.y += sin(TIME)*5.;
	VERTEX.x += sin(TIME+VERTEX.x*.008)*2.;
	VERTEX.y += sin(TIME+VERTEX.x*.008)*4.;
}

void fragment() {
	
}