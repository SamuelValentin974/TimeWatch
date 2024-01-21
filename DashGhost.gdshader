shader_type canvas_item;

uniform bool whiten = false;
uniform float mix_weight = 1.0;
uniform float move_speed = 1.0;
uniform float move_intensity = 0.5;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);
    if (whiten) {
        vec3 white = vec3(1, 1, 1);
        vec3 whitened_texture_rgb = mix(texture_color.rgb, white, mix_weight);
        COLOR = vec4(whitened_texture_rgb, texture_color.a);
    } else {
        float move_factor = sin(TIME * move_speed) * 0.5 + 0.5;
        
        vec3 moved_color = texture_color.rgb;
        moved_color.r += move_intensity * move_factor;
        moved_color.b += move_intensity * move_factor;

        COLOR = vec4(moved_color, texture_color.a);
    }
}
