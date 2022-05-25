// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VHSRewind"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_HorizontalDistortion("HorizontalDistortion", Float) = 1
		_Scale("Scale", Float) = 1
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _HorizontalDistortion;
		uniform sampler2D _TextureSample0;
		uniform float _Scale;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _TextureSample2;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float temp_output_1_0_g18 = ( _Time.y * 0.1 );
			float temp_output_26_0_g18 = sin( temp_output_1_0_g18 );
			float temp_output_35_0_g18 = ( temp_output_26_0_g18 + sin( ( temp_output_1_0_g18 * 0.5 ) ) );
			float temp_output_48_0_g18 = ( ( ( temp_output_35_0_g18 + cos( ( ( temp_output_26_0_g18 - ( temp_output_35_0_g18 * 0.6 ) ) * 0.4 ) ) ) * 0.4 ) - ( sin( temp_output_35_0_g18 ) * 0.4 ) );
			float clampResult49_g18 = clamp( ( ( temp_output_48_0_g18 + ( ( cos( ( temp_output_1_0_g18 * 0.1 ) ) + cos( ( temp_output_1_0_g18 * 0.01 ) ) ) - cos( temp_output_48_0_g18 ) ) ) * 0.2 ) , 0.0 , 1.0 );
			float2 uv_TexCoord62 = i.uv_texcoord * float2( 1,5 ) + float2( 0,1 );
			float2 panner61 = ( ( ( clampResult49_g18 * -0.15 ) + _Time.y ) * float2( 0,0 ) + uv_TexCoord62);
			float2 uv_TexCoord29 = i.uv_texcoord * float2( 1,-1 ) + float2( 0,1 );
			float temp_output_1_0_g19 = ( ( (uv_TexCoord29).y * 2.0 ) + ( _Time.y * 0.0 ) );
			float temp_output_26_0_g19 = sin( temp_output_1_0_g19 );
			float temp_output_35_0_g19 = ( temp_output_26_0_g19 + sin( ( temp_output_1_0_g19 * 0.5 ) ) );
			float temp_output_48_0_g19 = ( ( ( temp_output_35_0_g19 + cos( ( ( temp_output_26_0_g19 - ( temp_output_35_0_g19 * 0.6 ) ) * 0.4 ) ) ) * 0.4 ) - ( sin( temp_output_35_0_g19 ) * 0.4 ) );
			float clampResult49_g19 = clamp( ( ( temp_output_48_0_g19 + ( ( cos( ( temp_output_1_0_g19 * 0.1 ) ) + cos( ( temp_output_1_0_g19 * 0.01 ) ) ) - cos( temp_output_48_0_g19 ) ) ) * 0.2 ) , 0.0 , 1.0 );
			float temp_output_42_0 = pow( clampResult49_g19 , 3.0 );
			float2 temp_output_78_0 = ( (ase_grabScreenPosNorm).xy + ( ( ( float2( 0.03,0 ) * _HorizontalDistortion ) * ( tex2D( _TextureSample0, ( panner61 + ( temp_output_42_0 * float2( 0.5,1 ) ) ) ).r * ( temp_output_42_0 - 0.5 ) ) ) * _Scale ) );
			float temp_output_1_0_g20 = ( _Time.y * 16.0 );
			float temp_output_26_0_g20 = sin( temp_output_1_0_g20 );
			float temp_output_35_0_g20 = ( temp_output_26_0_g20 + sin( ( temp_output_1_0_g20 * 0.5 ) ) );
			float temp_output_48_0_g20 = ( ( ( temp_output_35_0_g20 + cos( ( ( temp_output_26_0_g20 - ( temp_output_35_0_g20 * 0.6 ) ) * 0.4 ) ) ) * 0.4 ) - ( sin( temp_output_35_0_g20 ) * 0.4 ) );
			float clampResult49_g20 = clamp( ( ( temp_output_48_0_g20 + ( ( cos( ( temp_output_1_0_g20 * 0.1 ) ) + cos( ( temp_output_1_0_g20 * 0.01 ) ) ) - cos( temp_output_48_0_g20 ) ) ) * 0.2 ) , 0.0 , 1.0 );
			float lerpResult149 = lerp( 0.2 , 1.0 , clampResult49_g20);
			float4 appendResult156 = (float4(( ( lerpResult149 * _Scale ) * 0.015 ) , 0.0 , 0.0 , 0.0));
			float4 screenColor119 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float4( temp_output_78_0, 0.0 , 0.0 ) + appendResult156 ).rg);
			float4 screenColor121 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,temp_output_78_0);
			float2 appendResult120 = (float2(screenColor119.r , screenColor121.g));
			float4 screenColor124 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float4( temp_output_78_0, 0.0 , 0.0 ) - appendResult156 ).rg);
			float4 appendResult122 = (float4(appendResult120 , screenColor124.b , 0.0));
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float temp_output_1_0_g21 = ( _Time.y * 3.0 );
			float temp_output_26_0_g21 = sin( temp_output_1_0_g21 );
			float temp_output_35_0_g21 = ( temp_output_26_0_g21 + sin( ( temp_output_1_0_g21 * 0.5 ) ) );
			float temp_output_48_0_g21 = ( ( ( temp_output_35_0_g21 + cos( ( ( temp_output_26_0_g21 - ( temp_output_35_0_g21 * 0.6 ) ) * 0.4 ) ) ) * 0.4 ) - ( sin( temp_output_35_0_g21 ) * 0.4 ) );
			float clampResult49_g21 = clamp( ( ( temp_output_48_0_g21 + ( ( cos( ( temp_output_1_0_g21 * 0.1 ) ) + cos( ( temp_output_1_0_g21 * 0.01 ) ) ) - cos( temp_output_48_0_g21 ) ) ) * 0.2 ) , 0.0 , 1.0 );
			float4 screenColor117 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,float4( ( ( (ase_screenPosNorm).xy + ( float2( 0,0.05 ) * sin( clampResult49_g21 ) ) ) * float2( 0,0.5 ) ), 0.0 , 0.0 ).xy/float4( ( ( (ase_screenPosNorm).xy + ( float2( 0,0.05 ) * sin( clampResult49_g21 ) ) ) * float2( 0,0.5 ) ), 0.0 , 0.0 ).w);
			float4 blendOpSrc127 = appendResult122;
			float4 blendOpDest127 = screenColor117;
			float4 blendOpSrc125 = appendResult122;
			float4 blendOpDest125 = screenColor117;
			float4 lerpResult129 = lerp( ( saturate( 2.0f*blendOpDest127*blendOpSrc127 + blendOpDest127*blendOpDest127*(1.0f - 2.0f*blendOpSrc127) )) , ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest125) / max( blendOpSrc125, 0.00001) ) ) )) , 0.01);
			float2 uv_TexCoord132 = i.uv_texcoord * float2( 8,1 );
			float2 panner133 = ( _Time.y * float2( 61.2,11.7 ) + uv_TexCoord132);
			float2 panner134 = ( _Time.y * float2( -11.7,-48.1 ) + uv_TexCoord132);
			float4 lerpResult144 = lerp( appendResult122 , ( lerpResult129 + ( ( tex2D( _TextureSample1, panner133 ) - tex2D( _TextureSample2, panner134 ) ) * 0.2 ) ) , _Scale);
			o.Emission = lerpResult144.rgb;
			o.Alpha = 0.5;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1071;126;1040;980;-3885.48;-192.1642;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1348.532,-240.371;Inherit;False;0;-1;2;3;2;OBJECT;;False;0;FLOAT2;1,-1;False;1;FLOAT2;0,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1003.426,387.2711;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;54;-790.163,1189.041;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-983.6072,637.837;Inherit;False;Constant;_Float7;Float 7;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-908.8154,79.39178;Inherit;False;Constant;_Float8;Float 8;1;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-848.42,1655.494;Inherit;False;Constant;_Float9;Float 9;1;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-1023.148,-192.2011;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-554.9634,1478.312;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-720.2043,398.7977;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-692.0494,-3.939395;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-104.2583,1880.292;Inherit;False;Constant;_Float10;Float 10;1;0;Create;True;0;0;0;False;0;False;-0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-396.4212,242.192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;57;-223.8559,1508.212;Inherit;False;RandomOutput;-1;;18;6cf9d653a4158ee4482e114988682923;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-190.1612,773.7411;Inherit;False;Constant;_Float6;Float 6;1;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;53;-102.5216,71.71506;Inherit;False;RandomOutput;-1;;19;6cf9d653a4158ee4482e114988682923;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;93.96326,1661.03;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;48;78.59723,1011.178;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;0;False;0;False;0.5,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;60;247.764,1403.845;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;298.5227,1074.951;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,5;False;1;FLOAT2;0,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;42;-7.112314,507.4285;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;61;551.2105,1106.007;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-601.9399,2490.036;Inherit;False;Constant;_Float15;Float 15;6;0;Create;True;0;0;0;False;0;False;16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;165;-439.1877,2179.219;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;299.6796,770.2064;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-112.1617,2300.535;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;784.372,810.1101;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;68;398.3035,527.9826;Inherit;False;Constant;_Float11;Float 11;2;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;70;1458.135,353.8929;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;0;False;0;False;0.03,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;75;1751.4,155.0944;Inherit;False;Property;_HorizontalDistortion;HorizontalDistortion;1;0;Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;67;640.0684,255.1459;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;151;466.5226,2836.509;Inherit;False;Constant;_Float17;Float 17;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;65;1106.797,733.1104;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;f0f824eae5a68e9459e7b8e1c2eb0265;f0f824eae5a68e9459e7b8e1c2eb0265;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;150;390.7675,2510.341;Inherit;False;Constant;_Float16;Float 16;6;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;148;171.9199,2308.536;Inherit;False;RandomOutput;-1;;20;6cf9d653a4158ee4482e114988682923;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;1705.716,460.8929;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;1495.067,785.535;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;2104.232,1288.916;Inherit;False;Property;_Scale;Scale;2;0;Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;149;411.8104,2179.965;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;1022.06,2076.853;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;154;1452.463,2494.792;Inherit;False;Constant;_Float18;Float 18;6;0;Create;True;0;0;0;False;0;False;0.015;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;84;-1489.472,-893.8685;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;82;2193.439,239.4096;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;1824.87,768.7097;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-1540.817,-604.0486;Inherit;False;Constant;_Float12;Float 12;4;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;2182.451,779.9001;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;157;1865.291,2693.528;Inherit;False;Constant;_Float19;Float 19;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-1193.023,-764.9597;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;80;2457.478,213.9323;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;1726.171,2171.585;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;156;2065.038,2395.186;Inherit;False;COLOR;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;2705.744,508.6368;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;87;-794.148,-814.5168;Inherit;False;RandomOutput;-1;;21;6cf9d653a4158ee4482e114988682923;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;118;2970.482,511.2192;Inherit;False;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;104;-582.7935,-1509.006;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;90;-563.0827,-875.192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;102;-559.0709,-1162.925;Inherit;False;Constant;_Vector2;Vector 2;4;0;Create;True;0;0;0;False;0;False;0,0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-259.7615,-817.4064;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenColorNode;121;3183.746,836.9048;Inherit;False;Global;_GrabScreen2;Grab Screen 2;4;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;123;3001.296,1180.258;Inherit;False;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;105;-179.8983,-1505.776;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenColorNode;119;3188.121,515.8496;Inherit;False;Global;_GrabScreen1;Grab Screen 1;4;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;124;3212.237,1091.195;Inherit;False;Global;_GrabScreen3;Grab Screen 3;4;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;107;381.1754,-746.1322;Inherit;False;Constant;_Vector3;Vector 3;4;0;Create;True;0;0;0;False;0;False;0,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;132;-85.79412,-2450.375;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;8,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;103;159.9906,-1161.375;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;164;-153.0427,-2065.672;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;120;3504.744,524.9802;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;122;3881.756,1163.684;Inherit;False;COLOR;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;134;425.3096,-2077.543;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-11.7,-48.1;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;133;438.0615,-2616.494;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;61.2,11.7;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;532.2767,-1069.305;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;139;775.5292,-2097.89;Inherit;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;0;False;0;False;-1;43d7495183dfbbe44b44638f382c7a61;43d7495183dfbbe44b44638f382c7a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;128;1336.278,-432.5297;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;126;1823.617,-395.1126;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;117;874.6418,-1082.122;Inherit;False;Global;_GrabScreen0;Grab Screen 0;4;0;Create;True;0;0;0;False;0;False;Object;-1;False;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;138;771.1275,-2586.491;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;43d7495183dfbbe44b44638f382c7a61;43d7495183dfbbe44b44638f382c7a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;125;1654.951,-1099.725;Inherit;False;ColorBurn;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;140;1278.246,-2222.341;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;130;1477.073,-1264.821;Inherit;False;Constant;_Float13;Float 13;4;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;143;1488.778,-1869.288;Inherit;False;Constant;_Float14;Float 14;6;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;127;1176.846,-1363.944;Inherit;False;SoftLight;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;1672.646,-2274.452;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;129;2000.359,-1361.872;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;2646.062,-1204.388;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;144;3013.94,-1217.244;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;166;4245.212,664.8805;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DeltaTime;161;-910.1512,1432.977;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DeltaTime;160;-814.8191,2214.361;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DeltaTime;169;-521.7495,-2147.319;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4468.282,381.2328;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;VHSRewind;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.3333;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;4;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;30;0;29;0
