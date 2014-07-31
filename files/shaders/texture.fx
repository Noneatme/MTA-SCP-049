texture Tex;


technique fickdiehenne
{
    pass P0
    {
        Texture[0] = Tex;

		AlphaBlendEnable = TRUE;
    }
}
