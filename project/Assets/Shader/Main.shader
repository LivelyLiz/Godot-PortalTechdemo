shader_type canvas_item;

uniform sampler2D mask;
uniform sampler2D blending;

void fragment() {
	vec4 main_color = texture(TEXTURE, UV);
	vec4 blending_color = texture(blending, UV);
	float t = texture(mask, UV).a;
	COLOR = (1.0-t)*main_color + t*blending_color;
}