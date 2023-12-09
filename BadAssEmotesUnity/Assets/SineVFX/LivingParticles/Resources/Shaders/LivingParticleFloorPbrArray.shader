// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleFloorPbrArray"
{
	Properties
	{
		_AffectorCount("Affector Count", Float) = 5
		_Albedo("Albedo", 2D) = "white" {}
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MetallicSmoothness("MetallicSmoothness", 2D) = "white" {}
		_Metallic("Metallic", Float) = 1
		_Smoothness("Smoothness", Float) = 1
		[Toggle]_MetallicSmoothnessRandomOffset("MetallicSmoothness Random Offset", Float) = 1
		_Normal("Normal", 2D) = "bump" {}
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
		[Toggle(_XYUV_ON)] _XYUV("XY UV", Float) = 0
		[Toggle(_ZYUV_ON)] _ZYUV("ZY UV", Float) = 0
		[Toggle(_AUDIOSPECTRUMENABLED2_ON)] _AudioSpectrumEnabled2("Audio Spectrum Enabled", Float) = 0
		_AudioSpectrumPower2("Audio Spectrum Power", Range( 0 , 1)) = 1
		_AudioSpectrumDistanceTiling2("Audio Spectrum Distance Tiling", Float) = 4
		[Toggle(_AUDIOMASKENABLED2_ON)] _AudioMaskEnabled2("Audio Mask Enabled", Float) = 0
		_AudioMaskExp2("Audio Mask Exp", Range( 0.1 , 4)) = 1
		_AudioMaskMultiply2("Audio Mask Multiply", Range( 1 , 4)) = 1
		_AudioMaskAffectsAmplitude2("Audio Mask Affects Amplitude", Range( 0 , 1)) = 0
		[HideInInspector]_AudioSpectrum("Audio Spectrum", 2D) = "white" {}
		[Toggle(_AUDIOAMPLITUDEENABLED2_ON)] _AudioAmplitudeEnabled2("Audio Amplitude Enabled", Float) = 0
		_AudioAmplitudeEmissionPower2("Audio Amplitude Emission Power", Range( 0 , 4)) = 1
		_AudioAmplitudeOffsetPower2("Audio Amplitude Offset Power", Range( 0 , 4)) = 1
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		#pragma shader_feature _AUDIOSPECTRUMENABLED2_ON
		#pragma shader_feature _AUDIOMASKENABLED2_ON
		#pragma shader_feature _AUDIOAMPLITUDEENABLED2_ON
		#pragma shader_feature _RAMPENABLED_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nolightmap  vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float _AffectorCount;
		uniform float4 _Affectors[20];
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
		uniform float3 _AudioPosition2;
		uniform float _AudioSpectrumDistanceTiling2;
		uniform float _AudioMaskExp2;
		uniform float _AudioMaskMultiply2;
		uniform sampler2D _AudioSpectrum;
		uniform float _AudioSpectrumPower2;
		uniform float _OffsetPower;
		uniform float _AudioAverageAmplitude;
		uniform float _AudioAmplitudeOffsetPower2;
		uniform float _AudioMaskAffectsAmplitude2;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _ColorTint;
		uniform float4 _FinalColor2;
		uniform float4 _FinalColor;
		uniform float _FinalExp;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform sampler2D _FinalTexture;
		uniform float4 _FinalTexture_ST;
		uniform float _AudioAmplitudeEmissionPower2;
		uniform sampler2D _MetallicSmoothness;
		uniform float _MetallicSmoothnessRandomOffset;
		uniform float _Metallic;
		uniform float _Smoothness;


		float CE1186( float4 ParticleCenterCE , float4 AffectorsCE , float3 Fix )
		{
			float DistanceMaskMY;
			for (int w = 0; w < _AffectorCount; w++) {
			if(w == 0){
			DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w] * Fix);
			}else{
			DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w] * Fix) );	
			}
			}
			DistanceMaskMY = 1.0 - DistanceMaskMY;
			return DistanceMaskMY;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 appendResult17 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float4 ParticleCenterCE186 = ( appendResult17 * float4( staticSwitch93 , 0.0 ) );
			float4 AffectorsCE186 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix186 = staticSwitch93;
			float localCE1186 = CE1186( ParticleCenterCE186 , AffectorsCE186 , Fix186 );
			float DistanceMask45 = localCE1186;
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float4 break163 = appendResult17;
			float2 appendResult165 = (float2(break163.x , break163.z));
			float2 appendResult164 = (float2(break163.x , break163.y));
			#ifdef _XYUV_ON
				float2 staticSwitch167 = appendResult164;
			#else
				float2 staticSwitch167 = appendResult165;
			#endif
			float2 appendResult166 = (float2(break163.z , break163.y));
			#ifdef _ZYUV_ON
				float2 staticSwitch168 = appendResult166;
			#else
				float2 staticSwitch168 = staticSwitch167;
			#endif
			float2 ParticlePositionUV106 = staticSwitch168;
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
			float4 appendResult216 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			float temp_output_218_0 = distance( appendResult216 , float4( _AudioPosition2 , 0.0 ) );
			float clampResult223 = clamp( (0.0 + (( -temp_output_218_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
			float clampResult231 = clamp( ( pow( clampResult223 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch235 = clampResult231;
			#else
				float staticSwitch235 = 1.0;
			#endif
			float2 appendResult232 = (float2(( temp_output_218_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
			float clampResult238 = clamp( ( staticSwitch235 * tex2Dlod( _AudioSpectrum, float4( appendResult232, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch240 = clampResult238;
			#else
				float staticSwitch240 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch240 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float4 appendResult170 = (float4(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w , 0.0));
			float4 normalizeResult171 = normalize( appendResult170 );
			#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch204 = 1.0;
			#else
				float staticSwitch204 = 0.0;
			#endif
			float clampResult207 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch235 ) , 0.0 , 1.0 );
			v.vertex.xyz += ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch204 * clampResult207 ) + 1.0 ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * _ColorTint ).rgb;
			float4 appendResult17 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float4 ParticleCenterCE186 = ( appendResult17 * float4( staticSwitch93 , 0.0 ) );
			float4 AffectorsCE186 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix186 = staticSwitch93;
			float localCE1186 = CE1186( ParticleCenterCE186 , AffectorsCE186 , Fix186 );
			float DistanceMask45 = localCE1186;
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float4 break163 = appendResult17;
			float2 appendResult165 = (float2(break163.x , break163.z));
			float2 appendResult164 = (float2(break163.x , break163.y));
			#ifdef _XYUV_ON
				float2 staticSwitch167 = appendResult164;
			#else
				float2 staticSwitch167 = appendResult165;
			#endif
			float2 appendResult166 = (float2(break163.z , break163.y));
			#ifdef _ZYUV_ON
				float2 staticSwitch168 = appendResult166;
			#else
				float2 staticSwitch168 = staticSwitch167;
			#endif
			float2 ParticlePositionUV106 = staticSwitch168;
			float2 temp_output_119_0 = ( ParticlePositionUV106 * _NoiseTiling );
			float2 panner109 = ( ( _Time.y * _Noise02ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 panner131 = ( ( _Time.y * _NoiseDistortionScrollSpeed ) * float2( 0.05,0.05 ) + temp_output_119_0);
			float4 tex2DNode132 = tex2D( _NoiseDistortion, panner131 );
			float2 temp_cast_3 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_3 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_4 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_4 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2D( _Noise02, lerpResult127 ).r * tex2D( _Noise01, lerpResult128 ).r * _NoisePower );
			float4 appendResult216 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float temp_output_218_0 = distance( appendResult216 , float4( _AudioPosition2 , 0.0 ) );
			float clampResult223 = clamp( (0.0 + (( -temp_output_218_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
			float clampResult231 = clamp( ( pow( clampResult223 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch235 = clampResult231;
			#else
				float staticSwitch235 = 1.0;
			#endif
			float2 appendResult232 = (float2(( temp_output_218_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
			float clampResult238 = clamp( ( staticSwitch235 * tex2D( _AudioSpectrum, appendResult232 ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch240 = clampResult238;
			#else
				float staticSwitch240 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch240 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
			float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
			#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
			#else
				float4 staticSwitch81 = lerpResult37;
			#endif
			float2 uv_FinalTexture = i.uv_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
			#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch204 = 1.0;
			#else
				float staticSwitch204 = 0.0;
			#endif
			float clampResult207 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch235 ) , 0.0 , 1.0 );
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower2 * staticSwitch204 * clampResult207 ) ) ).rgb;
			float4 tex2DNode136 = tex2D( _MetallicSmoothness, lerp(i.uv_texcoord,( ( i.uv_texcoord + ( i.vertexColor.a * float2( 7,9 ) ) ) * (0.5 + (i.vertexColor.a - 0.0) * (1.0 - 0.5) / (1.0 - 0.0)) ),_MetallicSmoothnessRandomOffset) );
			o.Metallic = ( tex2DNode136.r * _Metallic );
			o.Smoothness = ( tex2DNode136.a * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17104
7;29;1906;1004;5851.017;-353.1202;1;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;173;-3633.083,-1261.739;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;174;-3631.083,-1071.739;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2987.389,-1125.477;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-2776.5,-1316.361;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TexCoordVertexDataNode;214;-6857.232,581.6985;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;215;-6845.799,768.9456;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;97;-3274.945,-713.9004;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;164;-2496.353,-1417.59;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;96;-3280.945,-863.9004;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;216;-6510.28,698.0558;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;217;-6547.724,917.4969;Inherit;False;Global;_AudioPosition2;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;165;-2498.185,-1310.03;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;166;-2486.539,-1537.903;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;93;-3043.945,-791.9004;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;19;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GlobalArrayNode;188;-3039.508,-925.8003;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DistanceOpNode;218;-6229.915,812.6298;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;167;-2253.321,-1448.433;Float;False;Property;_XYUV;XY UV;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2739.945,-969.9004;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;168;-2005.073,-1527.534;Float;False;Property;_ZYUV;ZY UV;30;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;220;-5756.409,1351.571;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;-5843.019,1034.608;Float;False;Property;_AudioSpectrumDistanceTiling2;Audio Spectrum Distance Tiling;33;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1809.465,-1528.039;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;221;-5599.408,1413.571;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;186;-2472.816,-1038.827;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w] * Fix)@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w] * Fix) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;3;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;True;Fix;FLOAT3;0,0,0;In;;Float;False;CE1;True;False;0;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;28;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2215.307,-1034.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-4518.829,-126.7041;Float;False;Property;_Distance;Distance;16;0;Create;True;0;0;False;0;1;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;222;-5449.408,1416.571;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;25;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-4518.273,-23.91216;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-4328.163,-84.30545;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;22;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-4581.318,-221.8393;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;23;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-5419.088,1603.64;Float;False;Property;_AudioMaskExp2;Audio Mask Exp;35;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-5723.225,955.9578;Float;False;Constant;_Float7;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;223;-5268.41,1418.571;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;227;-5061.44,1454.049;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-4100.362,-202.927;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-4080.063,-152.2209;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-5190.747,1699.569;Float;False;Property;_AudioMaskMultiply2;Audio Mask Multiply;36;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;228;-5543.225,982.9582;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-3821.008,-237.7285;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;24;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;26;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;-4811.146,1570.868;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;230;-5363.479,795.4673;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-3838.716,-66.67087;Float;False;Property;_DistancePower;Distance Power;17;0;Create;True;0;0;False;0;1;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-3636.826,-237.141;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;232;-5199.221,793.9928;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;231;-4669.337,1568.148;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-5064.524,1306.657;Float;False;Constant;_Float10;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;27;0;Create;True;0;0;False;0;4;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;21;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;234;-5048.107,767.5807;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;38;1;[HideInInspector];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;20;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;236;-5027.377,968.9838;Inherit;False;Property;_AudioSpectrumPower2;Audio Spectrum Power;32;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;235;-4844.02,1324.756;Float;False;Property;_AudioMaskEnabled2;Audio Mask Enabled;34;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-3401.716,-156.6711;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-4695.227,713.9579;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-3212.344,-163.2406;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;238;-4428.57,796.8902;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-4254.515,223.9331;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;13;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-4181.565,141.7564;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1295.742,-2496.78;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;239;-4200.282,777.5972;Float;False;Constant;_Float4;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-3947.514,173.9331;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-4023.283,499.225;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;240;-4027.285,797.5972;Float;False;Property;_AudioSpectrumEnabled2;Audio Spectrum Enabled;31;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-3705.443,318.7731;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;198;-2238.182,730.5488;Inherit;False;Property;_AudioMaskAffectsAmplitude2;Audio Mask Affects Amplitude;37;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;154;-1306.386,-1171.877;Float;False;Constant;_Vector3;Vector 3;25;0;Create;True;0;0;False;0;7,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.VertexColorNode;141;-1326.989,-1341.416;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;88;-3473.339,164.1025;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-989.4111,-1220.116;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;139;-1079.168,-1360.118;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-3306.71,163.6234;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;199;-1870.182,794.5486;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;202;-1678.182,874.5486;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1107.518,-221.6646;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-2096.745,293.7665;Inherit;False;Constant;_Float8;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-2097.745,368.7666;Inherit;False;Constant;_Float9;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;147;-1011.197,-1098.789;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-735.6873,-1281.52;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1216.461,-310.9464;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1237.551,-390.96;Float;False;Property;_FinalExp;Final Exp;12;0;Create;True;0;0;False;0;2;3;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;144;-786.7141,-437.1918;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;152;-602.516,-1133.348;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;14;-852.0337,-609.2119;Float;False;Property;_FinalColor;Final Color;9;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;205;-1566.746,240.7666;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-528.9289,-1245.926;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;36;-857.7367,-795.7299;Float;False;Property;_FinalColor2;Final Color 2;10;0;Create;True;0;0;False;0;0,0,0,0;0,0.2980392,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;169;-289.5244,1010.291;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;204;-1905.746,320.7665;Inherit;False;Property;_AudioAmplitudeEnabled2;Audio Amplitude Enabled;39;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;206;-1569.746,432.7667;Float;False;Property;_AudioAmplitudeOffsetPower2;Audio Amplitude Offset Power;41;0;Create;True;0;0;False;0;1;0.5;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;-1569.746,336.7665;Float;False;Property;_AudioAmplitudeEmissionPower2;Audio Amplitude Emission Power;40;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-775.4625,-268.4824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;207;-1534.182,874.5486;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;-1233.746,288.7667;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-525.8644,-711.061;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-1249.746,144.7669;Float;False;Constant;_Float3;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;-1233.746,416.7668;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;208;-1233.746,560.7671;Float;False;Constant;_Float6;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;-255.6098,-1199.933;Float;False;Property;_MetallicSmoothnessRandomOffset;MetallicSmoothness Random Offset;6;0;Create;True;0;0;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-186.2826,848.3732;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-418.8253,-386.8104;Inherit;True;Property;_Ramp;Ramp;15;0;Create;True;0;0;False;0;-1;None;fbc555471cbbc744bb52071f7650bbd9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;170;-62.02932,1054.958;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;89;71.87525,852.5294;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;171;80.87824,1054.788;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;43;58.75196,944.4835;Float;False;Property;_OffsetPower;Offset Power;18;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;172;-40.35896,-54.8124;Inherit;True;Property;_FinalTexture;Final Texture;8;0;Create;True;0;0;False;0;-1;None;5fd01f38901ae994fbbb2e5e66db1de0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;136;254.3383,-829.4268;Inherit;True;Property;_MetallicSmoothness;MetallicSmoothness;3;0;Create;True;0;0;False;0;-1;None;716d7ba1113de9c47830d83623210506;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;52;88.43221,-319.6041;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-24.1093,-146.4627;Float;False;Property;_FinalPower;Final Power;11;0;Create;True;0;0;False;0;6;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;213;-1025.745,192.7669;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;212;-1009.745,448.7668;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;464.13,-558.3915;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;48.67471,-438.2115;Float;False;Property;_RampEnabled;Ramp Enabled;14;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;159;486.5865,-635.9687;Float;False;Property;_Metallic;Metallic;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;156;415.4019,-1202.201;Float;False;Property;_ColorTint;Color Tint;2;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;135;237.3863,-1397.21;Inherit;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;False;0;-1;None;d517ad3e48ab0924eb8f1c4a6f7308ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;187;-2990.419,-672.4954;Float;False;Property;_AffectorCount;Affector Count;0;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;397.3997,910.1178;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;196;31.67432,1287.178;Float;False;Global;_OffsetVector;_OffsetVector;30;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;723.4019,-1287.201;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-3345.552,-1041.854;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3348.996,-1266.742;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;138;327.8085,-1023.09;Inherit;True;Property;_Normal;Normal;7;0;Create;True;0;0;False;0;-1;None;b6c0ff317b9dc454b834376f013eb695;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;460.6085,-334.5538;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;707.0691,-770.708;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;715.2351,-639.0311;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;197;1646.991,-793.9543;Float;False;True;2;ASEMaterialInspector;0;0;Standard;SineVFX/LivingParticles/LivingParticleFloorPbrArray;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;173;3
WireConnection;17;1;173;4
WireConnection;17;2;174;1
WireConnection;163;0;17;0
WireConnection;164;0;163;0
WireConnection;164;1;163;1
WireConnection;216;0;214;3
WireConnection;216;1;214;4
WireConnection;216;2;215;1
WireConnection;165;0;163;0
WireConnection;165;1;163;2
WireConnection;166;0;163;2
WireConnection;166;1;163;1
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;218;0;216;0
WireConnection;218;1;217;0
WireConnection;167;1;165;0
WireConnection;167;0;164;0
WireConnection;95;0;188;0
WireConnection;95;1;93;0
WireConnection;168;1;167;0
WireConnection;168;0;166;0
WireConnection;94;0;17;0
WireConnection;94;1;93;0
WireConnection;220;0;218;0
WireConnection;106;0;168;0
WireConnection;221;0;220;0
WireConnection;221;1;219;0
WireConnection;186;0;94;0
WireConnection;186;1;95;0
WireConnection;186;2;93;0
WireConnection;45;0;186;0
WireConnection;222;0;221;0
WireConnection;222;2;219;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;223;0;222;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;227;0;223;0
WireConnection;227;1;224;0
WireConnection;31;0;25;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;228;0;225;0
WireConnection;228;1;219;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;132;1;131;0
WireConnection;229;0;227;0
WireConnection;229;1;226;0
WireConnection;230;0;218;0
WireConnection;230;1;228;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;23;0;28;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;232;0;230;0
WireConnection;231;0;229;0
WireConnection;99;1;127;0
WireConnection;234;1;232;0
WireConnection;98;1;128;0
WireConnection;235;1;233;0
WireConnection;235;0;231;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;237;0;235;0
WireConnection;237;1;234;1
WireConnection;237;2;236;0
WireConnection;53;0;33;0
WireConnection;238;0;237;0
WireConnection;111;0;105;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;240;1;239;0
WireConnection;240;0;238;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;240;0
WireConnection;88;0;117;0
WireConnection;145;0;141;4
WireConnection;145;1;154;0
WireConnection;90;0;88;0
WireConnection;199;0;198;0
WireConnection;202;0;199;0
WireConnection;202;1;235;0
WireConnection;147;0;141;4
WireConnection;140;0;139;0
WireConnection;140;1;145;0
WireConnection;144;0;91;0
WireConnection;144;1;143;0
WireConnection;148;0;140;0
WireConnection;148;1;147;0
WireConnection;204;1;201;0
WireConnection;204;0;200;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;207;0;202;0
WireConnection;209;0;205;0
WireConnection;209;1;203;0
WireConnection;209;2;204;0
WireConnection;209;3;207;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;144;0
WireConnection;211;0;205;0
WireConnection;211;1;206;0
WireConnection;211;2;204;0
WireConnection;211;3;207;0
WireConnection;153;0;152;0
WireConnection;153;1;148;0
WireConnection;82;1;83;0
WireConnection;170;0;169;2
WireConnection;170;1;169;3
WireConnection;170;2;169;4
WireConnection;89;0;92;0
WireConnection;171;0;170;0
WireConnection;136;1;153;0
WireConnection;213;0;210;0
WireConnection;213;1;209;0
WireConnection;212;0;211;0
WireConnection;212;1;208;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;171;0
WireConnection;42;3;212;0
WireConnection;155;0;135;0
WireConnection;155;1;156;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;172;1
WireConnection;3;4;213;0
WireConnection;157;0;136;1
WireConnection;157;1;159;0
WireConnection;158;0;136;4
WireConnection;158;1;160;0
WireConnection;197;0;155;0
WireConnection;197;1;138;0
WireConnection;197;2;3;0
WireConnection;197;3;157;0
WireConnection;197;4;158;0
WireConnection;197;11;42;0
ASEEND*/
//CHKSM=76FBCB51A75E1BD78FB31D039FD404595E3D0C2B