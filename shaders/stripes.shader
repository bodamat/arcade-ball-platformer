shader_type spatial;

uniform vec4 color1 : hint_color = vec4(1,1,1,1);
uniform vec4 color2 : hint_color = vec4(0,0,0,1);
uniform float tiling : hint_range(1,500) = 10;
uniform float direction : hint_range(0, 1) = 0.4;
uniform float warp_scale : hint_range(0, 1) = 0;
uniform float warp_tiling : hint_range(0, 10) = 1;

void fragment() {
	const float PI = 3.14159;
	vec2 pos;
	pos.x = mix(UV.x, UV.y, direction);
	pos.y = mix(UV.y, 1.0 - UV.x, direction);
	
	pos.x += sin(pos.y * warp_tiling * PI * 2.0) * warp_scale;
	pos.x *= tiling; 
	
	float value = floor(fract(pos.x) + 0.5);
	vec4 result_color = mix(color1, color2, value);
	
	ALBEDO.x = result_color.x;
	ALBEDO.y = result_color.y;
	ALBEDO.z = result_color.z;
	ALPHA = result_color.w;
}