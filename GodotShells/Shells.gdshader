shader_type spatial;

uniform uint _Density;
uniform vec3 _Color;
instance uniform float _Threshold;
instance uniform float _Width;
instance uniform float _Height;

float hash(uint n) {
	// integer hash copied from Hugo Elias
	n = (n << 13U) ^ n;
	n = n * (n * n * 15731U + 7901729U) + 83587310985U;
	return float(n & uint(0x7fffffffU)) / float(0x7fffffff);
}

void vertex() {
	VERTEX += NORMAL * _Height;
}

void fragment() {
	vec2 uvScaled = float(_Density) * UV.xy;
	vec2 uvLocal = fract(uvScaled) * 2.0 - vec2(1);
	float distanceFromCenter = length(uvLocal);
	uvec2 uvInt = uvec2(uint(uvScaled.x), uint(uvScaled.y));
	float randomValue = hash(uvInt.x + 100U * uvInt.y + 1000U);
	if(randomValue < _Threshold || distanceFromCenter > _Width) {
		discard;
	}
	vec3 colorValue = mix(vec3(0.0), _Color, step(_Threshold, randomValue));
	ALBEDO = vec3(colorValue);
}













