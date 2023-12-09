// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/GPU/LivingParticleFloorPbrArrayGPU"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MetallicSmoothness("MetallicSmoothness", 2D) = "white" {}
		_Metallic("Metallic", Float) = 1
		_AffectorCount("Affector Count", Float) = 5
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
		[Toggle(_AUDIOSPECTRUMENABLED3_ON)] _AudioSpectrumEnabled3("Audio Spectrum Enabled", Float) = 0
		[HideInInspector]_AudioSpectrum("Audio Spectrum", 2D) = "white" {}
		_AudioSpectrumPower3("Audio Spectrum Power", Range( 0 , 1)) = 1
		_AudioSpectrumDistanceTiling3("Audio Spectrum Distance Tiling", Float) = 4
		[Toggle(_AUDIOMASKENABLED3_ON)] _AudioMaskEnabled3("Audio Mask Enabled", Float) = 0
		_AudioMaskExp3("Audio Mask Exp", Range( 0.1 , 4)) = 1
		_AudioMaskMultiply3("Audio Mask Multiply", Range( 1 , 4)) = 1
		_AudioMaskAffectsAmplitude4("Audio Mask Affects Amplitude", Range( 0 , 1)) = 0
		[Toggle(_AUDIOAMPLITUDEENABLED4_ON)] _AudioAmplitudeEnabled4("Audio Amplitude Enabled", Float) = 0
		_AudioAmplitudeEmissionPower4("Audio Amplitude Emission Power", Range( 0 , 4)) = 1
		_AudioAmplitudeOffsetPower4("Audio Amplitude Offset Power", Range( 0 , 4)) = 1
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
		#pragma shader_feature _AUDIOSPECTRUMENABLED3_ON
		#pragma shader_feature _AUDIOMASKENABLED3_ON
		#pragma shader_feature _AUDIOAMPLITUDEENABLED4_ON
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
		uniform float3 _AudioPosition3;
		uniform float _AudioSpectrumDistanceTiling3;
		uniform float _AudioMaskExp3;
		uniform float _AudioMaskMultiply3;
		uniform sampler2D _AudioSpectrum;
		uniform float _AudioSpectrumPower3;
		uniform float _OffsetPower;
		uniform float _AudioAverageAmplitude;
		uniform float _AudioAmplitudeOffsetPower4;
		uniform float _AudioMaskAffectsAmplitude4;
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
		uniform float _AudioAmplitudeEmissionPower4;
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


		float CE1196( float4 ParticleCenterCE , float4 AffectorsCE , float3 Fix )
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
			float4 ParticleCenterCE196 = float4( ( localGetGPUCenter194 * staticSwitch93 ) , 0.0 );
			float4 AffectorsCE196 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix196 = staticSwitch93;
			float localCE1196 = CE1196( ParticleCenterCE196 , AffectorsCE196 , Fix196 );
			float DistanceMask45 = localCE1196;
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
			float temp_output_216_0 = distance( localGetGPUCenter194 , _AudioPosition3 );
			float clampResult223 = clamp( (0.0 + (( -temp_output_216_0 + _AudioSpectrumDistanceTiling3 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling3 - 0.0)) , 0.0 , 1.0 );
			float clampResult230 = clamp( ( pow( clampResult223 , _AudioMaskExp3 ) * _AudioMaskMultiply3 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED3_ON
				float staticSwitch232 = clampResult230;
			#else
				float staticSwitch232 = 1.0;
			#endif
			float2 appendResult231 = (float2(( temp_output_216_0 * ( 1.0 / _AudioSpectrumDistanceTiling3 ) ) , 0.0));
			float clampResult237 = clamp( ( staticSwitch232 * tex2Dlod( _AudioSpectrum, float4( appendResult231, 0, 0.0) ).r * _AudioSpectrumPower3 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED3_ON
				float staticSwitch238 = clampResult237;
			#else
				float staticSwitch238 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch238 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float3 appendResult170 = (float3(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w));
			float3 RegularCustom1195 = appendResult170;
			float3 localGetGPUCustom1195 = GetGPUCustom1195( RegularCustom1195 );
			float3 normalizeResult171 = normalize( localGetGPUCustom1195 );
			#ifdef _AUDIOAMPLITUDEENABLED4_ON
				float staticSwitch206 = 1.0;
			#else
				float staticSwitch206 = 0.0;
			#endif
			float clampResult208 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude4 ) + staticSwitch232 ) , 0.0 , 1.0 );
			v.vertex.xyz += ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower4 * staticSwitch206 * clampResult208 ) + 1.0 ) );
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
			float4 ParticleCenterCE196 = float4( ( localGetGPUCenter194 * staticSwitch93 ) , 0.0 );
			float4 AffectorsCE196 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix196 = staticSwitch93;
			float localCE1196 = CE1196( ParticleCenterCE196 , AffectorsCE196 , Fix196 );
			float DistanceMask45 = localCE1196;
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
			float temp_output_216_0 = distance( localGetGPUCenter194 , _AudioPosition3 );
			float clampResult223 = clamp( (0.0 + (( -temp_output_216_0 + _AudioSpectrumDistanceTiling3 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling3 - 0.0)) , 0.0 , 1.0 );
			float clampResult230 = clamp( ( pow( clampResult223 , _AudioMaskExp3 ) * _AudioMaskMultiply3 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED3_ON
				float staticSwitch232 = clampResult230;
			#else
				float staticSwitch232 = 1.0;
			#endif
			float2 appendResult231 = (float2(( temp_output_216_0 * ( 1.0 / _AudioSpectrumDistanceTiling3 ) ) , 0.0));
			float clampResult237 = clamp( ( staticSwitch232 * tex2D( _AudioSpectrum, appendResult231 ).r * _AudioSpectrumPower3 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED3_ON
				float staticSwitch238 = clampResult237;
			#else
				float staticSwitch238 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch238 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
			float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
			#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
			#else
				float4 staticSwitch81 = lerpResult37;
			#endif
			float2 uv_FinalTexture = i.uv_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
			#ifdef _AUDIOAMPLITUDEENABLED4_ON
				float staticSwitch206 = 1.0;
			#else
				float staticSwitch206 = 0.0;
			#endif
			float clampResult208 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude4 ) + staticSwitch232 ) , 0.0 , 1.0 );
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower4 * staticSwitch206 * clampResult208 ) ) ).rgb;
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
7;29;1906;1004;4629.411;88.69653;1;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;174;-3634.492,-1173.589;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;173;-3636.484,-1349.591;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-3305.79,-1230.329;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;194;-3158.695,-1219.326;Float;False;float3 outCenter = RegularCenter@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCenter = data.center@$#endif$return outCenter@;3;False;1;True;RegularCenter;FLOAT3;0,0,0;In;;Float;False;GetGPUCenter;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-2776.5,-1316.361;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;164;-2496.353,-1417.59;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;215;-5688.633,566.5491;Inherit;False;Global;_AudioPosition3;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;165;-2498.185,-1310.03;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;96;-3280.945,-863.9004;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;97;-3274.945,-713.9004;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;167;-2253.321,-1448.433;Float;False;Property;_XYUV;XY UV;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;216;-5370.826,461.682;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;197;-3029.31,-923.2728;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;93;-3043.945,-791.9004;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;19;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;166;-2486.539,-1537.903;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;217;-4983.925,683.6601;Float;False;Property;_AudioSpectrumDistanceTiling3;Audio Spectrum Distance Tiling;34;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;218;-4897.317,1000.622;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;168;-2005.073,-1527.534;Float;False;Property;_ZYUV;ZY UV;30;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2739.945,-969.9004;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;219;-4740.315,1062.622;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1809.465,-1528.039;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;196;-2466.385,-1022.692;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w] * Fix)@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w] * Fix) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;3;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;True;Fix;FLOAT3;0,0,0;In;;Float;False;CE1;True;False;0;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;220;-4590.315,1065.622;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;28;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;25;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3323.018,-279.5234;Float;False;Property;_Distance;Distance;16;0;Create;True;0;0;False;0;1;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3322.463,-176.7314;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2107.307,-1043.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;223;-4409.315,1067.622;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;222;-4559.995,1252.691;Float;False;Property;_AudioMaskExp3;Audio Mask Exp;36;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-4864.132,605.0102;Float;False;Constant;_Float9;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;23;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;22;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3132.352,-237.1247;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3385.508,-374.6587;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-4331.652,1348.62;Float;False;Property;_AudioMaskMultiply3;Audio Mask Multiply;37;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;226;-4202.345,1103.1;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;225;-4684.131,632.0102;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2904.552,-355.7464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2884.253,-305.0402;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;24;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;227;-3952.051,1219.919;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;228;-4504.385,444.5195;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;26;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2625.198,-390.5479;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;231;-4340.125,443.045;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;230;-3810.24,1217.199;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;229;-4205.429,955.7079;Float;False;Constant;_Float12;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2642.906,-219.4901;Float;False;Property;_DistancePower;Distance Power;17;0;Create;True;0;0;False;0;1;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2441.016,-389.9604;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;27;0;Create;True;0;0;False;0;4;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;232;-3984.923,973.8069;Float;False;Property;_AudioMaskEnabled3;Audio Mask Enabled;35;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-4168.281,618.0351;Inherit;False;Property;_AudioSpectrumPower3;Audio Spectrum Power;33;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;234;-4189.012,416.6331;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;32;1;[HideInInspector];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;20;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;33;-2205.906,-309.4904;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;21;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2016.534,-316.0599;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-3836.129,363.0102;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1295.742,-2496.78;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1977.149,-64.54962;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2050.098,17.62714;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;13;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;236;-3341.185,426.6494;Float;False;Constant;_Float7;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;237;-3569.472,445.9423;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;238;-3168.186,446.6494;Float;False;Property;_AudioSpectrumEnabled3;Audio Spectrum Enabled;31;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-1743.097,-32.37284;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-1818.867,292.9186;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-1501.026,112.467;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-1268.922,-42.20346;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;141;-1326.989,-1341.416;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;154;-1306.386,-1171.877;Float;False;Constant;_Vector3;Vector 3;25;0;Create;True;0;0;False;0;7,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;199;-2121.974,1664.963;Inherit;False;Property;_AudioMaskAffectsAmplitude4;Audio Mask Affects Amplitude;38;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;200;-1759.185,1722.644;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-989.4111,-1220.116;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1102.293,-42.68261;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;139;-1079.168,-1360.118;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;147;-1011.197,-1098.789;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;169;-1012.573,568.7555;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;203;-1560.416,1804.755;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1237.551,-390.96;Float;False;Property;_FinalExp;Final Exp;12;0;Create;True;0;0;False;0;2;3;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-2121.705,1262.508;Inherit;False;Constant;_Float10;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1216.461,-310.9464;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-735.6873,-1281.52;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-2122.705,1335.508;Inherit;False;Constant;_Float11;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1107.518,-221.6646;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-528.9289,-1245.926;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;170;-785.0777,613.4231;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;36;-857.7367,-795.7299;Float;False;Property;_FinalColor2;Final Color 2;10;0;Create;True;0;0;False;0;0,0,0,0;0,0.2980392,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;83;-775.4625,-268.4824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;152;-602.516,-1133.348;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;144;-786.7141,-437.1918;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;205;-1599.592,1397.346;Float;False;Property;_AudioAmplitudeOffsetPower4;Audio Amplitude Offset Power;41;0;Create;True;0;0;False;0;1;0.5;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;208;-1426.185,1809.644;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;206;-1941.768,1277.691;Inherit;False;Property;_AudioAmplitudeEnabled4;Audio Amplitude Enabled;39;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-852.0337,-609.2119;Float;False;Property;_FinalColor;Final Color;9;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;204;-1605.265,1296.785;Float;False;Property;_AudioAmplitudeEmissionPower4;Audio Amplitude Emission Power;40;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;-1585.294,1202.728;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;-255.6098,-1199.933;Float;False;Property;_MetallicSmoothnessRandomOffset;MetallicSmoothness Random Offset;6;0;Create;True;0;0;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;37;-525.8644,-711.061;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-568.3311,412.8376;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;-1263.489,1380.768;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-418.8253,-386.8104;Inherit;True;Property;_Ramp;Ramp;15;0;Create;True;0;0;False;0;-1;None;fbc555471cbbc744bb52071f7650bbd9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;-1265.263,1240.785;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;212;-1290.382,1103.519;Float;False;Constant;_Float6;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;195;-595.5874,737.0504;Float;False;float3 outCustom1 = RegularCustom1@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCustom1 = data.custom1@$#endif$return outCustom1@;3;False;1;True;RegularCustom1;FLOAT3;0,0,0;In;;Float;False;GetGPUCustom1;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-1266.499,1524.561;Float;False;Constant;_Float8;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;172;-40.35896,-54.8124;Inherit;True;Property;_FinalTexture;Final Texture;8;0;Create;True;0;0;False;0;-1;None;5fd01f38901ae994fbbb2e5e66db1de0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;89;-310.173,416.9937;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;156;415.4019,-1202.201;Float;False;Property;_ColorTint;Color Tint;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-323.2963,508.9478;Float;False;Property;_OffsetPower;Offset Power;18;0;Create;True;0;0;False;0;0;-4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-24.1093,-146.4627;Float;False;Property;_FinalPower;Final Power;11;0;Create;True;0;0;False;0;6;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;88.43221,-319.6041;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;135;237.3863,-1397.21;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;-1;None;d517ad3e48ab0924eb8f1c4a6f7308ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;160;464.13,-558.3915;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;-1063.381,1145.519;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;213;-1038.027,1414.977;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;48.67471,-438.2115;Float;False;Property;_RampEnabled;Ramp Enabled;14;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;136;254.3383,-829.4268;Inherit;True;Property;_MetallicSmoothness;MetallicSmoothness;2;0;Create;True;0;0;False;0;-1;None;716d7ba1113de9c47830d83623210506;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;171;-301.17,619.2529;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;159;486.5865,-635.9687;Float;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;241;-5986.709,417.9978;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;240;-5651.19,347.1078;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;239;-5998.143,230.7507;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;723.4019,-1287.201;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;707.0691,-770.708;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-4.861089,431.123;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;715.2351,-639.0311;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;138;327.8085,-1023.09;Inherit;True;Property;_Normal;Normal;7;0;Create;True;0;0;False;0;-1;None;b6c0ff317b9dc454b834376f013eb695;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;477.3593,-321.5252;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;198;-2988.13,-686.2715;Float;False;Property;_AffectorCount;Affector Count;4;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;193;-309.1348,782.6574;Float;False;Constant;_Vector0;Vector 0;23;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;192;1646.991,-793.9543;Float;False;True;2;ASEMaterialInspector;0;0;Standard;SineVFX/LivingParticles/GPU/LivingParticleFloorPbrArrayGPU;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;5;Define;UNITY_PARTICLE_INSTANCE_DATA MyParticleInstanceData;False;;Custom;Define;UNITY_PARTICLE_INSTANCE_DATA_NO_ANIM_FRAME;False;;Custom;Include;GPUinclude01.cginc;False;;Custom;Include;UnityStandardParticleInstancing.cginc;False;;Custom;Pragma;instancing_options procedural:vertInstancingSetup;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;173;3
WireConnection;17;1;173;4
WireConnection;17;2;174;1
WireConnection;194;0;17;0
WireConnection;163;0;194;0
WireConnection;164;0;163;0
WireConnection;164;1;163;1
WireConnection;165;0;163;0
WireConnection;165;1;163;2
WireConnection;167;1;165;0
WireConnection;167;0;164;0
WireConnection;216;0;194;0
WireConnection;216;1;215;0
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;166;0;163;2
WireConnection;166;1;163;1
WireConnection;218;0;216;0
WireConnection;94;0;194;0
WireConnection;94;1;93;0
WireConnection;168;1;167;0
WireConnection;168;0;166;0
WireConnection;95;0;197;0
WireConnection;95;1;93;0
WireConnection;219;0;218;0
WireConnection;219;1;217;0
WireConnection;106;0;168;0
WireConnection;196;0;94;0
WireConnection;196;1;95;0
WireConnection;196;2;93;0
WireConnection;220;0;219;0
WireConnection;220;2;217;0
WireConnection;45;0;196;0
WireConnection;223;0;220;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;226;0;223;0
WireConnection;226;1;222;0
WireConnection;225;0;221;0
WireConnection;225;1;217;0
WireConnection;31;0;25;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;132;1;131;0
WireConnection;227;0;226;0
WireConnection;227;1;224;0
WireConnection;228;0;216;0
WireConnection;228;1;225;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;231;0;228;0
WireConnection;230;0;227;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;23;0;28;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;232;1;229;0
WireConnection;232;0;230;0
WireConnection;234;1;231;0
WireConnection;98;1;128;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;99;1;127;0
WireConnection;53;0;33;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;235;0;232;0
WireConnection;235;1;234;1
WireConnection;235;2;233;0
WireConnection;111;0;105;0
WireConnection;237;0;235;0
WireConnection;238;1;236;0
WireConnection;238;0;237;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;238;0
WireConnection;88;0;117;0
WireConnection;200;0;199;0
WireConnection;145;0;141;4
WireConnection;145;1;154;0
WireConnection;90;0;88;0
WireConnection;147;0;141;4
WireConnection;203;0;200;0
WireConnection;203;1;232;0
WireConnection;140;0;139;0
WireConnection;140;1;145;0
WireConnection;148;0;140;0
WireConnection;148;1;147;0
WireConnection;170;0;169;2
WireConnection;170;1;169;3
WireConnection;170;2;169;4
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;144;0;91;0
WireConnection;144;1;143;0
WireConnection;208;0;203;0
WireConnection;206;1;202;0
WireConnection;206;0;201;0
WireConnection;153;0;152;0
WireConnection;153;1;148;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;144;0
WireConnection;209;0;207;0
WireConnection;209;1;205;0
WireConnection;209;2;206;0
WireConnection;209;3;208;0
WireConnection;82;1;83;0
WireConnection;211;0;207;0
WireConnection;211;1;204;0
WireConnection;211;2;206;0
WireConnection;211;3;208;0
WireConnection;195;0;170;0
WireConnection;89;0;92;0
WireConnection;214;0;212;0
WireConnection;214;1;211;0
WireConnection;213;0;209;0
WireConnection;213;1;210;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;136;1;153;0
WireConnection;171;0;195;0
WireConnection;240;0;239;3
WireConnection;240;1;239;4
WireConnection;240;2;241;1
WireConnection;155;0;135;0
WireConnection;155;1;156;0
WireConnection;157;0;136;1
WireConnection;157;1;159;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;171;0
WireConnection;42;3;213;0
WireConnection;158;0;136;4
WireConnection;158;1;160;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;172;1
WireConnection;3;4;214;0
WireConnection;192;0;155;0
WireConnection;192;1;138;0
WireConnection;192;2;3;0
WireConnection;192;3;157;0
WireConnection;192;4;158;0
WireConnection;192;11;42;0
ASEEND*/
//CHKSM=033C8BCB17A1CC00A27D17945232D147542189E9