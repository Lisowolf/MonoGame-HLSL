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
uniform int width;
uniform int height;
uniform int intensity;
uniform bool sensitive;

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
	if (!sensitive) sigma = sqrt(sigma);
	else sigma /= 2;
	return (1 / (sigma * sqrt(2 * PI))) * exp((pow(1 - u, 2) / (2 * pow(sigma, 2))) * -1);
}

float4 Blur(VertexShaderOutput input, bool horizontal) : COLOR
{	
	float pixelSize;
	float2 leftOffset = input.TextureCoordinates, rightOffset = input.TextureCoordinates;
	float4 blurred = tex2D(SpriteTextureSampler, input.TextureCoordinates) * NormalDistribution(intensity, 0);
	
	if (horizontal) pixelSize = 1.0 / width;
	else pixelSize = 1.0 / height;
	
	for (int layer = 0; layer < intensity; layer++)
	{
		if (horizontal)
		{
			leftOffset.x -= pixelSize;
			rightOffset.x += pixelSize;
		}
		else
		{
			leftOffset.y -= pixelSize;
			rightOffset.y += pixelSize;
		}
		blurred += (tex2D(SpriteTextureSampler, leftOffset) + tex2D(SpriteTextureSampler, rightOffset)) * NormalDistribution(intensity, layer + 1);
	}
	return blurred;
}

float4 HorizontalBlur(VertexShaderOutput input) : COLOR
{
	return Blur(input, true);
}

float4 VerticalBlur(VertexShaderOutput input) : COLOR
{
	return Blur(input, false);
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL HorizontalBlur();
	}
	pass P1
	{
		PixelShader = compile PS_SHADERMODEL VerticalBlur();
	}
};