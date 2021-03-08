#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
uniform int horizontal_blocks;
uniform int vertical_blocks;

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

float4 Pixelize(VertexShaderOutput input) : COLOR
{
	input.TextureCoordinates.x = round(input.TextureCoordinates.x * horizontal_blocks) / horizontal_blocks;
	input.TextureCoordinates.y = round(input.TextureCoordinates.y * vertical_blocks) / vertical_blocks;
	return tex2D(SpriteTextureSampler, input.TextureCoordinates) * input.Color;
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL Pixelize();
	}
};