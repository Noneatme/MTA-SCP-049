
#include "mta-helper.fx"

//--------------------------------------------------------------------------------------
// Textures
//--------------------------------------------------------------------------------------
texture sTex0 :TEX0;
texture sTex1 :TEX1;

float fGrainFreq=500.0;						// image grain frequency, for some reason high values cause shadow flickering
float fGrainScale=0.075;						// grain effect scale
float3 gColorize=float3(1,1,1);  // the color of the screen.
bool isBlackWhite=true;
//--------------------------------------------------------------------------------------
// Sampler Inputs
//--------------------------------------------------------------------------------------

sampler2D InputSampler = sampler_state
{
    Texture = (sTex0);
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
    AddressU   = Clamp;
	AddressV   = Clamp;
};

sampler2D SamplerNoise = sampler_state
{
	Texture   = (sTex1);
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU  = Wrap;
	AddressV  = Wrap;
};


struct VSInput
{
    float3 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
};

struct PSInput
{
    float4 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
};
 
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;
    PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);
    PS.TexCoord = VS.TexCoord;
    return PS;
}

float Random(float2 co)
{
    return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}

float Grain(float3 tex)
{
	float PI = 3.1415926535897932384626433832795;
	float rofl = Random(tex.xy);
	float grain = sin(PI * tex.z * rofl * fGrainFreq) * fGrainScale * rofl;
	return grain;
}

float3 Gray(float3 res)
{
float temp=(res.r+res.g+res.b)/3;
return float3(temp,temp,temp);
}


float4 PixelShaderFunction(PSInput PS) : COLOR0
{
	float4 res;
	float2 coord = PS.TexCoord.xy;
	res.xyz = tex2D(InputSampler, coord.xy).xyz;
	if (isBlackWhite==true) {
	res.xyz=Gray(res.xyz);
	res.xyz*=gColorize;
					}
	res.xyz += tex2D(SamplerNoise, coord.xy * 1024).xyz * Grain(float3(coord.xy, gTime));
	res.a = 1.0;
	return res;
}

technique ImageGrain
{
  pass P0
  {
	VertexShader = compile vs_2_0 VertexShaderFunction();
	PixelShader  = compile ps_2_0 PixelShaderFunction();
  }
}