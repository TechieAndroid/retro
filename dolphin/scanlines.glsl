void main()
{
	float2 coords = GetCoordinates();
	
	//3.5 is line thickness
	float lineCount = GetWindowResolution().y / 3.5;

    // scanlines
    int lineIndex = int(coords.y * lineCount);
#ifdef API_OPENGL
    float lineIntensity = mod(float(lineIndex), 2);
#elif API_VULKAN
    float lineIntensity = mod(float(lineIndex), 2);
#else
    float lineIntensity = float(lineIndex) % 2.0;
#endif

    // color shift
    float4 shift = float4(0.002, 0.002, 0.002, 0);
    
    // shift R and G channels to simulate NTSC color bleed
    float4 colorShift = float4(0.001, 0, 0, 0);
    float r = (Sample() + colorShift + shift).x;
    float g = (Sample() - colorShift + shift).y;
    float b = Sample().z;
	
    //0.5 is darkness, lower is darker
    float4 c = float4(r, g, b, 1.0) * clamp(lineIntensity, 0.5, 1.0);
    
    SetOutput(c);
}
