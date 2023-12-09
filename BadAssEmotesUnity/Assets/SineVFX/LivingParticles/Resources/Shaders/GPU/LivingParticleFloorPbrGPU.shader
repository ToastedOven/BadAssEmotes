// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/GPU/LivingParticleFloorPbrGPU"
{
	Properties
	{
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
		[HideInInspector]_AudioSpectrum("Audio Spectrum", 2D) = "white" {}
		_AudioSpectrumPower2("Audio Spectrum Power", Range( 0 , 1)) = 1
		_AudioSpectrumDistanceTiling2("Audio Spectrum Distance Tiling", Float) = 4
		[Toggle(_AUDIOMASKENABLED2_ON)] _AudioMaskEnabled2("Audio Mask Enabled", Float) = 0
		_AudioMaskExp2("Audio Mask Exp", Range( 0.1 , 4)) = 1
		_AudioMaskMultiply2("Audio Mask Multiply", Range( 1 , 4)) = 1
		_AudioMaskAffectsAmplitude3("Audio Mask Affects Amplitude", Range( 0 , 1)) = 0
		[Toggle(_AUDIOAMPLITUDEENABLED3_ON)] _AudioAmplitudeEnabled3("Audio Amplitude Enabled", Float) = 0
		_AudioAmplitudeEmissionPower3("Audio Amplitude Emission Power", Range( 0 , 4)) = 1
		_AudioAmplitudeOffsetPower3("Audio Amplitude Offset Power", Range( 0 , 4)) = 1
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
		#pragma shader_feature _AUDIOSPECTRUMENABLED2_ON
		#pragma shader_feature _AUDIOMASKENABLED2_ON
		#pragma shader_feature _AUDIOAMPLITUDEENABLED3_ON
		#pragma shader_feature _RAMPENABLED_ON
		#define UNITY_PARTICLE_INSTANCE_DATA MyParticleInstanceData
		#define UNITY_PARTICLE_INSTANCE_DATA_NO_ANIM_FRAME
		#include "GPUinclude01.cginc"
		#include "UnityStandardParticleInstancing.cginc"
		#pragma instancing_options procedural:vertInstancingSetup
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
		uniform float3 _AudioPosition2;
		uniform float _AudioSpectrumDistanceTiling2;
		uniform float _AudioMaskExp2;
		uniform float _AudioMaskMultiply2;
		uniform sampler2D _AudioSpectrum;
		uniform float _AudioSpectrumPower2;
		uniform float _OffsetPower;
		uniform float _AudioAverageAmplitude;
		uniform float _AudioAmplitudeOffsetPower3;
		uniform float _AudioMaskAffectsAmplitude3;
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
		uniform float _AudioAmplitudeEmissionPower3;
		uniform sampler2D _MetallicSmoothness;
		uniform float _MetallicSmoothnessRandomOffset;
		uniform float _Metallic;
		uniform float _Smoothness;


		float3 GetGPUCenter194( float3 RegularCenter )
		{
			float3 outCenter = RegularCenter;
			#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)
			UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID];
			outCenter = data.center;
			#endif
			return outCenter;
		}


		float3 GetGPUCustom1195( float3 RegularCustom1 )
		{
			float3 outCustom1 = RegularCustom1;
			#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)
			UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID];
			outCustom1 = data.custom1;
			#endif
			return outCustom1;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 appendResult17 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			float3 RegularCenter194 = appendResult17.xyz;
			float3 localGetGPUCenter194 = GetGPUCenter194( RegularCenter194 );
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float DistanceMask45 = ( 1.0 - distance( float4( ( localGetGPUCenter194 * staticSwitch93 ) , 0.0 ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float3 break163 = localGetGPUCenter194;
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
			float2 temp_cast_3 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_3 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_4 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_4 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2Dlod( _Noise02, float4( lerpResult127, 0, 0.0) ).r * tex2Dlod( _Noise01, float4( lerpResult128, 0, 0.0) ).r * _NoisePower );
			float temp_output_213_0 = distance( localGetGPUCenter194 , _AudioPosition2 );
			float clampResult218 = clamp( (0.0 + (( -temp_output_213_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
			float clampResult227 = clamp( ( pow( clampResult218 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch230 = clampResult227;
			#else
				float staticSwitch230 = 1.0;
			#endif
			float2 appendResult226 = (float2(( temp_output_213_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
			float clampResult234 = clamp( ( staticSwitch230 * tex2Dlod( _AudioSpectrum, float4( appendResult226, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch235 = clampResult234;
			#else
				float staticSwitch235 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch235 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float3 appendResult170 = (float3(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w));
			float3 RegularCustom1195 = appendResult170;
			float3 localGetGPUCustom1195 = GetGPUCustom1195( RegularCustom1195 );
			float3 normalizeResult171 = normalize( localGetGPUCustom1195 );
			#ifdef _AUDIOAMPLITUDEENABLED3_ON
				float staticSwitch204 = 1.0;
			#else
				float staticSwitch204 = 0.0;
			#endif
			float clampResult203 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude3 ) + staticSwitch230 ) , 0.0 , 1.0 );
			v.vertex.xyz += ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower3 * staticSwitch204 * clampResult203 ) + 1.0 ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * _ColorTint ).rgb;
			float4 appendResult17 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float3 RegularCenter194 = appendResult17.xyz;
			float3 localGetGPUCenter194 = GetGPUCenter194( RegularCenter194 );
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float DistanceMask45 = ( 1.0 - distance( float4( ( localGetGPUCenter194 * staticSwitch93 ) , 0.0 ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float3 break163 = localGetGPUCenter194;
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
			float2 temp_cast_4 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_4 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_5 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_5 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2D( _Noise02, lerpResult127 ).r * tex2D( _Noise01, lerpResult128 ).r * _NoisePower );
			float temp_output_213_0 = distance( localGetGPUCenter194 , _AudioPosition2 );
			float clampResult218 = clamp( (0.0 + (( -temp_output_213_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
			float clampResult227 = clamp( ( pow( clampResult218 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch230 = clampResult227;
			#else
				float staticSwitch230 = 1.0;
			#endif
			float2 appendResult226 = (float2(( temp_output_213_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
			float clampResult234 = clamp( ( staticSwitch230 * tex2D( _AudioSpectrum, appendResult226 ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch235 = clampResult234;
			#else
				float staticSwitch235 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch235 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
			float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
			#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
			#else
				float4 staticSwitch81 = lerpResult37;
			#endif
			float2 uv_FinalTexture = i.uv_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
			#ifdef _AUDIOAMPLITUDEENABLED3_ON
				float staticSwitch204 = 1.0;
			#else
				float staticSwitch204 = 0.0;
			#endif
			float clampResult203 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude3 ) + staticSwitch230 ) , 0.0 , 1.0 );
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower3 * staticSwitch204 * clampResult203 ) ) ).rgb;
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
1;23;1918;1016;7314.246;67.86935;3.360071;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;173;-3636.484,-1349.591;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;174;-3634.492,-1173.589;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-3305.79,-1230.329;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;194;-3158.695,-1219.326;Float;False;float3 outCenter = RegularCenter@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCenter = data.center@$#endif$return outCenter@;3;False;1;True;RegularCenter;FLOAT3;0,0,0;In;;Float;False;GetGPUCenter;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;96;-3280.945,-863.9004;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-2776.5,-1316.361;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector3Node;97;-3274.945,-713.9004;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;93;-3043.945,-791.9004;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;212;-5519.573,784.2932;Inherit;False;Global;_AudioPosition2;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;165;-2498.185,-1310.03;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;164;-2496.353,-1417.59;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;20;-3031.338,-970.8239;Float;False;Global;_Affector;_Affector;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;166;-2486.539,-1537.903;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;213;-5201.766,679.4261;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2739.945,-969.9004;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;167;-2253.321,-1448.433;Float;False;Property;_XYUV;XY UV;28;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-4814.865,901.4042;Float;False;Property;_AudioSpectrumDistanceTiling2;Audio Spectrum Distance Tiling;33;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;214;-4728.257,1218.366;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;168;-2005.073,-1527.534;Float;False;Property;_ZYUV;ZY UV;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;19;-2446.929,-1046.137;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;216;-4571.255,1280.366;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-2283.804,-1040.446;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1809.465,-1528.039;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;217;-4421.255,1283.366;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-3322.463,-176.7314;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3323.018,-279.5234;Float;False;Property;_Distance;Distance;15;0;Create;True;0;0;False;0;1;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2107.307,-1043.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;24;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;27;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;220;-4695.072,822.7543;Float;False;Constant;_Float8;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;-4390.935,1470.435;Float;False;Property;_AudioMaskExp2;Audio Mask Exp;35;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;218;-4240.255,1285.366;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;21;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;22;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3385.508,-374.6587;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3132.352,-237.1247;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2904.552,-355.7464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-4162.592,1566.364;Float;False;Property;_AudioMaskMultiply2;Audio Mask Multiply;36;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;223;-4515.071,849.7543;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;222;-4033.285,1320.844;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2884.253,-305.0402;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;25;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-3782.991,1437.663;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;225;-4335.325,662.2636;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2625.198,-390.5479;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;23;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;228;-4036.369,1173.452;Float;False;Constant;_Float11;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;227;-3641.18,1434.943;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;226;-4171.065,660.7891;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2441.016,-389.9604;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2642.906,-219.4901;Float;False;Property;_DistancePower;Distance Power;16;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;26;0;Create;True;0;0;False;0;4;8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;230;-3815.863,1191.551;Float;False;Property;_AudioMaskEnabled2;Audio Mask Enabled;34;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-3999.221,835.7792;Inherit;False;Property;_AudioSpectrumPower2;Audio Spectrum Power;32;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;229;-4019.952,634.3772;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;31;1;[HideInInspector];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;20;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;19;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;33;-2205.906,-309.4904;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2016.534,-316.0599;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-3667.069,580.7543;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1977.149,-64.54962;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2050.098,17.62714;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;12;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1295.742,-2496.78;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-3172.125,644.3935;Float;False;Constant;_Float6;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;234;-3400.412,663.6864;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;235;-2999.126,664.3935;Float;False;Property;_AudioSpectrumEnabled2;Audio Spectrum Enabled;30;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-1743.097,-32.37284;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-1818.867,292.9186;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-1501.026,112.467;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;141;-1326.989,-1341.416;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;154;-1306.386,-1171.877;Float;False;Constant;_Vector3;Vector 3;25;0;Create;True;0;0;False;0;7,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;88;-1268.922,-42.20346;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;196;-2281.85,1507.525;Inherit;False;Property;_AudioMaskAffectsAmplitude3;Audio Mask Affects Amplitude;37;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;197;-1919.061,1565.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;139;-1079.168,-1360.118;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-989.4111,-1220.116;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1102.293,-42.68261;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;169;-1012.573,568.7555;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-735.6873,-1281.52;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;199;-2282.581,1178.07;Inherit;False;Constant;_Float10;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;198;-2281.581,1105.07;Inherit;False;Constant;_Float9;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;200;-1720.292,1647.317;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1107.518,-221.6646;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;147;-1011.197,-1098.789;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1216.461,-310.9464;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1237.551,-390.96;Float;False;Property;_FinalExp;Final Exp;11;0;Create;True;0;0;False;0;2;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-528.9289,-1245.926;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-775.4625,-268.4824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-1765.141,1139.347;Float;False;Property;_AudioAmplitudeEmissionPower3;Audio Amplitude Emission Power;39;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;144;-786.7141,-437.1918;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;170;-785.0777,613.4231;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;14;-852.0337,-609.2119;Float;False;Property;_FinalColor;Final Color;8;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;152;-602.516,-1133.348;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-857.7367,-795.7299;Float;False;Property;_FinalColor2;Final Color 2;9;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;205;-1759.468,1239.908;Float;False;Property;_AudioAmplitudeOffsetPower3;Audio Amplitude Offset Power;40;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;204;-2101.644,1120.253;Inherit;False;Property;_AudioAmplitudeEnabled3;Audio Amplitude Enabled;38;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-1745.17,1045.29;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;203;-1586.061,1652.206;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;206;-1423.365,1223.33;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;195;-595.5874,737.0504;Float;False;float3 outCustom1 = RegularCustom1@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCustom1 = data.custom1@$#endif$return outCustom1@;3;False;1;True;RegularCustom1;FLOAT3;0,0,0;In;;Float;False;GetGPUCustom1;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;-255.6098,-1199.933;Float;False;Property;_MetallicSmoothnessRandomOffset;MetallicSmoothness Random Offset;5;0;Create;True;0;0;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;82;-418.8253,-386.8104;Inherit;True;Property;_Ramp;Ramp;14;0;Create;True;0;0;False;0;-1;None;a5b2626bdac32b340ad6b7c4a64983bb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;207;-1426.375,1367.123;Float;False;Constant;_Float7;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;208;-1425.139,1083.347;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-568.3311,412.8376;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;209;-1450.258,946.0811;Float;False;Constant;_Float4;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-525.8644,-711.061;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;160;464.13,-558.3915;Float;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;88.43221,-319.6041;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;81;48.67471,-438.2115;Float;False;Property;_RampEnabled;Ramp Enabled;13;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-24.1093,-146.4627;Float;False;Property;_FinalPower;Final Power;10;0;Create;True;0;0;False;0;6;8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;172;-40.35896,-54.8124;Inherit;True;Property;_FinalTexture;Final Texture;7;0;Create;True;0;0;False;0;-1;None;a8b8a3b14f2650542890347948aafe87;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;159;486.5865,-635.9687;Float;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;89;-310.173,416.9937;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;156;415.4019,-1202.201;Float;False;Property;_ColorTint;Color Tint;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-323.2963,508.9478;Float;False;Property;_OffsetPower;Offset Power;17;0;Create;True;0;0;False;0;0;-4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;211;-1197.903,1257.539;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;135;237.3863,-1397.21;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;-1;None;24b902f6d854171469f6accd7b170d76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;210;-1223.257,988.0812;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;171;-301.17,619.2529;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;136;254.3383,-829.4268;Inherit;True;Property;_MetallicSmoothness;MetallicSmoothness;2;0;Create;True;0;0;False;0;-1;None;716d7ba1113de9c47830d83623210506;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;238;-5829.083,448.4948;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;237;-5482.13,564.8519;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;236;-5817.649,635.7419;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-4.861089,431.123;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;193;-309.1348,782.6574;Float;False;Constant;_Vector0;Vector 0;23;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;138;327.8085,-1023.09;Inherit;True;Property;_Normal;Normal;6;0;Create;True;0;0;False;0;-1;None;0a26385ca4d968040beb1fc50726fc92;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;715.2351,-639.0311;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;477.3593,-321.5252;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;707.0691,-770.708;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;723.4019,-1287.201;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;192;1646.991,-793.9543;Float;False;True;2;ASEMaterialInspector;0;0;Standard;SineVFX/LivingParticles/GPU/LivingParticleFloorPbrGPU;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;5;Define;UNITY_PARTICLE_INSTANCE_DATA MyParticleInstanceData;False;;Custom;Define;UNITY_PARTICLE_INSTANCE_DATA_NO_ANIM_FRAME;False;;Custom;Include;GPUinclude01.cginc;False;;Custom;Include;UnityStandardParticleInstancing.cginc;False;;Custom;Pragma;instancing_options procedural:vertInstancingSetup;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;173;3
WireConnection;17;1;173;4
WireConnection;17;2;174;1
WireConnection;194;0;17;0
WireConnection;163;0;194;0
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;165;0;163;0
WireConnection;165;1;163;2
WireConnection;164;0;163;0
WireConnection;164;1;163;1
WireConnection;166;0;163;2
WireConnection;166;1;163;1
WireConnection;213;0;194;0
WireConnection;213;1;212;0
WireConnection;95;0;20;0
WireConnection;95;1;93;0
WireConnection;167;1;165;0
WireConnection;167;0;164;0
WireConnection;94;0;194;0
WireConnection;94;1;93;0
WireConnection;214;0;213;0
WireConnection;168;1;167;0
WireConnection;168;0;166;0
WireConnection;19;0;94;0
WireConnection;19;1;95;0
WireConnection;216;0;214;0
WireConnection;216;1;215;0
WireConnection;22;0;19;0
WireConnection;106;0;168;0
WireConnection;217;0;216;0
WireConnection;217;2;215;0
WireConnection;45;0;22;0
WireConnection;218;0;217;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;31;0;25;0
WireConnection;223;0;220;0
WireConnection;223;1;215;0
WireConnection;222;0;218;0
WireConnection;222;1;219;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;224;0;222;0
WireConnection;224;1;221;0
WireConnection;225;0;213;0
WireConnection;225;1;223;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;132;1;131;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;227;0;224;0
WireConnection;226;0;225;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;23;0;28;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;230;1;228;0
WireConnection;230;0;227;0
WireConnection;229;1;226;0
WireConnection;99;1;127;0
WireConnection;98;1;128;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;53;0;33;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;232;0;230;0
WireConnection;232;1;229;1
WireConnection;232;2;231;0
WireConnection;111;0;105;0
WireConnection;234;0;232;0
WireConnection;235;1;233;0
WireConnection;235;0;234;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;235;0
WireConnection;88;0;117;0
WireConnection;197;0;196;0
WireConnection;145;0;141;4
WireConnection;145;1;154;0
WireConnection;90;0;88;0
WireConnection;140;0;139;0
WireConnection;140;1;145;0
WireConnection;200;0;197;0
WireConnection;200;1;230;0
WireConnection;147;0;141;4
WireConnection;148;0;140;0
WireConnection;148;1;147;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;144;0;91;0
WireConnection;144;1;143;0
WireConnection;170;0;169;2
WireConnection;170;1;169;3
WireConnection;170;2;169;4
WireConnection;204;1;198;0
WireConnection;204;0;199;0
WireConnection;203;0;200;0
WireConnection;206;0;201;0
WireConnection;206;1;205;0
WireConnection;206;2;204;0
WireConnection;206;3;203;0
WireConnection;195;0;170;0
WireConnection;153;0;152;0
WireConnection;153;1;148;0
WireConnection;82;1;83;0
WireConnection;208;0;201;0
WireConnection;208;1;202;0
WireConnection;208;2;204;0
WireConnection;208;3;203;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;144;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;89;0;92;0
WireConnection;211;0;206;0
WireConnection;211;1;207;0
WireConnection;210;0;209;0
WireConnection;210;1;208;0
WireConnection;171;0;195;0
WireConnection;136;1;153;0
WireConnection;237;0;238;3
WireConnection;237;1;238;4
WireConnection;237;2;236;1
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;171;0
WireConnection;42;3;211;0
WireConnection;158;0;136;4
WireConnection;158;1;160;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;172;1
WireConnection;3;4;210;0
WireConnection;157;0;136;1
WireConnection;157;1;159;0
WireConnection;155;0;135;0
WireConnection;155;1;156;0
WireConnection;192;0;155;0
WireConnection;192;1;138;0
WireConnection;192;2;3;0
WireConnection;192;3;157;0
WireConnection;192;4;158;0
WireConnection;192;11;42;0
ASEEND*/
//CHKSM=903423C799F108913E473098370E8854985BECED