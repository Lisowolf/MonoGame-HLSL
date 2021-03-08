#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
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

float4 Black_and_White(VertexShaderOutput input) : COLOR
{
	float4 pixel = tex2D(SpriteTextureSampler, input.TextureCoordinates);
	input.Color.rgb = ((pixel.r + pixel.g + pixel.b) / 3) * intensity;
	return tex2D(SpriteTextureSampler, input.TextureCoordinates) * (1 - intensity) + input.Color;
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL Black_and_White();
	}
};