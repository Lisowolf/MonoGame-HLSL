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
uniform int intensity;

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

float4 Blur(VertexShaderOutput input, bool horizontal)
{
	float pixelSize;
	float4 color = tex2D(SpriteTextureSampler, input.TextureCoordinates);
	if (horizontal)
	{
		pixelSize = 1.0 / width;
		input.TextureCoordinates.x -= pixelSize * abs(intensity) / 2;
	}
	else
	{
		pixelSize = 1.0 / height;
		input.TextureCoordinates.y -= pixelSize * abs(intensity) / 2;
	}
		
	for (int step = 0; step < intensity; step++)
	{
		color += tex2D(SpriteTextureSampler, input.TextureCoordinates);
		if (horizontal) input.TextureCoordinates.x += pixelSize;
		else input.TextureCoordinates.y += pixelSize;
	}
	return color /= abs(intensity) + 1;
}

float4 VerticalBlur(VertexShaderOutput input) : COLOR
{
	return Blur(input, false);
}

float4 HorizontalBlur(VertexShaderOutput input) : COLOR
{
	return Blur(input, true);
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