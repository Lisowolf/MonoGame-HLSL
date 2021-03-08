#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
uniform int seed;
uniform float intensity;

sampler2D SpriteTextureSampler = sampler_state
{
	Texture = <SpriteTexture>;
};

struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
	float2 TextureCoordinates : TEXCOORD0;
};

static int Random(float seed, int max)
{
	return (214013 * seed + 2531101) % max;
}

float4 Noise(VertexShaderOutput input) : COLOR
{
	float4 noise = input.Color;
	noise.rgb = Random(sin(dot(sin(input.TextureCoordinates + seed), 100)), 100) / 100.0;
	return tex2D(SpriteTextureSampler, input.TextureCoordinates) * (noise * intensity + 1 * (1 - intensity));
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL Noise();
	}
};