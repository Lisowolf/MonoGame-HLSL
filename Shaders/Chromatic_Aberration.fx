#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
uniform int width;
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

float4 ChromaticAberration(VertexShaderOutput input) : COLOR
{
	float pixelSize = (1.0 / width) * intensity;
	float4 channel_shift;
	
	channel_shift.ra = tex2D(SpriteTextureSampler, input.TextureCoordinates).ra; //red + alpha
	input.TextureCoordinates.x -= pixelSize;
	channel_shift.g = tex2D(SpriteTextureSampler, input.TextureCoordinates).g; //green
	input.TextureCoordinates.x += pixelSize * 2;
	channel_shift.b = tex2D(SpriteTextureSampler, input.TextureCoordinates).b; //blue
	return channel_shift;
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL ChromaticAberration();
	}
};