
// Author: Ren712/AngerMAN


float2 DistFade=float2(15, 1); // min and max distance the effect fades / all 
float4 lightColor=float4(1,1,0.9,1); 
float4 texColor=float4(0.6,0.6,0.6,1);
bool isLightDir = false;
float lightDirAcc = 1;
bool isFakeBump = false;
bool isDiffuse = false;
float stBrightness=0;
float2 rc = float2(0.0018,0.0015); // fake bump parameter
//-- Include some common stuff
#define GENERATE_NORMALS     
#include "mta-helper.fx"

   
   
//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------

sampler Sampler0 = sampler_state
{
    Texture = (gTexture0);
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
 
 struct VSInput
{
	float4 Position : POSITION; 
	float3 TexCoord : TEXCOORD0;
	float4 Diffuse : COLOR0;
	float4 Normal : NORMAL0;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------

struct PSInput
{
	float4 Position : POSITION;
	float2 TexCoord : TEXCOORD0;	
	float DistFade : TEXCOORD2;
	float LightDirection : TEXCOORD3; 
	float4 Diffuse : TEXCOORD4;
};

//-----------------------------------------------------------------------------
//-- VertexShader
//-----------------------------------------------------------------------------
PSInput VertexShaderSB(VSInput VS)
{
	PSInput PS = (PSInput)0;
	
	// Make sure normal is valid
	MTAFixUpNormal( VS.Normal.xyz);
	
	// The usual stuff
	PS.Position = mul(VS.Position, gWorldViewProjection);
	float4 worldPos = mul(VS.Position, gWorld); 
	 
	//calculate light vector
	float3 WorldNormal = MTACalcWorldNormal(VS.Normal.xyz);
	float3 h = (gCameraPosition - worldPos.xyz);
	PS.LightDirection = saturate(dot(WorldNormal,h));

   PS.TexCoord = VS.TexCoord;
   
   // limit the effect only to certain area
   float DistanceFromCamera = MTACalcCameraDistance( gCameraPosition, MTACalcWorldPosition(VS.Position));
   PS.DistFade = MTAUnlerp ( DistFade.x, DistFade.y, DistanceFromCamera );
   PS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );
   
   return PS;
}
 
 
 
//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderSB(PSInput PS) : COLOR0
{
	float4 texel = tex2D(Sampler0, PS.TexCoord);

	float4 texLight = lightColor*saturate(PS.DistFade);
	if (isFakeBump==true) {
	texel -= tex2D(Sampler0, PS.TexCoord.xy - rc.xy)*1.5;
	texel += tex2D(Sampler0, PS.TexCoord.xy + rc.xy)*1.5;
						  }
	if (isLightDir==true) {texLight*= saturate(pow(PS.LightDirection,lightDirAcc));}
	float4 outPut =stBrightness*texel+float4(0,0,0,texel.a)+float4(texLight.rgb,1)*texel*texColor;
	if (isDiffuse==true) {outPut*=PS.Diffuse;}
	return outPut;
}


////////////////////////////////////////////////////////////
//////////////////////////////// TECHNIQUES ////////////////
////////////////////////////////////////////////////////////
technique CreepyLight
{
    pass P0
    {
	AlphaBlendEnable = TRUE;
	VertexShader = compile vs_2_0 VertexShaderSB();
	PixelShader = compile ps_2_0 PixelShaderSB();
    }
}
