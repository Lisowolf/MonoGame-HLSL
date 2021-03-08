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
uniform int height;

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

float4 LCD(VertexShaderOutput input) : COLOR
{
	int known_width = width, known_height = height; //differently do not set the default value ¯\_(ツ)_/¯
	if (width == 0) known_width = 250; //if width or height is unknown
	if (height == 0) known_height = 250;
	
	if ((int) (input.TextureCoordinates.x * known_width) % 3 == 0)
		input.Color.gb = 0.5f;
	else if ((int) (input.TextureCoordinates.x * known_width) * 2 % 3 == 0)
		input.Color.rb = 0.5f;
	else
		input.Color.rg = 0.5f;
	
	if ((int) (input.TextureCoordinates.y * known_height) % 4 == 0)
		input.Color.rgb *= input.Color.rgb / 1.15f;
	
	return tex2D(SpriteTextureSampler, input.TextureCoordinates) * input.Color;
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL LCD();
	}
};