WireConnection;56;0;54;0
WireConnection;56;1;55;0
WireConnection;6;0;5;0
WireConnection;6;1;45;0
WireConnection;8;0;30;0
WireConnection;8;1;46;0
WireConnection;7;0;8;0
WireConnection;7;1;6;0
WireConnection;57;1;56;0
WireConnection;53;1;7;0
WireConnection;58;0;57;0
WireConnection;58;1;59;0
WireConnection;60;0;58;0
WireConnection;60;1;54;0
WireConnection;42;0;53;0
WireConnection;42;1;44;0
WireConnection;61;0;62;0
WireConnection;61;1;60;0
WireConnection;47;0;42;0
WireConnection;47;1;48;0
WireConnection;147;0;165;0
WireConnection;147;1;146;0
WireConnection;64;0;61;0
WireConnection;64;1;47;0
WireConnection;67;0;42;0
WireConnection;67;1;68;0
WireConnection;65;1;64;0
WireConnection;148;1;147;0
WireConnection;71;0;70;0
WireConnection;71;1;75;0
WireConnection;66;0;65;1
WireConnection;66;1;67;0
WireConnection;149;0;150;0
WireConnection;149;1;151;0
WireConnection;149;2;148;0
WireConnection;152;0;149;0
WireConnection;152;1;77;0
WireConnection;69;0;71;0
WireConnection;69;1;66;0
WireConnection;76;0;69;0
WireConnection;76;1;77;0
WireConnection;85;0;84;0
WireConnection;85;1;99;0
WireConnection;80;0;82;0
WireConnection;153;0;152;0
WireConnection;153;1;154;0
WireConnection;156;0;153;0
WireConnection;156;1;157;0
WireConnection;78;0;80;0
WireConnection;78;1;76;0
WireConnection;87;1;85;0
WireConnection;118;0;78;0
WireConnection;118;1;156;0
WireConnection;90;0;87;0
WireConnection;101;0;102;0
WireConnection;101;1;90;0
WireConnection;121;0;78;0
WireConnection;123;0;78;0
WireConnection;123;1;156;0
WireConnection;105;0;104;0
WireConnection;119;0;118;0
WireConnection;124;0;123;0
WireConnection;103;0;105;0
WireConnection;103;1;101;0
WireConnection;120;0;119;1
WireConnection;120;1;121;2
WireConnection;122;0;120;0
WireConnection;122;2;124;3
WireConnection;134;0;132;0
WireConnection;134;1;164;0
WireConnection;133;0;132;0
WireConnection;133;1;164;0
WireConnection;106;0;103;0
WireConnection;106;1;107;0
WireConnection;139;1;134;0
WireConnection;128;0;122;0
WireConnection;126;0;122;0
WireConnection;117;0;106;0
WireConnection;138;1;133;0
WireConnection;125;0;126;0
WireConnection;125;1;117;0
WireConnection;140;0;138;0
WireConnection;140;1;139;0
WireConnection;127;0;128;0
WireConnection;127;1;117;0
WireConnection;142;0;140;0
WireConnection;142;1;143;0
WireConnection;129;0;127;0
WireConnection;129;1;125;0
WireConnection;129;2;130;0
WireConnection;131;0;129;0
WireConnection;131;1;142;0
WireConnection;144;0;122;0
WireConnection;144;1;131;0
WireConnection;144;2;77;0
WireConnection;0;2;144;0
WireConnection;0;9;166;0
ASEEND*/
//CHKSM=16084BF2B37B8A0621A6FF6E09C31E9F1896BF09