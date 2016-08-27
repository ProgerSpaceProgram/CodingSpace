uniform vec2 bullet_position;
uniform vec4 bullet_color;
uniform float bullet_size;

vec4 effect(vec4 originalColor, Image texture, vec2 texture_coords,
            vec2 screen_coords) {
	vec2 aux = bullet_position - screen_coords.xy;
	float distance = length(aux);
  float attenuation = 1.0 / (1.0 + 5.0 * (distance / (bullet_size * 30)));
	vec4 color = vec4(attenuation, attenuation, attenuation, pow(attenuation, 3))
             * (bullet_color / 255.0);

	return color;
}
