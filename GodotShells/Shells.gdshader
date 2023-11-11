shader_type spatial;

uniform uint _Density;
uniform float _NoiseMax;
uniform float _MaxHeight;
uniform sampler2D _LengthTexture;
uniform sampler2D _ColorTexture : source_color;
instance uniform float _NormalizedHeight;

varying float _shellHeight;

float hash(uint n) {
	// integer hash copied from Hugo Elias
	n = (n << 13U) ^ n;
	n = n * (n * n * 15731U + 7901729U) + 83587310985U;
	return float(n & uint(0x7fffffffU)) / float(0x7fffffff);
}

void vertex() {
	_shellHeight = _MaxHeight * _NormalizedHeight;
	VERTEX += NORMAL * _shellHeight;
}

void fragment() {
	float sampledLength = texture(_LengthTexture, UV).x;
	float wantedLength = mix(0.0, _MaxHeight, sampledLength);
	vec2 uvScaled = float(_Density) * UV.xy;
	vec2 uvLocal = fract(uvScaled) * 2.0 - vec2(1);
	uvec2 uvInt = uvec2(uint(uvScaled.x), uint(uvScaled.y));
	float randomValue = hash(uvInt.x + 100U * uvInt.y + 1000U);
	float actualLength = wantedLength - randomValue * _NoiseMax * _MaxHeight;
	float threshold = _NormalizedHeight;
	float width = mix(1.0, 0.0, _shellHeight / actualLength);
	float distanceFromCenter = length(uvLocal);
	if(_shellHeight > actualLength || distanceFromCenter > width) {
		discard;
	}
	vec3 colorValue = texture(_ColorTexture, UV).rgb;
	ALBEDO = colorValue;
}