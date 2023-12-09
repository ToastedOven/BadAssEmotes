// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/GPU/LivingParticleFloorArrayGPU"
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
		uniform float4 _FinalColor2;
		uniform float4 _FinalColor;
		uniform float _FinalExp;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform sampler2D _FinalTexture;
		uniform float4 _FinalTexture_ST;
		uniform float _AudioAmplitudeEmissionPower3;


		float3 GetGPUCenter152( float3 RegularCenter )
		{
			float3 outCenter = RegularCenter;
			#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)
			UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID];
			outCenter = data.center;
			#endif
			return outCenter;
		}


		float CE1154( float4 ParticleCenterCE , float4 AffectorsCE , float3 Fix )
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


		float3 GetGPUCustom1153( float3 RegularCustom1 )
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
			float3 RegularCenter152 = appendResult17.xyz;
			float3 localGetGPUCenter152 = GetGPUCenter152( RegularCenter152 );
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float4 ParticleCenterCE154 = float4( ( localGetGPUCenter152 * staticSwitch93 ) , 0.0 );
			float4 AffectorsCE154 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix154 = staticSwitch93;
			float localCE1154 = CE1154( ParticleCenterCE154 , AffectorsCE154 , Fix154 );
			float DistanceMask45 = localCE1154;
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float3 break102 = localGetGPUCenter152;
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
			float2 temp_cast_3 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_3 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_4 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_4 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2Dlod( _Noise02, float4( lerpResult127, 0, 0.0) ).r * tex2Dlod( _Noise01, float4( lerpResult128, 0, 0.0) ).r * _NoisePower );
			float temp_output_174_0 = distance( localGetGPUCenter152 , _AudioPosition2 );
			float clampResult179 = clamp( (0.0 + (( -temp_output_174_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
			float clampResult188 = clamp( ( pow( clampResult179 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch191 = clampResult188;
			#else
				float staticSwitch191 = 1.0;
			#endif
			float2 appendResult187 = (float2(( temp_output_174_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
			float clampResult195 = clamp( ( staticSwitch191 * tex2Dlod( _AudioSpectrum, float4( appendResult187, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch196 = clampResult195;
			#else
				float staticSwitch196 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch196 ) , 0.0 , 1.0 );
			float ResultMaskModified90 = clampResult88;
			float3 appendResult138 = (float3(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w));
			float3 RegularCustom1153 = appendResult138;
			float3 localGetGPUCustom1153 = GetGPUCustom1153( RegularCustom1153 );
			float3 normalizeResult139 = normalize( localGetGPUCustom1153 );
			#ifdef _AUDIOAMPLITUDEENABLED3_ON
				float staticSwitch166 = 1.0;
			#else
				float staticSwitch166 = 0.0;
			#endif
			float clampResult165 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude3 ) + staticSwitch191 ) , 0.0 , 1.0 );
			v.vertex.xyz += ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult139 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower3 * staticSwitch166 * clampResult165 ) + 1.0 ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 appendResult17 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float3 RegularCenter152 = appendResult17.xyz;
			float3 localGetGPUCenter152 = GetGPUCenter152( RegularCenter152 );
			#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
			#else
				float3 staticSwitch93 = float3(1,1,1);
			#endif
			float4 ParticleCenterCE154 = float4( ( localGetGPUCenter152 * staticSwitch93 ) , 0.0 );
			float4 AffectorsCE154 = ( _Affectors[0] * float4( staticSwitch93 , 0.0 ) );
			float3 Fix154 = staticSwitch93;
			float localCE1154 = CE1154( ParticleCenterCE154 , AffectorsCE154 , Fix154 );
			float DistanceMask45 = localCE1154;
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float3 break102 = localGetGPUCenter152;
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
			float2 temp_cast_3 = (tex2DNode132.r).xx;
			float2 lerpResult127 = lerp( panner109 , temp_cast_3 , _NoiseDistortionPower);
			float2 panner110 = ( ( _Time.y * _Noise01ScrollSpeed ) * float2( 1,1 ) + temp_output_119_0);
			float2 temp_cast_4 = (tex2DNode132.r).xx;
			float2 lerpResult128 = lerp( panner110 , temp_cast_4 , _NoiseDistortionPower);
			float ResultNoise111 = ( tex2D( _Noise02, lerpResult127 ).r * tex2D( _Noise01, lerpResult128 ).r * _NoisePower );
			float temp_output_174_0 = distance( localGetGPUCenter152 , _AudioPosition2 );
			float clampResult179 = clamp( (0.0 + (( -temp_output_174_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
			float clampResult188 = clamp( ( pow( clampResult179 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch191 = clampResult188;
			#else
				float staticSwitch191 = 1.0;
			#endif
			float2 appendResult187 = (float2(( temp_output_174_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
			float clampResult195 = clamp( ( staticSwitch191 * tex2D( _AudioSpectrum, appendResult187 ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
			#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch196 = clampResult195;
			#else
				float staticSwitch196 = 0.0;
			#endif
			float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch196 ) , 0.0 , 1.0 );
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
				float staticSwitch166 = 1.0;
			#else
				float staticSwitch166 = 0.0;
			#endif
			float clampResult165 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude3 ) + staticSwitch191 ) , 0.0 , 1.0 );
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower3 * staticSwitch166 * clampResult165 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17104
7;29;1906;1004;7164.998;917.5051;3.707764;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;149;-3966.907,-1223.587;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;148;-3968.907,-1434.587;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-3631.389,-1294.477;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;152;-3493.959,-1294.543;Float;False;float3 outCenter = RegularCenter@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCenter = data.center@$#endif$return outCenter@;3;False;1;True;RegularCenter;FLOAT3;0,0,0;In;;Float;False;GetGPUCenter;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;102;-2827.324,-1319.458;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;142;-2469.166,-1404.684;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;173;-6092.625,968.5164;Inherit;False;Global;_AudioPosition2;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;104;-2470.998,-1297.124;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;96;-3280.945,-863.9004;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;97;-3274.945,-713.9004;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GlobalArrayNode;155;-3039.623,-1016.513;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DistanceOpNode;174;-5774.817,863.6493;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;140;-2226.134,-1435.527;Float;False;Property;_XYUV;XY UV;23;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;93;-3043.945,-791.9004;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;-2459.352,-1524.997;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;175;-5301.309,1402.589;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;176;-5387.917,1085.627;Float;False;Property;_AudioSpectrumDistanceTiling2;Audio Spectrum Distance Tiling;27;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2747.945,-1123.9;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2739.945,-969.9004;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;141;-1977.886,-1514.628;Float;False;Property;_ZYUV;ZY UV;22;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;177;-5144.307,1464.589;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1796.388,-1303.287;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;154;-2507.931,-1044.54;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w] * Fix)@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w] * Fix) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;3;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;True;Fix;FLOAT3;0,0,0;In;;Float;False;CE1;True;False;0;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;178;-4994.307,1467.589;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2107.307,-1043.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;18;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-3323.018,-279.5234;Float;False;Property;_Distance;Distance;9;0;Create;True;0;0;False;0;1;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3322.463,-176.7314;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;21;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;-5268.124,1006.977;Float;False;Constant;_Float8;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-4963.986,1654.658;Float;False;Property;_AudioMaskExp2;Audio Mask Exp;29;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;179;-4813.307,1469.589;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3132.352,-237.1247;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;15;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;16;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3385.508,-374.6587;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2884.253,-305.0402;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-4735.644,1750.587;Float;False;Property;_AudioMaskMultiply2;Audio Mask Multiply;30;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;184;-5088.123,1033.977;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;183;-4606.336,1505.067;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2904.552,-355.7464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2625.198,-390.5479;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-4356.042,1621.886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;186;-4908.376,846.4868;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;19;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;17;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-4609.42,1357.675;Float;False;Constant;_Float11;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;188;-4214.232,1619.166;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;187;-4744.117,845.0123;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2441.016,-389.9604;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2642.906,-219.4901;Float;False;Property;_DistancePower;Distance Power;10;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;20;0;Create;True;0;0;False;0;4;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;191;-4388.914,1375.774;Float;False;Property;_AudioMaskEnabled2;Audio Mask Enabled;28;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;13;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;33;-2205.906,-309.4904;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;14;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;190;-4593.003,818.6003;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;25;1;[HideInInspector];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;192;-4572.273,1020.002;Inherit;False;Property;_AudioSpectrumPower2;Audio Spectrum Power;26;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-4240.12,764.9775;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2016.534,-316.0599;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1273.442,-2496.126;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2971.988,171.2753;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;6;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-3745.177,828.6166;Float;False;Constant;_Float6;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;195;-3973.464,847.9095;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-2899.038,89.09859;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;196;-3572.178,848.6166;Float;False;Property;_AudioSpectrumEnabled2;Audio Spectrum Enabled;24;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-2740.755,446.5673;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-2664.985,121.2754;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-2425.914,316.1152;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-2190.81,111.4448;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-2028.201,1552.791;Inherit;False;Property;_AudioMaskAffectsAmplitude3;Audio Mask Affects Amplitude;31;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;159;-1665.413,1610.472;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-2024.181,110.9656;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;137;-672.6922,183.1153;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;84;-1022.638,-873.7692;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1132.582,-956.051;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-1155.75,-1041.046;Float;False;Property;_FinalExp;Final Exp;5;0;Create;True;0;0;False;0;2;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;162;-1466.644,1692.583;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-2027.932,1150.337;Inherit;False;Constant;_Float9;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-2028.932,1223.337;Inherit;False;Constant;_Float10;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-871.1545,-1259.316;Float;False;Property;_FinalColor;Final Color;1;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;136;-817.7505,-1089.046;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-812.5833,-919.587;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;36;-876.8575,-1445.834;Float;False;Property;_FinalColor2;Final Color 2;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;138;-445.1969,225.7829;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;166;-1847.996,1165.519;Inherit;False;Property;_AudioAmplitudeEnabled3;Audio Amplitude Enabled;32;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;165;-1332.413,1697.472;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;167;-1505.82,1285.175;Float;False;Property;_AudioAmplitudeOffsetPower3;Audio Amplitude Offset Power;34;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-1491.522,1090.557;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-1511.493,1184.614;Float;False;Property;_AudioAmplitudeEmissionPower3;Audio Amplitude Emission Power;33;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;153;-236.8364,383.7738;Float;False;float3 outCustom1 = RegularCustom1@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCustom1 = data.custom1@$#endif$return outCustom1@;3;False;1;True;RegularCustom1;FLOAT3;0,0,0;In;;Float;False;GetGPUCustom1;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-1196.61,991.3477;Float;False;Constant;_Float4;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-544.9852,-1361.165;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-1172.727,1412.389;Float;False;Constant;_Float7;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-1171.491,1128.614;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-1169.717,1268.597;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-142.8208,-35.88242;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-437.946,-1036.915;Inherit;True;Property;_Ramp;Ramp;8;0;Create;True;0;0;False;0;-1;None;1260249478b816b468c2888f0a40a2e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;89;115.3373,-31.72628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;69.31149,-969.7088;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;147;-59.34668,-705.358;Inherit;True;Property;_FinalTexture;Final Texture;0;0;Create;True;0;0;False;0;-1;None;a0c8393bc92291e438c0a270fbfa611f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;171;-969.6095,1033.348;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;172;-944.2556,1302.805;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;139;141.7103,230.6127;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-43.23003,-796.5675;Float;False;Property;_FinalPower;Final Power;4;0;Create;True;0;0;False;0;6;4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;29.55398,-1088.316;Float;False;Property;_RampEnabled;Ramp Enabled;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;43;102.2141,60.22781;Float;False;Property;_OffsetPower;Offset Power;11;0;Create;True;0;0;False;0;0;-4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;197;-6390.701,819.9651;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;198;-6055.182,749.0751;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;199;-6402.134,632.7181;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;151;142.681,364.9982;Float;False;Constant;_Vector0;Vector 0;23;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;441.4877,-984.6585;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;420.6493,-17.59701;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-2988.497,-678.25;Float;False;Property;_AffectorCount;Affector Count;3;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;150;993.235,-582.7628;Float;False;True;2;ASEMaterialInspector;0;0;Unlit;SineVFX/LivingParticles/GPU/LivingParticleFloorArrayGPU;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;5;Define;UNITY_PARTICLE_INSTANCE_DATA MyParticleInstanceData;False;;Custom;Define;UNITY_PARTICLE_INSTANCE_DATA_NO_ANIM_FRAME;False;;Custom;Include;GPUinclude01.cginc;False;;Custom;Include;UnityStandardParticleInstancing.cginc;False;;Custom;Pragma;instancing_options procedural:vertInstancingSetup;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;148;3
WireConnection;17;1;148;4
WireConnection;17;2;149;1
WireConnection;152;0;17;0
WireConnection;102;0;152;0
WireConnection;142;0;102;0
WireConnection;142;1;102;1
WireConnection;104;0;102;0
WireConnection;104;1;102;2
WireConnection;174;0;152;0
WireConnection;174;1;173;0
WireConnection;140;1;104;0
WireConnection;140;0;142;0
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;143;0;102;2
WireConnection;143;1;102;1
WireConnection;175;0;174;0
WireConnection;94;0;152;0
WireConnection;94;1;93;0
WireConnection;95;0;155;0
WireConnection;95;1;93;0
WireConnection;141;1;140;0
WireConnection;141;0;143;0
WireConnection;177;0;175;0
WireConnection;177;1;176;0
WireConnection;106;0;141;0
WireConnection;154;0;94;0
WireConnection;154;1;95;0
WireConnection;154;2;93;0
WireConnection;178;0;177;0
WireConnection;178;2;176;0
WireConnection;45;0;154;0
WireConnection;179;0;178;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;184;0;181;0
WireConnection;184;1;176;0
WireConnection;183;0;179;0
WireConnection;183;1;180;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;31;0;25;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;185;0;183;0
WireConnection;185;1;182;0
WireConnection;186;0;174;0
WireConnection;186;1;184;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;132;1;131;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;188;0;185;0
WireConnection;187;0;186;0
WireConnection;23;0;28;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;191;1;189;0
WireConnection;191;0;188;0
WireConnection;98;1;128;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;99;1;127;0
WireConnection;190;1;187;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;193;0;191;0
WireConnection;193;1;190;1
WireConnection;193;2;192;0
WireConnection;53;0;33;0
WireConnection;111;0;105;0
WireConnection;195;0;193;0
WireConnection;196;1;194;0
WireConnection;196;0;195;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;196;0
WireConnection;88;0;117;0
WireConnection;159;0;158;0
WireConnection;90;0;88;0
WireConnection;162;0;159;0
WireConnection;162;1;191;0
WireConnection;136;0;91;0
WireConnection;136;1;135;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;138;0;137;2
WireConnection;138;1;137;3
WireConnection;138;2;137;4
WireConnection;166;1;160;0
WireConnection;166;0;161;0
WireConnection;165;0;162;0
WireConnection;153;0;138;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;136;0
WireConnection;170;0;163;0
WireConnection;170;1;164;0
WireConnection;170;2;166;0
WireConnection;170;3;165;0
WireConnection;168;0;163;0
WireConnection;168;1;167;0
WireConnection;168;2;166;0
WireConnection;168;3;165;0
WireConnection;82;1;83;0
WireConnection;89;0;92;0
WireConnection;171;0;157;0
WireConnection;171;1;170;0
WireConnection;172;0;168;0
WireConnection;172;1;169;0
WireConnection;139;0;153;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;198;0;199;3
WireConnection;198;1;199;4
WireConnection;198;2;197;1
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;147;1
WireConnection;3;4;171;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;139;0
WireConnection;42;3;172;0
WireConnection;150;2;3;0
WireConnection;150;11;42;0
ASEEND*/
//CHKSM=FB99D88C31BC3F31FE0B0FD1B1CC5EAE7D076C13