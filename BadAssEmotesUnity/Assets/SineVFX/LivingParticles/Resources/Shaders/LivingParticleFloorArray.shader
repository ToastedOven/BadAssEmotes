// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleFloorArray"
{
	Properties
	{
		_FinalTexture("Final Texture", 2D) = "white" {}
		_FinalColor("Final Color", Color) = (1,0,0,1)
		_FinalColor2("Final Color 2", Color) = (0,0,0,0)
		_AffectorCount("Affector Count", Float) = 5
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
		[Toggle(_AUDIOSPECTRUMENABLED1_ON)] _AudioSpectrumEnabled1("Audio Spectrum Enabled", Float) = 0
		[HideInInspector]_AudioSpectrum1("Audio Spectrum", 2D) = "white" {}
		_AudioSpectrumPower1("Audio Spectrum Power", Range( 0 , 1)) = 1
		_AudioSpectrumDistanceTiling1("Audio Spectrum Distance Tiling", Float) = 4
		[Toggle(_AUDIOMASKENABLED1_ON)] _AudioMaskEnabled1("Audio Mask Enabled", Float) = 0
		_AudioMaskExp1("Audio Mask Exp", Range( 0.1 , 4)) = 1
		_AudioMaskMultiply1("Audio Mask Multiply", Range( 1 , 4)) = 1
		_AudioMaskAffectsAmplitude1("Audio Mask Affects Amplitude", Range( 0 , 1)) = 0
		[Toggle(_AUDIOAMPLITUDEENABLED1_ON)] _AudioAmplitudeEnabled1("Audio Amplitude Enabled", Float) = 0
		_AudioAmplitudeEmissionPower1("Audio Amplitude Emission Power", Range( 0 , 4)) = 1
		_AudioAmplitudeOffsetPower1("Audio Amplitude Offset Power", Range( 0 , 4)) = 1
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
		#pragma shader_feature _AUDIOSPECTRUMENABLED1_ON
		#pragma shader_feature _AUDIOMASKENABLED1_ON
		#pragma shader_feature _AUDIOAMPLITUDEENABLED1_ON
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
		uniform float3 _AudioPosition1;
		uniform float _AudioSpectrumDistanceTiling1;
		uniform float _AudioMaskExp1;
		uniform float _AudioMaskMultiply1;
		uniform sampler2D _AudioSpectrum1;
		uniform float _AudioSpectrumPower1;
		uniform float _OffsetPower;
		uniform float _AudioAverageAmplitude;
		uniform float _AudioAmplitudeOffsetPower1;
		uniform float _AudioMaskAffectsAmplitude1;
		uniform float4 _FinalColor2;
		uniform float4 _FinalColor;
		uniform float _FinalExp;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform sampler2D _FinalTexture;
		uniform float4 _FinalTexture_ST;
		uniform float _AudioAmplitudeEmissionPower1;


		float CE1149( float4 ParticleCenterCE , float4 AffectorsCE , float3 Fix )
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
			float4 ParticleCenterCE149 = ( appendResult17 * float4( staticSwitch93 , 0.0 ) );
			float4 AffectorsCE149 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix149 = staticSwitch93;
			float localCE1149 = CE1149( ParticleCenterCE149 , AffectorsCE149 , Fix149 );
			float DistanceMask45 = localCE1149;
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
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
			float4 appendResult182 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			float temp_output_184_0 = distance( appendResult182 , float4( _AudioPosition1 , 0.0 ) );
			float clampResult190 = clamp( (0.0 + (( -temp_output_184_0 + _AudioSpectrumDistanceTiling1 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling1 - 0.0)) , 0.0 , 1.0 );
			float clampResult198 = clamp( ( pow( clampResult190 , _AudioMaskExp1 ) * _AudioMaskMultiply1 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED1_ON
				float staticSwitch201 = clampResult198;
			#else
				float staticSwitch201 = 1.0;
			#endif
			float2 appendResult197 = (float2(( temp_output_184_0 * ( 1.0 / _AudioSpectrumDistanceTiling1 ) ) , 0.0));
			float clampResult205 = clamp( ( staticSwitch201 * tex2Dlod( _AudioSpectrum1, float4( appendResult197, 0, 0.0) ).r * _AudioSpectrumPower1 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED1_ON
				float staticSwitch206 = clampResult205;
			#else
				float staticSwitch206 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch206 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float3 appendResult138 = (float3(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w));
			float3 normalizeResult139 = normalize( appendResult138 );
			#ifdef _AUDIOAMPLITUDEENABLED1_ON
				float staticSwitch171 = 1.0;
			#else
				float staticSwitch171 = 0.0;
			#endif
			float clampResult172 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude1 ) + staticSwitch201 ) , 0.0 , 1.0 );
			v.vertex.xyz += ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult139 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower1 * staticSwitch171 * clampResult172 ) + 1.0 ) );
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
			float4 ParticleCenterCE149 = ( appendResult17 * float4( staticSwitch93 , 0.0 ) );
			float4 AffectorsCE149 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix149 = staticSwitch93;
			float localCE1149 = CE1149( ParticleCenterCE149 , AffectorsCE149 , Fix149 );
			float DistanceMask45 = localCE1149;
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
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
			float4 appendResult182 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float temp_output_184_0 = distance( appendResult182 , float4( _AudioPosition1 , 0.0 ) );
			float clampResult190 = clamp( (0.0 + (( -temp_output_184_0 + _AudioSpectrumDistanceTiling1 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling1 - 0.0)) , 0.0 , 1.0 );
			float clampResult198 = clamp( ( pow( clampResult190 , _AudioMaskExp1 ) * _AudioMaskMultiply1 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED1_ON
				float staticSwitch201 = clampResult198;
			#else
				float staticSwitch201 = 1.0;
			#endif
			float2 appendResult197 = (float2(( temp_output_184_0 * ( 1.0 / _AudioSpectrumDistanceTiling1 ) ) , 0.0));
			float clampResult205 = clamp( ( staticSwitch201 * tex2D( _AudioSpectrum1, appendResult197 ).r * _AudioSpectrumPower1 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED1_ON
				float staticSwitch206 = clampResult205;
			#else
				float staticSwitch206 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch206 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
			float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
			#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
			#else
				float4 staticSwitch81 = lerpResult37;
			#endif
			float2 uv_FinalTexture = i.uv_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
			#ifdef _AUDIOAMPLITUDEENABLED1_ON
				float staticSwitch171 = 1.0;
			#else
				float staticSwitch171 = 0.0;
			#endif
			float clampResult172 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude1 ) + staticSwitch201 ) , 0.0 , 1.0 );
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower1 * staticSwitch171 * clampResult172 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17104
7;29;1906;1004;5868.899;241.5585;3.444136;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;154;-3344.958,-1014.189;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;153;-3339.958,-1293.189;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2987.389,-1125.477;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;102;-2749.313,-1303.455;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TexCoordVertexDataNode;207;-5766.773,1273.835;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;181;-5755.341,1461.082;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;96;-3304.546,-809.4006;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;142;-2469.166,-1404.684;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;97;-3298.546,-659.4002;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;182;-5419.821,1390.192;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;183;-5457.265,1609.633;Inherit;False;Global;_AudioPosition1;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;104;-2470.998,-1297.124;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GlobalArrayNode;150;-3055.731,-873.068;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;93;-3067.546,-737.4005;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;-2459.352,-1524.997;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;184;-5139.458,1504.766;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;140;-2226.134,-1435.527;Float;False;Property;_XYUV;XY UV;23;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;141;-1977.886,-1514.628;Float;False;Property;_ZYUV;ZY UV;22;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-2733.321,-913.8816;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;186;-4752.56,1726.745;Float;False;Property;_AudioSpectrumDistanceTiling1;Audio Spectrum Distance Tiling;27;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;185;-4665.95,2043.707;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;149;-2507.039,-1023.095;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w] * Fix)@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w] * Fix) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;3;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;True;Fix;FLOAT3;0,0,0;In;;Float;False;CE1;True;False;0;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;187;-4508.949,2105.707;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1796.388,-1303.287;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3429.446,384.8477;Float;False;Property;_Distance;Distance;9;0;Create;True;0;0;False;0;1;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;21;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2055.711,-1049.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;188;-4358.949,2108.707;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;18;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3428.891,487.6396;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;15;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;16;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3491.936,289.7124;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-4632.766,1648.094;Float;False;Constant;_Float6;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;190;-4177.951,2110.707;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3238.78,427.2463;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-4328.63,2295.776;Float;False;Property;_AudioMaskExp1;Audio Mask Exp;29;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2990.681,359.3308;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;31;-3010.98,308.6247;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;-4100.29,2391.705;Float;False;Property;_AudioMaskMultiply1;Audio Mask Multiply;30;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;192;-3970.981,2146.185;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;194;-4452.766,1675.094;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;17;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2731.626,273.8232;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;19;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-4273.021,1487.603;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-3720.688,2263.004;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2749.334,444.881;Float;False;Property;_DistancePower;Distance Power;10;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2547.444,274.4107;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;199;-3974.065,1998.793;Float;False;Constant;_Float9;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;197;-4108.762,1486.129;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;198;-3578.878,2260.284;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;14;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;201;-3753.56,2016.892;Float;False;Property;_AudioMaskEnabled1;Audio Mask Enabled;28;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-3936.918,1661.12;Inherit;False;Property;_AudioSpectrumPower1;Audio Spectrum Power;26;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;20;0;Create;True;0;0;False;0;4;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;13;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;202;-3957.648,1459.717;Inherit;True;Property;_AudioSpectrum1;Audio Spectrum;25;1;[HideInInspector];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;33;-2312.334,354.8807;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;203;-3604.766,1406.094;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2122.962,348.3112;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;205;-3338.11,1489.026;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-3005.466,753.4695;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-3109.823,1469.733;Float;False;Constant;_Float3;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-3078.416,835.646;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;6;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1273.442,-2496.126;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-2771.413,785.6462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-2847.183,1110.938;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;206;-2928.6,1489.733;Float;False;Property;_AudioSpectrumEnabled1;Audio Spectrum Enabled;24;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-2532.342,980.4859;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;165;-1722.466,111.7505;Inherit;False;Property;_AudioMaskAffectsAmplitude1;Audio Mask Affects Amplitude;31;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-2297.238,775.8156;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;166;-1359.677,169.4313;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-2130.609,775.3364;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;169;-1160.908,251.5424;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;167;-1722.197,-290.7043;Inherit;False;Constant;_Float7;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-1723.197,-217.7043;Inherit;False;Constant;_Float8;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1132.582,-956.051;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-1155.75,-1041.046;Float;False;Property;_FinalExp;Final Exp;5;0;Create;True;0;0;False;0;2;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1022.638,-873.7692;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-1200.084,-155.8665;Float;False;Property;_AudioAmplitudeOffsetPower1;Audio Amplitude Offset Power;34;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;171;-1542.261,-275.5218;Inherit;False;Property;_AudioAmplitudeEnabled1;Audio Amplitude Enabled;32;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;170;-1205.757,-256.4276;Float;False;Property;_AudioAmplitudeEmissionPower1;Audio Amplitude Emission Power;33;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;172;-1026.677,256.4313;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;174;-1185.786,-350.484;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;-876.8575,-1445.834;Float;False;Property;_FinalColor2;Final Color 2;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;137;-228.6922,186.1153;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;136;-817.7505,-1089.046;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-871.1545,-1259.316;Float;False;Property;_FinalColor;Final Color;1;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;83;-812.5833,-919.587;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-865.7553,-312.4276;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-866.9907,-28.65181;Float;False;Constant;_Float4;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-142.8208,-35.88242;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-437.946,-1036.915;Inherit;True;Property;_Ramp;Ramp;8;0;Create;True;0;0;False;0;-1;None;96f1785558043bf48bacf57b6511b602;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;175;-890.8739,-449.6935;Float;False;Constant;_Float2;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-544.9852,-1361.165;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-863.9807,-172.4443;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;138;-1.196892,230.7829;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;-663.8731,-407.6935;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;139;141.7103,230.6127;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;147;-59.34668,-705.358;Inherit;True;Property;_FinalTexture;Final Texture;0;0;Create;True;0;0;False;0;-1;None;a8b8a3b14f2650542890347948aafe87;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-638.5192,-138.2357;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;102.2141,60.22781;Float;False;Property;_OffsetPower;Offset Power;11;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;29.55398,-1088.316;Float;False;Property;_RampEnabled;Ramp Enabled;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-43.23003,-796.5675;Float;False;Property;_FinalPower;Final Power;4;0;Create;True;0;0;False;0;6;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;69.31149,-969.7088;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;89;115.3373,-31.72628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;-3006.642,-610.7631;Float;False;Property;_AffectorCount;Affector Count;3;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;420.6493,-17.59701;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;441.4877,-984.6585;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;164;993.235,-582.7628;Float;False;True;2;ASEMaterialInspector;0;0;Unlit;SineVFX/LivingParticles/LivingParticleFloorArray;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;153;3
WireConnection;17;1;153;4
WireConnection;17;2;154;1
WireConnection;102;0;17;0
WireConnection;142;0;102;0
WireConnection;142;1;102;1
WireConnection;182;0;207;3
WireConnection;182;1;207;4
WireConnection;182;2;181;1
WireConnection;104;0;102;0
WireConnection;104;1;102;2
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;143;0;102;2
WireConnection;143;1;102;1
WireConnection;184;0;182;0
WireConnection;184;1;183;0
WireConnection;140;1;104;0
WireConnection;140;0;142;0
WireConnection;141;1;140;0
WireConnection;141;0;143;0
WireConnection;94;0;17;0
WireConnection;94;1;93;0
WireConnection;151;0;150;0
WireConnection;151;1;93;0
WireConnection;185;0;184;0
WireConnection;149;0;94;0
WireConnection;149;1;151;0
WireConnection;149;2;93;0
WireConnection;187;0;185;0
WireConnection;187;1;186;0
WireConnection;106;0;141;0
WireConnection;45;0;149;0
WireConnection;188;0;187;0
WireConnection;188;2;186;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;190;0;188;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;31;0;25;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;192;0;190;0
WireConnection;192;1;191;0
WireConnection;194;0;189;0
WireConnection;194;1;186;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;132;1;131;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;196;0;184;0
WireConnection;196;1;194;0
WireConnection;195;0;192;0
WireConnection;195;1;193;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;23;0;28;0
WireConnection;197;0;196;0
WireConnection;198;0;195;0
WireConnection;99;1;127;0
WireConnection;201;1;199;0
WireConnection;201;0;198;0
WireConnection;98;1;128;0
WireConnection;202;1;197;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;203;0;201;0
WireConnection;203;1;202;1
WireConnection;203;2;200;0
WireConnection;53;0;33;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;205;0;203;0
WireConnection;111;0;105;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;206;1;204;0
WireConnection;206;0;205;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;206;0
WireConnection;88;0;117;0
WireConnection;166;0;165;0
WireConnection;90;0;88;0
WireConnection;169;0;166;0
WireConnection;169;1;201;0
WireConnection;171;1;167;0
WireConnection;171;0;168;0
WireConnection;172;0;169;0
WireConnection;136;0;91;0
WireConnection;136;1;135;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;176;0;174;0
WireConnection;176;1;170;0
WireConnection;176;2;171;0
WireConnection;176;3;172;0
WireConnection;82;1;83;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;136;0
WireConnection;177;0;174;0
WireConnection;177;1;173;0
WireConnection;177;2;171;0
WireConnection;177;3;172;0
WireConnection;138;0;137;2
WireConnection;138;1;137;3
WireConnection;138;2;137;4
WireConnection;180;0;175;0
WireConnection;180;1;176;0
WireConnection;139;0;138;0
WireConnection;179;0;177;0
WireConnection;179;1;178;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;89;0;92;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;139;0
WireConnection;42;3;179;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;147;1
WireConnection;3;4;180;0
WireConnection;164;2;3;0
WireConnection;164;11;42;0
ASEEND*/
//CHKSM=0A80E285D94257E39FD5F97CEE387D84B89F9E5F