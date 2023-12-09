// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleFloor"
{
	Properties
	{
		_FinalTexture("Final Texture", 2D) = "white" {}
		_FinalColor("Final Color", Color) = (1,0,0,1)
		_FinalColor2("Final Color 2", Color) = (0,0,0,0)
		_FinalPower("Final Power", Range( 0 , 10)) = 6
		_FinalExp("Final Exp", Range( 0.2 , 4)) = 2
		_FinalMaskMultiply("Final Mask Multiply", Range( 0 , 10)) = 2
		[Toggle(_RAMPENABLED_ON)] _RampEnabled("Ramp Enabled", Float) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_Distance("Distance", Float) = 1
		_DistancePower("Distance Power", Range( 0.2 , 4)) = 1
		_OffsetPower("Offset Power", Float) = 0
		[Toggle(_IGNOREYAXIS_ON)] _IgnoreYAxis("Ignore Y Axis", Float) = 0
		_Noise01("Noise 01", 2D) = "white" {}
		_Noise02("Noise 02", 2D) = "white" {}
		_Noise01ScrollSpeed("Noise 01 Scroll Speed", Float) = 0.1
		_Noise02ScrollSpeed("Noise 02 Scroll Speed", Float) = 0.15
		_NoiseDistortion("Noise Distortion", 2D) = "white" {}
		_NoiseDistortionScrollSpeed("Noise Distortion Scroll Speed", Float) = 0.05
		_NoiseDistortionPower("Noise Distortion Power", Range( 0 , 0.2)) = 0.1
		_NoisePower("Noise Power", Range( 0 , 10)) = 4
		_NoiseTiling("Noise Tiling", Float) = 0.25
		[Toggle(_ZYUV_ON)] _ZYUV("ZY UV", Float) = 0
		[Toggle(_XYUV_ON)] _XYUV("XY UV", Float) = 0
		[Toggle(_AUDIOSPECTRUMENABLED_ON)] _AudioSpectrumEnabled("Audio Spectrum Enabled", Float) = 0
		[HideInInspector]_AudioSpectrum("Audio Spectrum", 2D) = "white" {}
		_AudioSpectrumPower("Audio Spectrum Power", Range( 0 , 1)) = 1
		_AudioSpectrumDistanceTiling("Audio Spectrum Distance Tiling", Float) = 4
		[Toggle(_AUDIOMASKENABLED_ON)] _AudioMaskEnabled("Audio Mask Enabled", Float) = 0
		_AudioMaskExp("Audio Mask Exp", Range( 0.1 , 4)) = 1
		_AudioMaskMultiply("Audio Mask Multiply", Range( 1 , 4)) = 1
		_AudioMaskAffectsAmplitude("Audio Mask Affects Amplitude", Range( 0 , 1)) = 0
		[Toggle(_AUDIOAMPLITUDEENABLED_ON)] _AudioAmplitudeEnabled("Audio Amplitude Enabled", Float) = 0
		_AudioAmplitudeEmissionPower("Audio Amplitude Emission Power", Range( 0 , 4)) = 1
		_AudioAmplitudeOffsetPower("Audio Amplitude Offset Power", Range( 0 , 4)) = 1
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _IGNOREYAXIS_ON
		#pragma shader_feature _ZYUV_ON
		#pragma shader_feature _XYUV_ON
		#pragma shader_feature _AUDIOSPECTRUMENABLED_ON
		#pragma shader_feature _AUDIOMASKENABLED_ON
		#pragma shader_feature _AUDIOAMPLITUDEENABLED_ON
		#pragma shader_feature _RAMPENABLED_ON
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_tex4coord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Affector;
		uniform float _Distance;
		uniform float _DistancePower;
		uniform float _FinalMaskMultiply;
		uniform sampler2D _Noise02;
		uniform float _Noise02ScrollSpeed;
		uniform float _NoiseTiling;
		uniform sampler2D _NoiseDistortion;
		uniform float _NoiseDistortionScrollSpeed;
		uniform float _NoiseDistortionPower;
		uniform sampler2D _Noise01;
		uniform float _Noise01ScrollSpeed;
		uniform float _NoisePower;
		uniform float3 _AudioPosition;
		uniform float _AudioSpectrumDistanceTiling;
		uniform float _AudioMaskExp;
		uniform float _AudioMaskMultiply;
		uniform sampler2D _AudioSpectrum;
		uniform float _AudioSpectrumPower;
		uniform float _OffsetPower;
		uniform float _AudioAverageAmplitude;
		uniform float _AudioAmplitudeOffsetPower;
		uniform float _AudioMaskAffectsAmplitude;
		uniform float4 _FinalColor2;
		uniform float4 _FinalColor;
		uniform float _FinalExp;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform sampler2D _FinalTexture;
		uniform float4 _FinalTexture_ST;
		uniform float _AudioAmplitudeEmissionPower;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 appendResult17 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
			float temp_output_180_0 = ( _Distance + 0.0 );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( temp_output_180_0 - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (temp_output_180_0 - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float4 break102 = appendResult17;
			float2 appendResult104 = (float2(break102.x , break102.z));
			float2 appendResult142 = (float2(break102.x , break102.y));
			#ifdef _XYUV_ON
				float2 staticSwitch140 = appendResult142;
			#else
				float2 staticSwitch140 = appendResult104;
			#endif
			float2 appendResult143 = (float2(break102.z , break102.y));
			#ifdef _ZYUV_ON
				float2 staticSwitch141 = appendResult143;
			#else
				float2 staticSwitch141 = staticSwitch140;
			#endif
			float2 ParticlePositionUV106 = staticSwitch141;
			float2 temp_output_119_0 = ( ParticlePositionUV106 * _NoiseTiling );
			float2 panner109 = ( ( _Time.y * _Noise02ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 panner131 = ( ( _Time.y * _NoiseDistortionScrollSpeed ) * float2( 0.05,0.05 ) + temp_output_119_0);
			float4 tex2DNode132 = tex2Dlod( _NoiseDistortion, float4( panner131, 0, 0.0) );
			float2 temp_cast_2 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_2 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_3 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_3 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2Dlod( _Noise02, float4( lerpResult127, 0, 0.0) ).r * tex2Dlod( _Noise01, float4( lerpResult128, 0, 0.0) ).r * _NoisePower );
			float4 appendResult165 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			float temp_output_166_0 = distance( appendResult165 , float4( _AudioPosition , 0.0 ) );
			float clampResult201 = clamp( (0.0 + (( -temp_output_166_0 + _AudioSpectrumDistanceTiling ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling - 0.0)) , 0.0 , 1.0 );
			float clampResult233 = clamp( ( pow( clampResult201 , _AudioMaskExp ) * _AudioMaskMultiply ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED_ON
				float staticSwitch196 = clampResult233;
			#else
				float staticSwitch196 = 1.0;
			#endif
			float2 appendResult168 = (float2(( temp_output_166_0 * ( 1.0 / _AudioSpectrumDistanceTiling ) ) , 0.0));
			float clampResult170 = clamp( ( staticSwitch196 * tex2Dlod( _AudioSpectrum, float4( appendResult168, 0, 0.0) ).r * _AudioSpectrumPower ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED_ON
				float staticSwitch174 = clampResult170;
			#else
				float staticSwitch174 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch174 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float3 appendResult138 = (float3(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w));
			float3 normalizeResult139 = normalize( appendResult138 );
			#ifdef _AUDIOAMPLITUDEENABLED_ON
				float staticSwitch223 = 1.0;
			#else
				float staticSwitch223 = 0.0;
			#endif
			float clampResult231 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude ) + staticSwitch196 ) , 0.0 , 1.0 );
			v.vertex.xyz += ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult139 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower * staticSwitch223 * clampResult231 ) + 1.0 ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 appendResult17 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
			float temp_output_180_0 = ( _Distance + 0.0 );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( temp_output_180_0 - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (temp_output_180_0 - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float4 break102 = appendResult17;
			float2 appendResult104 = (float2(break102.x , break102.z));
			float2 appendResult142 = (float2(break102.x , break102.y));
			#ifdef _XYUV_ON
				float2 staticSwitch140 = appendResult142;
			#else
				float2 staticSwitch140 = appendResult104;
			#endif
			float2 appendResult143 = (float2(break102.z , break102.y));
			#ifdef _ZYUV_ON
				float2 staticSwitch141 = appendResult143;
			#else
				float2 staticSwitch141 = staticSwitch140;
			#endif
			float2 ParticlePositionUV106 = staticSwitch141;
			float2 temp_output_119_0 = ( ParticlePositionUV106 * _NoiseTiling );
			float2 panner109 = ( ( _Time.y * _Noise02ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 panner131 = ( ( _Time.y * _NoiseDistortionScrollSpeed ) * float2( 0.05,0.05 ) + temp_output_119_0);
			float4 tex2DNode132 = tex2D( _NoiseDistortion, panner131 );
			float2 temp_cast_2 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_2 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_3 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_3 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2D( _Noise02, lerpResult127 ).r * tex2D( _Noise01, lerpResult128 ).r * _NoisePower );
			float4 appendResult165 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float temp_output_166_0 = distance( appendResult165 , float4( _AudioPosition , 0.0 ) );
			float clampResult201 = clamp( (0.0 + (( -temp_output_166_0 + _AudioSpectrumDistanceTiling ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling - 0.0)) , 0.0 , 1.0 );
			float clampResult233 = clamp( ( pow( clampResult201 , _AudioMaskExp ) * _AudioMaskMultiply ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED_ON
				float staticSwitch196 = clampResult233;
			#else
				float staticSwitch196 = 1.0;
			#endif
			float2 appendResult168 = (float2(( temp_output_166_0 * ( 1.0 / _AudioSpectrumDistanceTiling ) ) , 0.0));
			float clampResult170 = clamp( ( staticSwitch196 * tex2D( _AudioSpectrum, appendResult168 ).r * _AudioSpectrumPower ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED_ON
				float staticSwitch174 = clampResult170;
			#else
				float staticSwitch174 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch174 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
			float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
			#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
			#else
				float4 staticSwitch81 = lerpResult37;
			#endif
			float2 uv_FinalTexture = i.uv_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
			#ifdef _AUDIOAMPLITUDEENABLED_ON
				float staticSwitch223 = 1.0;
			#else
				float staticSwitch223 = 0.0;
			#endif
			float clampResult231 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude ) + staticSwitch196 ) , 0.0 , 1.0 );
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower * staticSwitch223 * clampResult231 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17104
7;41;1906;992;4752.95;-381.0929;1.409769;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;149;-3322.907,-1054.587;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;148;-3324.907,-1265.587;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2987.389,-1125.477;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;164;-5524.014,409.6762;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;163;-5512.582,596.9232;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;97;-3274.945,-713.9004;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;96;-3280.945,-863.9004;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;102;-2749.313,-1303.455;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;142;-2469.166,-1404.684;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;165;-5177.062,526.0333;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;227;-5214.506,745.4747;Inherit;False;Global;_AudioPosition;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;93;-3043.945,-791.9004;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;11;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;20;-3031.338,-970.8239;Float;False;Global;_Affector;_Affector;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;104;-2470.998,-1297.124;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;140;-2226.134,-1435.527;Float;False;Property;_XYUV;XY UV;22;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;166;-4896.698,640.6075;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;-2459.352,-1524.997;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2739.945,-969.9004;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;198;-4423.191,1179.549;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;-4509.801,862.5861;Float;False;Property;_AudioSpectrumDistanceTiling;Audio Spectrum Distance Tiling;26;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;19;-2446.929,-1046.137;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;141;-1977.886,-1514.628;Float;False;Property;_ZYUV;ZY UV;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;22;-2283.804,-1040.446;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;199;-4266.19,1241.549;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1796.388,-1303.287;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3646.018,-332.5234;Float;False;Property;_Distance;Distance;8;0;Create;True;0;0;False;0;1;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2107.307,-1047.715;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;-3300.351,-289.6949;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;200;-4116.19,1244.549;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3322.463,-176.7314;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;17;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;20;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;-4390.007,783.9355;Float;False;Constant;_Float4;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3132.352,-237.1247;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;201;-3935.192,1246.549;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;-4085.871,1431.618;Float;False;Property;_AudioMaskExp;Audio Mask Exp;28;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;15;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;14;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3385.508,-374.6587;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;202;-3728.222,1282.027;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-3857.53,1527.547;Float;False;Property;_AudioMaskMultiply;Audio Mask Multiply;29;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;181;-2939.351,-376.9302;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2884.253,-305.0402;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;189;-4210.007,810.9355;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;18;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-3477.929,1398.846;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-4030.261,623.445;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;16;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2625.198,-390.5479;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;168;-3866.003,621.9705;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;233;-3336.119,1396.126;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;197;-3731.306,1134.635;Float;False;Constant;_Float8;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2441.016,-389.9604;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2642.906,-219.4901;Float;False;Property;_DistancePower;Distance Power;9;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-3694.159,796.9613;Inherit;False;Property;_AudioSpectrumPower;Audio Spectrum Power;25;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;12;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;19;0;Create;True;0;0;False;0;4;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;196;-3510.801,1152.734;Float;False;Property;_AudioMaskEnabled;Audio Mask Enabled;27;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;13;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;162;-3714.889,595.5585;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;24;1;[HideInInspector];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;33;-2205.906,-309.4904;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-3362.007,541.9355;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2016.534,-316.0599;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1273.442,-2496.126;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-2899.038,89.09859;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-2867.064,605.5749;Float;False;Constant;_Float2;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2971.988,171.2753;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;5;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;170;-3095.351,624.8678;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-2664.985,121.2754;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;174;-2694.065,625.5749;Float;False;Property;_AudioSpectrumEnabled;Audio Spectrum Enabled;23;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-2740.755,446.5673;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-2425.914,316.1152;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-2190.81,111.4448;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;228;-1660.809,-44.42228;Inherit;False;Property;_AudioMaskAffectsAmplitude;Audio Mask Affects Amplitude;30;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;232;-1298.02,13.25854;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-2028.198,105.5364;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-1660.54,-446.8771;Inherit;False;Constant;_Float6;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-1661.54,-373.8771;Inherit;False;Constant;_Float7;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1132.582,-956.051;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;230;-1099.251,95.36963;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-1155.75,-1041.046;Float;False;Property;_FinalExp;Final Exp;4;0;Create;True;0;0;False;0;2;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1022.638,-873.7692;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-812.5833,-919.587;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-1144.1,-412.6004;Float;False;Property;_AudioAmplitudeEmissionPower;Audio Amplitude Emission Power;32;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;223;-1480.604,-431.6946;Inherit;False;Property;_AudioAmplitudeEnabled;Audio Amplitude Enabled;31;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;136;-817.7505,-1089.046;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-871.1545,-1259.316;Float;False;Property;_FinalColor;Final Color;1;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;231;-965.02,100.2585;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-1138.427,-312.0393;Float;False;Property;_AudioAmplitudeOffsetPower;Audio Amplitude Offset Power;33;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;-876.8575,-1445.834;Float;False;Property;_FinalColor2;Final Color 2;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;176;-1124.129,-506.6568;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;137;-228.6922,186.1153;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;182;-829.2169,-605.8663;Float;False;Constant;_Float1;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-139.7283,-35.88242;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;138;-1.196892,230.7829;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;37;-544.9852,-1361.165;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-804.0983,-468.6004;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-802.3237,-328.6171;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;187;-805.3337,-184.8246;Float;False;Constant;_Float3;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-437.946,-1036.915;Inherit;True;Property;_Ramp;Ramp;7;0;Create;True;0;0;False;0;-1;None;1260249478b816b468c2888f0a40a2e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;147;-59.34668,-705.358;Inherit;True;Property;_FinalTexture;Final Texture;0;0;Create;True;0;0;False;0;-1;None;a0c8393bc92291e438c0a270fbfa611f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;81;29.55398,-1088.316;Float;False;Property;_RampEnabled;Ramp Enabled;6;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;52;69.31149,-969.7088;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;186;-576.8622,-294.4085;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-602.2161,-563.8663;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;102.2141,60.22781;Float;False;Property;_OffsetPower;Offset Power;10;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-43.23003,-796.5675;Float;False;Property;_FinalPower;Final Power;3;0;Create;True;0;0;False;0;6;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;139;141.7103,230.6127;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;89;115.3373,-31.72628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;420.6493,-17.59701;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;441.4877,-984.6585;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;159;993.235,-582.7628;Float;False;True;2;ASEMaterialInspector;0;0;Unlit;SineVFX/LivingParticles/LivingParticleFloor;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;148;3
WireConnection;17;1;148;4
WireConnection;17;2;149;1
WireConnection;102;0;17;0
WireConnection;142;0;102;0
WireConnection;142;1;102;1
WireConnection;165;0;164;3
WireConnection;165;1;164;4
WireConnection;165;2;163;1
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;104;0;102;0
WireConnection;104;1;102;2
WireConnection;140;1;104;0
WireConnection;140;0;142;0
WireConnection;166;0;165;0
WireConnection;166;1;227;0
WireConnection;143;0;102;2
WireConnection;143;1;102;1
WireConnection;94;0;17;0
WireConnection;94;1;93;0
WireConnection;95;0;20;0
WireConnection;95;1;93;0
WireConnection;198;0;166;0
WireConnection;19;0;94;0
WireConnection;19;1;95;0
WireConnection;141;1;140;0
WireConnection;141;0;143;0
WireConnection;22;0;19;0
WireConnection;199;0;198;0
WireConnection;199;1;188;0
WireConnection;106;0;141;0
WireConnection;45;0;22;0
WireConnection;180;0;25;0
WireConnection;200;0;199;0
WireConnection;200;2;188;0
WireConnection;26;0;180;0
WireConnection;26;1;27;0
WireConnection;201;0;200;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;202;0;201;0
WireConnection;202;1;203;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;181;0;180;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;189;0;190;0
WireConnection;189;1;188;0
WireConnection;205;0;202;0
WireConnection;205;1;204;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;171;0;166;0
WireConnection;171;1;189;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;132;1;131;0
WireConnection;28;0;24;0
WireConnection;28;2;181;0
WireConnection;168;0;171;0
WireConnection;233;0;205;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;23;0;28;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;98;1;128;0
WireConnection;196;1;197;0
WireConnection;196;0;233;0
WireConnection;99;1;127;0
WireConnection;162;1;168;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;194;0;196;0
WireConnection;194;1;162;1
WireConnection;194;2;226;0
WireConnection;53;0;33;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;111;0;105;0
WireConnection;170;0;194;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;174;1;175;0
WireConnection;174;0;170;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;174;0
WireConnection;88;0;117;0
WireConnection;232;0;228;0
WireConnection;90;0;88;0
WireConnection;230;0;232;0
WireConnection;230;1;196;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;223;1;224;0
WireConnection;223;0;225;0
WireConnection;136;0;91;0
WireConnection;136;1;135;0
WireConnection;231;0;230;0
WireConnection;138;0;137;2
WireConnection;138;1;137;3
WireConnection;138;2;137;4
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;136;0
WireConnection;179;0;176;0
WireConnection;179;1;178;0
WireConnection;179;2;223;0
WireConnection;179;3;231;0
WireConnection;185;0;176;0
WireConnection;185;1;184;0
WireConnection;185;2;223;0
WireConnection;185;3;231;0
WireConnection;82;1;83;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;186;0;185;0
WireConnection;186;1;187;0
WireConnection;183;0;182;0
WireConnection;183;1;179;0
WireConnection;139;0;138;0
WireConnection;89;0;92;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;139;0
WireConnection;42;3;186;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;147;1
WireConnection;3;4;183;0
WireConnection;159;2;3;0
WireConnection;159;11;42;0
ASEEND*/
//CHKSM=E2A436C8E9E66F6460E684769EF32AE1A4C2E9A8