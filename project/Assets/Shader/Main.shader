shader_type canvas_item;

uniform sampler2D mask;
uniform sampler2D blending1;
uniform sampler2D blending2;
uniform sampler2D blending3;
uniform sampler2D blending4;
uniform sampler2D blending5;
uniform sampler2D blending6;
uniform sampler2D blending7;
uniform sampler2D blending8;
uniform sampler2D blending9;
uniform sampler2D blending10;
uniform sampler2D blending11;
uniform sampler2D blending12;
uniform sampler2D blending13;
uniform sampler2D blending14;
uniform sampler2D blending15;
uniform sampler2D blending16;
uniform sampler2D blending17;
uniform sampler2D blending18;

void fragment() {
	vec4 mask_c = texture(mask, UV);
	vec4 screen_color = texture(TEXTURE, UV);

	if(mask_c.a < 1.0/255.0 || length(mask_c-screen_color) > 0.0001){
		COLOR = screen_color;
	}else{

	vec4 color = screen_color;
	if (mask_c.r < 2.0/255.0 && mask_c.r > 0.0){
		color = texture(blending1, UV);
	}
	if (mask_c.r < 3.0/255.0 && mask_c.r > 1.0/255.0){
		color = texture(blending2, UV);
	}
	if (mask_c.r < (3.0+1.0)/255.0 && mask_c.r > (3.0-1.0)/255.0){
		color = texture(blending3, UV);
	}
	if (mask_c.r < (4.0+1.0)/255.0 && mask_c.r > (4.0-1.0)/255.0){
		color = texture(blending4, UV);
	}
	if (mask_c.r < (5.0+1.0)/255.0 && mask_c.r > (5.0-1.0)/255.0){
		color = texture(blending5, UV);
	}
	if (mask_c.r < (6.0+1.0)/255.0 && mask_c.r > (6.0-1.0)/255.0){
		color = texture(blending6, UV);
	}
	if (mask_c.r < (7.0+1.0)/255.0 && mask_c.r > (7.0-1.0)/255.0){
		color = texture(blending7, UV);
	}
	if (mask_c.r < (8.0+1.0)/255.0 && mask_c.r > (8.0-1.0)/255.0){
		color = texture(blending8, UV);
	}
	if (mask_c.r < (9.0+1.0)/255.0 && mask_c.r > (9.0-1.0)/255.0){
		color = texture(blending9, UV);
	}
	if (mask_c.r < (10.0+1.0)/255.0 && mask_c.r > (10.0-1.0)/255.0){
		color = texture(blending10, UV);
	}
	if (mask_c.r < (11.0+1.0)/255.0 && mask_c.r > (11.0-1.0)/255.0){
		color = texture(blending11, UV);
	}
	if (mask_c.r < (12.0+1.0)/255.0 && mask_c.r > (12.0-1.0)/255.0){
		color = texture(blending12, UV);
	}
	if (mask_c.r < (13.0+1.0)/255.0 && mask_c.r > (13.0-1.0)/255.0){
		color = texture(blending13, UV);
	}
	if (mask_c.r < (14.0+1.0)/255.0 && mask_c.r > (14.0-1.0)/255.0){
		color = texture(blending14, UV);
	}
	if (mask_c.r < (15.0+1.0)/255.0 && mask_c.r > (15.0-1.0)/255.0){
		color = texture(blending15, UV);
	}
	if (mask_c.r < (16.0+1.0)/255.0 && mask_c.r > (16.0-1.0)/255.0){
		color = texture(blending16, UV);
	}
	if (mask_c.r < (17.0+1.0)/255.0 && mask_c.r > (17.0-1.0)/255.0){
		color = texture(blending17, UV);
	}
	if (mask_c.r < (18.0+1.0)/255.0 && mask_c.r > (18.0-1.0)/255.0){
		color = texture(blending18, UV);
	}
	COLOR = color;
	}

}
