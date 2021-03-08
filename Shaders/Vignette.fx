#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
static const float PI = 3.14159265f;
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

float NormalDistribution(float sigma, float u)
{
	return (1 / (sigma * sqrt(2 * PI))) * exp(-(pow(1 - u, 2) / (2 * pow(sigma, 2))));
}

float4 Vignette(VertexShaderOutput input) : COLOR
{
	float horizontalU = input.TextureCoordinates.x;
	float verticalU = input.TextureCoordinates.y;
	float sigma = abs(intensity);
	float normalize = 1 - NormalDistribution(sigma, 1);
	
	float4 vignette = input.Color;
	vignette.rgb = NormalDistribution(sigma, horizontalU * 2) * NormalDistribution(sigma, verticalU * 2) + normalize;
	return tex2D(SpriteTextureSampler, input.TextureCoordinates) * vignette;
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL Vignette();
	}
};