// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "NEWLaserLayerOpaque"
{
	Properties
	{
		_VertexOffsetPower("Vertex Offset Power", Float) = 0
		_FinalColor("Final Color", Color) = (1,1,1,1)
		_FinalPower("Final Power", Range( 0 , 10)) = 2
		_ShapeSize("Shape Size", Float) = 0.25
		_ShapeStartRound("Shape Start Round", Range( 1 , 10)) = 6
		_ShapeEndRound("Shape End Round", Range( 1 , 10)) = 6
		_ShapeAddStartPosition("Shape Add Start Position", Float) = 4
		_ShapeAddEndPosition("Shape Add End Position", Float) = 4
		_ShapeConeForm("Shape Cone Form", Range( 0 , 1)) = 1
		[Toggle] _ShapeEndDisableShrink("Shape End Disable Shrink", Float) = 0.0
		_OpacityCutoff("Opacity Cutoff", 2D) = "white" {}
		_OpacityRemap1("Opacity Remap 1", Float) = 0
		_OpacityRemap2("Opacity Remap 2", Float) = 0
		_Noise01("Noise 01", 2D) = "white" {}
		_Noise01ScrollSpeed("Noise 01 Scroll Speed", Float) = -2
		_Noise01OffsetPower("Noise 01 Offset Power", Range( -4 , 4)) = 0.1
		_Nosie01Distortion("Nosie 01 Distortion", 2D) = "white" {}
		_Noise01DistortionScrollSpeed("Noise 01 Distortion Scroll Speed", Float) = -6
		_Noise01DistortionPower("Noise 01 Distortion Power", Range( 0 , 1)) = 0.1
		_Noise01Add("Noise 01 Add", Range( 0 , 1)) = 0.25
		_Noise02("Noise 02", 2D) = "white" {}
		_Noise02Power("Noise 02 Power", Float) = 1
		_Noise02ScrollSpeed("Noise 02 Scroll Speed", Float) = -1.5
		_Noise01Power("Noise 01 Power", Float) = 1
		_GammaLinear("Gamma Linear", Range( 0.2 , 1)) = 1
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TilingU("Tiling U", Float) = 0.1
		_TilingV("Tiling V", Float) = 1
		_UVTwist("UV Twist", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _SHAPEENDDISABLESHRINK_ON
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float4 _FinalColor;
		uniform float _FinalPower;
		uniform sampler2D _Noise01;
		uniform float _TilingU;
		uniform float _TilingV;
		uniform float _Noise01ScrollSpeed;
		uniform float4 _StartPosition;
		uniform float _FinalSize;
		uniform float _UVTwist;
		uniform sampler2D _Nosie01Distortion;
		uniform float _Noise01DistortionScrollSpeed;
		uniform float _Noise01DistortionPower;
		uniform float _Noise01Power;
		uniform float _Noise01Add;
		uniform sampler2D _Noise02;
		uniform float _Noise02ScrollSpeed;
		uniform float _Noise02Power;
		uniform float _GammaLinear;
		uniform float _Distance;
		uniform sampler2D _OpacityCutoff;
		uniform float _OpacityRemap1;
		uniform float _OpacityRemap2;
		uniform float _Progress;
		uniform float _ShapeAddStartPosition;
		uniform float _ShapeStartRound;
		uniform float4 _EndPosition;
		uniform float _ShapeAddEndPosition;
		uniform float _ShapeEndRound;
		uniform float _Noise01OffsetPower;
		uniform float _ShapeSize;
		uniform float _ImpactProgress;
		uniform float _MaxDist;
		uniform float _ShapeConeForm;
		uniform float _VertexOffsetPower;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_58_0 = distance( float4( ase_worldPos , 0.0 ) , _StartPosition );
			float FSize157 = _FinalSize;
			float temp_output_54_0 = ( 1.0 - ( 0.25 * FSize157 ) );
			float temp_output_63_0 = ( temp_output_54_0 + _ShapeAddStartPosition );
			float clampResult67 = clamp( ( ( 1.0 - temp_output_58_0 ) + _ShapeAddStartPosition ) , 0.0 , temp_output_63_0 );
			float temp_output_86_0 = ( _ShapeAddEndPosition + temp_output_54_0 );
			float clampResult87 = clamp( ( ( 1.0 - distance( _EndPosition , float4( ase_worldPos , 0.0 ) ) ) + _ShapeAddEndPosition ) , 0.0 , temp_output_86_0 );
			#ifdef _SHAPEENDDISABLESHRINK_ON
				float staticSwitch161 = 0.0;
			#else
				float staticSwitch161 = pow( (0.0 + (clampResult87 - 0.0) * (1.0 - 0.0) / (temp_output_86_0 - 0.0)) , _ShapeEndRound );
			#endif
			float temp_output_71_0 = max( pow( (0.0 + (clampResult67 - 0.0) * (1.0 - 0.0) / (temp_output_63_0 - 0.0)) , _ShapeStartRound ) , staticSwitch161 );
			float2 appendResult147 = (float2(_TilingU , _TilingV));
			float2 Tiling148 = appendResult147;
			float2 uv_TexCoord72 = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float2 appendResult73 = (float2(( temp_output_58_0 / FSize157 ) , uv_TexCoord72.y));
			float2 appendResult165 = (float2(appendResult73.x , ( appendResult73.y + ( appendResult73.x * _UVTwist ) )));
			float2 UV27 = appendResult165;
			float2 panner26 = ( UV27 + ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,0 ));
			float2 panner25 = ( UV27 + ( _Time.y * _Noise01DistortionScrollSpeed ) * float2( 1,0 ));
			float4 tex2DNode35 = tex2Dlod( _Noise01, float4( ( Tiling148 * ( panner26 + ( (-1.0 + (tex2Dlod( _Nosie01Distortion, float4( ( panner25 * Tiling148 ), 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _Noise01DistortionPower ) ) ), 0, 0.0) );
			float clampResult38 = clamp( ( tex2DNode35.r + _Noise01Add ) , 0.0 , 1.0 );
			float Noise0139 = clampResult38;
			float OffsetMask100 = ( temp_output_71_0 + ( ( 1.0 - temp_output_71_0 ) * Noise0139 * _Noise01OffsetPower ) );
			float temp_output_106_0 = ( _ShapeSize - _ImpactProgress );
			float clampResult130 = clamp( _Progress , 0.0 , 1.0 );
			float temp_output_131_0 = ( 1.0 - clampResult130 );
			float4 StartPos10 = _StartPosition;
			float MaxDistMask18 = ( 1.0 - (0.0 + (distance( float4( ase_worldPos , 0.0 ) , StartPos10 ) - 0.25) * (1.0 - 0.0) / (_MaxDist - 0.25)) );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			v.vertex.xyz += ( ( OffsetMask100 + ( ( 1.0 - OffsetMask100 ) * ( temp_output_106_0 + ( ( 1.0 - temp_output_106_0 ) * temp_output_131_0 ) + ( ( 1.0 - MaxDistMask18 ) * _ShapeConeForm ) ) ) ) * ase_worldNormal * _VertexOffsetPower * FSize157 );
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult147 = (float2(_TilingU , _TilingV));
			float2 Tiling148 = appendResult147;
			float3 ase_worldPos = i.worldPos;
			float temp_output_58_0 = distance( float4( ase_worldPos , 0.0 ) , _StartPosition );
			float FSize157 = _FinalSize;
			float2 uv_TexCoord72 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 appendResult73 = (float2(( temp_output_58_0 / FSize157 ) , uv_TexCoord72.y));
			float2 appendResult165 = (float2(appendResult73.x , ( appendResult73.y + ( appendResult73.x * _UVTwist ) )));
			float2 UV27 = appendResult165;
			float2 panner26 = ( UV27 + ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,0 ));
			float2 panner25 = ( UV27 + ( _Time.y * _Noise01DistortionScrollSpeed ) * float2( 1,0 ));
			float4 tex2DNode35 = tex2D( _Noise01, ( Tiling148 * ( panner26 + ( (-1.0 + (tex2D( _Nosie01Distortion, ( panner25 * Tiling148 ) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _Noise01DistortionPower ) ) ) );
			float2 panner48 = ( UV27 + ( _Time.y * _Noise02ScrollSpeed ) * float2( 1,0 ));
			float clampResult44 = clamp( ( ( tex2DNode35.r * _Noise01Power ) + _Noise01Add + ( tex2DNode35.r * tex2D( _Noise02, ( Tiling148 * panner48 ) ).r * _Noise02Power ) ) , 0.0 , 1.0 );
			float NoiseFull5 = clampResult44;
			o.Emission = ( _FinalColor * _FinalPower * NoiseFull5 * _GammaLinear ).rgb;
			o.Alpha = 1;
			float4 StartPos10 = _StartPosition;
			float ifLocalVar122 = 0;
			if( distance( float4( ase_worldPos , 0.0 ) , StartPos10 ) >= _Distance )
				ifLocalVar122 = 0.0;
			else
				ifLocalVar122 = 1.0;
			float clampResult130 = clamp( _Progress , 0.0 , 1.0 );
			float temp_output_131_0 = ( 1.0 - clampResult130 );
			float clampResult127 = clamp( ( ifLocalVar122 * ( (_OpacityRemap1 + (tex2D( _OpacityCutoff, ( Tiling148 * UV27 ) ).r - 0.0) * (_OpacityRemap2 - _OpacityRemap1) / (1.0 - 0.0)) - temp_output_131_0 ) ) , 0.0 , 1.0 );
			float HackedOpacity128 = clampResult127;
			clip( HackedOpacity128 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
7;29;1906;1004;5676.884;69.4743;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;56;-5895.293,-32.18961;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector4Node;57;-5892.795,116.8238;Float;False;Global;_StartPosition;_StartPosition;13;0;Create;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;-6856.291,475.7538;Float;False;Global;_FinalSize;_FinalSize;15;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;-6689.304,478.0161;Float;False;FSize;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;58;-5621.721,36.95238;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT4;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-5241.267,384.4596;Float;False;157;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;74;-5008.632,271.0036;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;76;-4913.632,227.0036;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;72;-5628.774,305.4774;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;77;-5231.632,223.0036;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-5203.632,274.0036;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;170;-5033.931,517.6678;Float;False;Property;_UVTwist;UV Twist;28;0;Create;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;164;-5009.732,376.4676;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;-4736.229,477.9677;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;168;-4575.129,439.968;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;165;-4452.526,373.6677;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-2895.976,-2637.089;Float;False;Property;_TilingV;Tiling V;27;0;Create;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;19;-4536.888,-1971.413;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-4643.734,-1816.19;Float;False;Property;_Noise01DistortionScrollSpeed;Noise 01 Distortion Scroll Speed;17;0;Create;-6;-9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-2897.237,-2718.995;Float;False;Property;_TilingU;Tiling U;26;0;Create;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-4258.519,-1906.677;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-4305.377,372.0264;Float;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;80;-5878.263,595.2539;Float;False;Global;_EndPosition;_EndPosition;15;0;Create;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;81;-5876.263,769.2535;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;147;-2703.183,-2688.751;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;-4296.721,-1998.999;Float;False;27;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-6820.394,-274.242;Float;False;Constant;_Float3;Float 3;13;0;Create;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-6842.952,-149.2772;Float;False;157;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-4110.127,-1641.511;Float;False;148;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-6597.52,-201.3292;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;148;-2550.711,-2693.791;Float;False;Tiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;82;-5600.263,673.2538;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;25;-4045.723,-1982.999;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-6603.561,-455.0387;Float;False;Constant;_Float4;Float 4;13;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-5541.263,787.2535;Float;False;Property;_ShapeAddEndPosition;Shape Add End Position;7;0;Create;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;83;-5449.263,674.2538;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;-3904.127,-1722.511;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;54;-6324.18,-387.0807;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-4122.849,-2136.097;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;14;0;Create;-2;-14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-5224.265,676.2538;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;20;-4098.569,-2288.229;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-5430.542,871.0263;Float;False;Constant;_Float6;Float 6;16;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;86;-5225.511,772.1522;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-3852.51,-1982.548;Float;True;Property;_Nosie01Distortion;Nosie 01 Distortion;16;0;Create;None;c7383fe1f7d942f5a742d6ae26adcab2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;28;-3852.927,-2303.897;Float;False;27;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-3808.872,-2217.018;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-3633.509,-1696.548;Float;False;Property;_Noise01DistortionPower;Noise 01 Distortion Power;18;0;Create;0.1;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;87;-4941.483,678.8952;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;31;-3537.51,-1979.548;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;60;-5463.188,36.95238;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-5567.061,-47.54124;Float;False;Property;_ShapeAddStartPosition;Shape Add Start Position;6;0;Create;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-3244.509,-1829.547;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;91;-4800.297,792.3525;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;26;-3601.927,-2283.896;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-5201.063,-108.5412;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-5198.063,40.45876;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-5432.595,954.2478;Float;False;Constant;_Float8;Float 8;16;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-3108.041,-2399.04;Float;False;148;0;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;92;-4997.562,888.9316;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-2971.714,-2182.443;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-5452.22,-232.0362;Float;False;Constant;_Float5;Float 5;14;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-2911.307,-2325.388;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;90;-4941.491,916.2323;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-5043.203,1086.787;Float;False;Property;_ShapeEndRound;Shape End Round;5;0;Create;6;10;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;67;-4987.212,42.86727;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-5453.22,-323.0364;Float;False;Constant;_Float7;Float 7;14;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;68;-4787.563,-299.143;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;-4690.138,1087.6;Float;False;Constant;_Float13;Float 13;28;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;35;-2827.095,-2208.705;Float;True;Property;_Noise01;Noise 01;13;0;Create;None;257e43786c09482ebde4c6ee7ff0e59c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;93;-4703.123,984.0448;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2794.597,-1998.203;Float;False;Property;_Noise01Add;Noise 01 Add;19;0;Create;0.25;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-4894.562,-385.1432;Float;False;Property;_ShapeStartRound;Shape Start Round;4;0;Create;6;10;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;11;-5478.77,1804.605;Float;False;10;0;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldPosInputsNode;7;-5491.381,1652.574;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-5622.923,168.8352;Float;False;StartPos;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-2708.407,2108.563;Float;False;Global;_Progress;_Progress;21;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;161;-4497.138,1011.6;Float;False;Property;_ShapeEndDisableShrink;Shape End Disable Shrink;9;0;Create;0;False;False;True;;Toggle;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-5183.106,1537.063;Float;False;Global;_MaxDist;_MaxDist;3;0;Create;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;69;-4553.563,-299.143;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-5200.275,1622.912;Float;False;Constant;_Float0;Float 0;3;0;Create;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-2268.096,-2126.704;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-5180.076,1800.67;Float;False;Constant;_Float1;Float 1;3;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;9;-5180.115,1706.456;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT4;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;45;-3670.363,-1372.118;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-3696.998,-1217.509;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;22;0;Create;-1.5;-21;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-5179.066,1880.459;Float;False;Constant;_Float2;Float 2;3;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;71;-3935.217,194.0172;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;38;-2130.096,-2129.704;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-3389,-1293.508;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;130;-2542.496,2108.563;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;-3420.999,-1392.508;Float;False;27;0;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;12;-4895.891,1663.728;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-3491.279,1082.19;Float;False;Property;_ShapeSize;Shape Size;3;0;Create;0.25;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;-2923.438,2347.138;Float;False;27;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-3831.913,550.6981;Float;False;Property;_Noise01OffsetPower;Noise 01 Offset Power;15;0;Create;0.1;-1;-4;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-3239.988,-1585.071;Float;False;148;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-3531.608,1170.277;Float;False;Global;_ImpactProgress;_ImpactProgress;19;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;48;-3177.999,-1355.508;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;95;-3725.913,381.6982;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;154;-2964.324,2149.9;Float;False;148;0;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;131;-2191.018,2251.28;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-4717.5,1664.321;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-3742.913,464.6982;Float;False;39;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1989.722,-2126.133;Float;False;Noise01;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-3508.913,416.6982;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-3212.169,869.9297;Float;False;18;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-2779.199,2222.892;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-3052.773,-1487.273;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;141;-2026.426,2177.733;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-4553.88,1660.281;Float;False;MaxDistMask;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;106;-3260.976,1112.968;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-3112.406,789.271;Float;False;Property;_ShapeConeForm;Shape Cone Form;8;0;Create;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-3339.913,202.6983;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;108;-3012.635,1272.161;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;142;-2943.431,1427.715;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;-2532.963,2765.287;Float;False;Constant;_Float12;Float 12;24;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;104;-2992.479,873.1141;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-2715.374,-1699.345;Float;False;Property;_Noise01Power;Noise 01 Power;23;0;Create;1;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-2594.963,2682.287;Float;False;Property;_OpacityRemap2;Opacity Remap 2;12;0;Create;0;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-2594.963,2600.287;Float;False;Property;_OpacityRemap1;Opacity Remap 1;11;0;Create;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;-2560.422,1691.232;Float;False;10;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-2871,-1186.509;Float;False;Property;_Noise02Power;Noise 02 Power;21;0;Create;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;119;-2567.812,1542.151;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;137;-2536.963,2516.287;Float;False;Constant;_Float11;Float 11;22;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-2975.999,-1386.508;Float;True;Property;_Noise02;Noise 02;20;0;Create;None;5a1bb16ecdff42fba8ad3aa6decbf6d1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;136;-2683.963,2322.287;Float;True;Property;_OpacityCutoff;Opacity Cutoff;10;0;Create;None;4c3f9add72334f93a939fbe5e2aebdea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-3176.913,199.6983;Float;False;OffsetMask;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-2683.642,897.5232;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-2226.531,1731.464;Float;False;Global;_Distance;_Distance;21;0;Create;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;120;-2227.617,1623.685;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT4;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-2377.375,-1812.444;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-2206.531,1813.464;Float;False;Constant;_Float9;Float 9;21;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-2327.042,880.5432;Float;False;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;132;-2194.432,2370.774;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-2839.644,1271.1;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-2368.275,-1644.745;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-2202.531,1896.464;Float;False;Constant;_Float10;Float 10;21;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;110;-2334.468,1214.852;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;113;-2128.579,885.8499;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-2022.474,-1768.245;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;122;-1969.531,1677.464;Float;False;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;133;-1880.013,2302.319;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-1903.583,951.6503;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-1515.008,1984.934;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;44;-1889.873,-1766.944;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-1739.085,739.3906;Float;False;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;117;-1569.277,855.0724;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;114;-1507.722,754.2488;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;4;-738.5565,12.48412;Float;False;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;160;-1552.788,1086.83;Float;False;157;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-829.6922,-67.92982;Float;False;Property;_FinalPower;Final Power;2;0;Create;2;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;127;-1366.595,1982.937;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;-1744.982,-1769.982;Float;False;NoiseFull;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-818.97,92.89811;Float;False;Property;_GammaLinear;Gamma Linear;24;0;Create;1;1;0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-1606.421,1000.471;Float;False;Property;_VertexOffsetPower;Vertex Offset Power;0;0;Create;0;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-765.3617,-240.8198;Float;False;Property;_FinalColor;Final Color;1;0;Create;1,1,1,1;0,0.4627448,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;-1301.83,878.4206;Float;False;4;4;0;FLOAT;0.0;False;1;FLOAT3;0;False;2;FLOAT;0,0,0;False;3;FLOAT;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-755.6526,238.7267;Float;False;128;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1;-371.3334,-84.01263;Float;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;3;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;128;-1226.815,1983.256;Float;False;HackedOpacity;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;NEWLaserLayerOpaque;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;Off;0;0;False;0;0;Masked;0.5;True;True;0;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;25;-1;-1;-1;0;0;0;False;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;157;0;75;0
WireConnection;58;0;56;0
WireConnection;58;1;57;0
WireConnection;74;0;58;0
WireConnection;74;1;159;0
WireConnection;76;0;74;0
WireConnection;77;0;76;0
WireConnection;73;0;77;0
WireConnection;73;1;72;2
WireConnection;164;0;73;0
WireConnection;169;0;164;0
WireConnection;169;1;170;0
WireConnection;168;0;164;1
WireConnection;168;1;169;0
WireConnection;165;0;164;0
WireConnection;165;1;168;0
WireConnection;22;0;19;2
WireConnection;22;1;23;0
WireConnection;27;0;165;0
WireConnection;147;0;145;0
WireConnection;147;1;146;0
WireConnection;53;0;52;0
WireConnection;53;1;158;0
WireConnection;148;0;147;0
WireConnection;82;0;80;0
WireConnection;82;1;81;0
WireConnection;25;0;29;0
WireConnection;25;1;22;0
WireConnection;83;0;82;0
WireConnection;155;0;25;0
WireConnection;155;1;156;0
WireConnection;54;0;55;0
WireConnection;54;1;53;0
WireConnection;85;0;83;0
WireConnection;85;1;84;0
WireConnection;86;0;84;0
WireConnection;86;1;54;0
WireConnection;30;1;155;0
WireConnection;21;0;20;2
WireConnection;21;1;24;0
WireConnection;87;0;85;0
WireConnection;87;1;88;0
WireConnection;87;2;86;0
WireConnection;31;0;30;1
WireConnection;60;0;58;0
WireConnection;33;0;31;0
WireConnection;33;1;34;0
WireConnection;91;0;87;0
WireConnection;26;0;28;0
WireConnection;26;1;21;0
WireConnection;63;0;54;0
WireConnection;63;1;62;0
WireConnection;61;0;60;0
WireConnection;61;1;62;0
WireConnection;92;0;91;0
WireConnection;32;0;26;0
WireConnection;32;1;33;0
WireConnection;149;0;150;0
WireConnection;149;1;32;0
WireConnection;90;0;92;0
WireConnection;90;1;88;0
WireConnection;90;2;86;0
WireConnection;90;3;88;0
WireConnection;90;4;89;0
WireConnection;67;0;61;0
WireConnection;67;1;65;0
WireConnection;67;2;63;0
WireConnection;68;0;67;0
WireConnection;68;1;65;0
WireConnection;68;2;63;0
WireConnection;68;3;65;0
WireConnection;68;4;66;0
WireConnection;35;1;149;0
WireConnection;93;0;90;0
WireConnection;93;1;94;0
WireConnection;10;0;57;0
WireConnection;161;0;162;0
WireConnection;161;1;93;0
WireConnection;69;0;68;0
WireConnection;69;1;70;0
WireConnection;36;0;35;1
WireConnection;36;1;37;0
WireConnection;9;0;7;0
WireConnection;9;1;11;0
WireConnection;71;0;69;0
WireConnection;71;1;161;0
WireConnection;38;0;36;0
WireConnection;47;0;45;2
WireConnection;47;1;46;0
WireConnection;130;0;129;0
WireConnection;12;0;9;0
WireConnection;12;1;13;0
WireConnection;12;2;14;0
WireConnection;12;3;15;0
WireConnection;12;4;16;0
WireConnection;48;0;49;0
WireConnection;48;1;47;0
WireConnection;95;0;71;0
WireConnection;131;0;130;0
WireConnection;17;0;12;0
WireConnection;39;0;38;0
WireConnection;98;0;95;0
WireConnection;98;1;97;0
WireConnection;98;2;99;0
WireConnection;153;0;154;0
WireConnection;153;1;134;0
WireConnection;151;0;152;0
WireConnection;151;1;48;0
WireConnection;141;0;131;0
WireConnection;18;0;17;0
WireConnection;106;0;107;0
WireConnection;106;1;105;0
WireConnection;96;0;71;0
WireConnection;96;1;98;0
WireConnection;108;0;106;0
WireConnection;142;0;141;0
WireConnection;104;0;103;0
WireConnection;50;1;151;0
WireConnection;136;1;153;0
WireConnection;100;0;96;0
WireConnection;102;0;104;0
WireConnection;102;1;101;0
WireConnection;120;0;119;0
WireConnection;120;1;121;0
WireConnection;40;0;35;1
WireConnection;40;1;42;0
WireConnection;132;0;136;1
WireConnection;132;1;137;0
WireConnection;132;2;140;0
WireConnection;132;3;138;0
WireConnection;132;4;139;0
WireConnection;109;0;108;0
WireConnection;109;1;142;0
WireConnection;41;0;35;1
WireConnection;41;1;50;1
WireConnection;41;2;51;0
WireConnection;110;0;106;0
WireConnection;110;1;109;0
WireConnection;110;2;102;0
WireConnection;113;0;112;0
WireConnection;43;0;40;0
WireConnection;43;1;37;0
WireConnection;43;2;41;0
WireConnection;122;0;120;0
WireConnection;122;1;123;0
WireConnection;122;2;124;0
WireConnection;122;3;124;0
WireConnection;122;4;125;0
WireConnection;133;0;132;0
WireConnection;133;1;131;0
WireConnection;111;0;113;0
WireConnection;111;1;110;0
WireConnection;126;0;122;0
WireConnection;126;1;133;0
WireConnection;44;0;43;0
WireConnection;114;0;115;0
WireConnection;114;1;111;0
WireConnection;127;0;126;0
WireConnection;5;0;44;0
WireConnection;116;0;114;0
WireConnection;116;1;117;0
WireConnection;116;2;118;0
WireConnection;116;3;160;0
WireConnection;1;0;2;0
WireConnection;1;1;3;0
WireConnection;1;2;4;0
WireConnection;1;3;6;0
WireConnection;128;0;127;0
WireConnection;0;2;1;0
WireConnection;0;10;143;0
WireConnection;0;11;116;0
ASEEND*/
//CHKSM=3ED6F32E0205883B9DF59EFED7363B918DC2BAEF