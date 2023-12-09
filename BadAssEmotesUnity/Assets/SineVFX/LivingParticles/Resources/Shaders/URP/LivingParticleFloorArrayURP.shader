// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleFloorArrayURP"
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
		_AudioMaskAffectsAmplitude2("Audio Mask Affects Amplitude", Range( 0 , 1)) = 0
		[Toggle(_AUDIOAMPLITUDEENABLED2_ON)] _AudioAmplitudeEnabled2("Audio Amplitude Enabled", Float) = 0
		_AudioAmplitudeEmissionPower2("Audio Amplitude Emission Power", Range( 0 , 4)) = 1
		_AudioAmplitudeOffsetPower2("Audio Amplitude Offset Power", Range( 0 , 4)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Cull Back
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL

		
		Pass
		{
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero , One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#pragma shader_feature _IGNOREYAXIS_ON
			#pragma shader_feature _ZYUV_ON
			#pragma shader_feature _XYUV_ON
			#pragma shader_feature _AUDIOSPECTRUMENABLED2_ON
			#pragma shader_feature _AUDIOMASKENABLED2_ON
			#pragma shader_feature _AUDIOAMPLITUDEENABLED2_ON
			#pragma shader_feature _RAMPENABLED_ON


			float4 _Affectors[20];
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			sampler2D _Ramp;
			sampler2D _FinalTexture;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _Distance;
			float _DistancePower;
			float _FinalMaskMultiply;
			float _Noise02ScrollSpeed;
			float _NoiseTiling;
			float _NoiseDistortionScrollSpeed;
			float _NoiseDistortionPower;
			float _Noise01ScrollSpeed;
			float _NoisePower;
			float _AudioSpectrumDistanceTiling2;
			float _AudioMaskExp2;
			float _AudioMaskMultiply2;
			float _AudioSpectrumPower2;
			float _OffsetPower;
			float _AudioAmplitudeOffsetPower2;
			float _AudioMaskAffectsAmplitude2;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			CBUFFER_END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

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
			

			VertexOutput vert ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
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
				float4 appendResult174 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float temp_output_176_0 = distance( appendResult174 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult183 = clamp( (0.0 + (( -temp_output_176_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult191 = clamp( ( pow( clampResult183 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch193 = clampResult191;
				#else
				float staticSwitch193 = 1.0;
				#endif
				float2 appendResult190 = (float2(( temp_output_176_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult197 = clamp( ( staticSwitch193 * tex2Dlod( _AudioSpectrum, float4( appendResult190, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch198 = clampResult197;
				#else
				float staticSwitch198 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch198 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float3 appendResult138 = (float3(v.ase_texcoord1.y , v.ase_texcoord1.z , v.ase_texcoord1.w));
				float3 normalizeResult139 = normalize( appendResult138 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch161 = 1.0;
				#else
				float staticSwitch161 = 0.0;
				#endif
				float clampResult163 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch193 ) , 0.0 , 1.0 );
				
				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult139 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch161 * clampResult163 ) + 1.0 ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
				o.clipPos = vertexInput.positionCS;
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( vertexInput.positionCS.z );
				#endif
				return o;
			}

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float4 appendResult17 = (float4(IN.ase_texcoord1.z , IN.ase_texcoord1.w , IN.ase_texcoord2.x , 0.0));
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
				float4 appendResult174 = (float4(IN.ase_texcoord1.z , IN.ase_texcoord1.w , IN.ase_texcoord2.x , 0.0));
				float temp_output_176_0 = distance( appendResult174 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult183 = clamp( (0.0 + (( -temp_output_176_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult191 = clamp( ( pow( clampResult183 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch193 = clampResult191;
				#else
				float staticSwitch193 = 1.0;
				#endif
				float2 appendResult190 = (float2(( temp_output_176_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult197 = clamp( ( staticSwitch193 * tex2D( _AudioSpectrum, appendResult190 ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch198 = clampResult197;
				#else
				float staticSwitch198 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch198 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
				float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float2 uv_FinalTexture = IN.ase_texcoord1.xy * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch161 = 1.0;
				#else
				float staticSwitch161 = 0.0;
				#endif
				float clampResult163 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch193 ) , 0.0 , 1.0 );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( staticSwitch81 * IN.ase_color * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower2 * staticSwitch161 * clampResult163 ) ) ).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#if _AlphaClip
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex ShadowPassVertex
			#pragma fragment ShadowPassFragment


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature _IGNOREYAXIS_ON
			#pragma shader_feature _ZYUV_ON
			#pragma shader_feature _XYUV_ON
			#pragma shader_feature _AUDIOSPECTRUMENABLED2_ON
			#pragma shader_feature _AUDIOMASKENABLED2_ON
			#pragma shader_feature _AUDIOAMPLITUDEENABLED2_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			float4 _Affectors[20];
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _Distance;
			float _DistancePower;
			float _FinalMaskMultiply;
			float _Noise02ScrollSpeed;
			float _NoiseTiling;
			float _NoiseDistortionScrollSpeed;
			float _NoiseDistortionPower;
			float _Noise01ScrollSpeed;
			float _NoisePower;
			float _AudioSpectrumDistanceTiling2;
			float _AudioMaskExp2;
			float _AudioMaskMultiply2;
			float _AudioSpectrumPower2;
			float _OffsetPower;
			float _AudioAmplitudeOffsetPower2;
			float _AudioMaskAffectsAmplitude2;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			CBUFFER_END


			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

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
			

			float3 _LightDirection;

			VertexOutput ShadowPassVertex( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
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
				float4 appendResult174 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float temp_output_176_0 = distance( appendResult174 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult183 = clamp( (0.0 + (( -temp_output_176_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult191 = clamp( ( pow( clampResult183 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch193 = clampResult191;
				#else
				float staticSwitch193 = 1.0;
				#endif
				float2 appendResult190 = (float2(( temp_output_176_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult197 = clamp( ( staticSwitch193 * tex2Dlod( _AudioSpectrum, float4( appendResult190, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch198 = clampResult197;
				#else
				float staticSwitch198 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch198 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float3 appendResult138 = (float3(v.ase_texcoord1.y , v.ase_texcoord1.z , v.ase_texcoord1.w));
				float3 normalizeResult139 = normalize( appendResult138 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch161 = 1.0;
				#else
				float staticSwitch161 = 0.0;
				#endif
				float clampResult163 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch193 ) , 0.0 , 1.0 );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult139 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch161 * clampResult163 ) + 1.0 ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
				float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

				float4 clipPos = TransformWorldToHClip( ApplyShadowBias( positionWS, normalWS, _LightDirection ) );

				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#endif
				o.clipPos = clipPos;

				return o;
			}

			half4 ShadowPassFragment(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature _IGNOREYAXIS_ON
			#pragma shader_feature _ZYUV_ON
			#pragma shader_feature _XYUV_ON
			#pragma shader_feature _AUDIOSPECTRUMENABLED2_ON
			#pragma shader_feature _AUDIOMASKENABLED2_ON
			#pragma shader_feature _AUDIOAMPLITUDEENABLED2_ON


			float4 _Affectors[20];
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _Distance;
			float _DistancePower;
			float _FinalMaskMultiply;
			float _Noise02ScrollSpeed;
			float _NoiseTiling;
			float _NoiseDistortionScrollSpeed;
			float _NoiseDistortionPower;
			float _Noise01ScrollSpeed;
			float _NoisePower;
			float _AudioSpectrumDistanceTiling2;
			float _AudioMaskExp2;
			float _AudioMaskMultiply2;
			float _AudioSpectrumPower2;
			float _OffsetPower;
			float _AudioAmplitudeOffsetPower2;
			float _AudioMaskAffectsAmplitude2;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			CBUFFER_END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

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
			

			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
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
				float4 appendResult174 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float temp_output_176_0 = distance( appendResult174 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult183 = clamp( (0.0 + (( -temp_output_176_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult191 = clamp( ( pow( clampResult183 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch193 = clampResult191;
				#else
				float staticSwitch193 = 1.0;
				#endif
				float2 appendResult190 = (float2(( temp_output_176_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult197 = clamp( ( staticSwitch193 * tex2Dlod( _AudioSpectrum, float4( appendResult190, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch198 = clampResult197;
				#else
				float staticSwitch198 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch198 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float3 appendResult138 = (float3(v.ase_texcoord1.y , v.ase_texcoord1.z , v.ase_texcoord1.w));
				float3 normalizeResult139 = normalize( appendResult138 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch161 = 1.0;
				#else
				float staticSwitch161 = 0.0;
				#endif
				float clampResult163 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch193 ) , 0.0 , 1.0 );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult139 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch161 * clampResult163 ) + 1.0 ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				o.clipPos = TransformObjectToHClip(v.vertex.xyz);
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=17500
1;387;1906;629;5556.149;-1464.434;3.455257;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;153;-3339.958,-1293.189;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;154;-3344.958,-1014.189;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2987.389,-1125.477;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;173;-5429.458,1564.886;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;172;-5452.424,1329.569;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;102;-2749.313,-1303.455;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;104;-2470.998,-1297.124;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;175;-5141.458,1724.886;Inherit;False;Global;_AudioPosition2;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;174;-5093.458,1500.886;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;97;-3298.546,-659.4002;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;96;-3304.546,-809.4006;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;142;-2469.166,-1404.684;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;-2459.352,-1524.997;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GlobalArrayNode;150;-3055.731,-873.068;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;140;-2226.134,-1435.527;Float;False;Property;_XYUV;XY UV;23;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;93;-3067.546,-737.4005;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;176;-4821.458,1612.886;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;141;-1977.886,-1514.628;Float;False;Property;_ZYUV;ZY UV;22;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-2733.321,-913.8816;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;177;-4341.458,2156.886;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4437.458,1836.886;Float;False;Property;_AudioSpectrumDistanceTiling2;Audio Spectrum Distance Tiling;27;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1796.388,-1303.287;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;149;-2507.039,-1023.095;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w] * Fix)@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w] * Fix) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;3;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;True;Fix;FLOAT3;0,0,0;In;;Float;False;CE1;True;False;0;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-4181.457,2220.886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3429.446,384.8477;Float;False;Property;_Distance;Distance;9;0;Create;True;0;0;False;0;1;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;21;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;18;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2055.711,-1049.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;180;-4037.458,2220.886;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3428.891,487.6396;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3491.936,289.7124;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-4309.458,1756.886;Float;False;Constant;_Float7;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;183;-3861.458,2220.886;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;-4005.458,2412.886;Float;False;Property;_AudioMaskExp2;Audio Mask Exp;29;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3238.78,427.2463;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;16;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;15;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;186;-3653.458,2252.886;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-3010.98,308.6247;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;185;-4133.458,1788.886;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-3781.458,2508.886;Float;False;Property;_AudioMaskMultiply2;Audio Mask Multiply;30;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2990.681,359.3308;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;17;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-3957.458,1596.886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;-3397.458,2380.886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;19;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2731.626,273.8232;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-3653.458,2108.886;Float;False;Constant;_Float10;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;190;-3781.458,1596.886;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;191;-3253.458,2364.886;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2547.444,274.4107;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2749.334,444.881;Float;False;Property;_DistancePower;Distance Power;10;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-3621.458,1772.886;Inherit;False;Property;_AudioSpectrumPower2;Audio Spectrum Power;26;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;193;-3429.458,2124.886;Float;False;Property;_AudioMaskEnabled2;Audio Mask Enabled;28;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;192;-3637.458,1564.886;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;25;1;[HideInInspector];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;20;0;Create;True;0;0;False;0;4;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-2312.334,354.8807;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;13;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;14;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-3285.458,1516.886;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2122.962,348.3112;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-3005.466,753.4695;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1273.442,-2496.126;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;197;-3013.458,1596.886;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-3078.416,835.646;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;6;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;196;-2789.458,1580.886;Float;False;Constant;_Float4;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-755.3256,332.5497;Inherit;False;Property;_AudioMaskAffectsAmplitude2;Audio Mask Affects Amplitude;31;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-2847.183,1110.938;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-2771.413,785.6462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;198;-2613.458,1596.886;Float;False;Property;_AudioSpectrumEnabled2;Audio Spectrum Enabled;24;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-2532.342,980.4859;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;157;-392.5369,390.2305;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-756.0567,3.094849;Inherit;False;Constant;_Float9;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-193.7681,472.3416;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-2297.238,775.8156;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-755.0567,-69.90524;Inherit;False;Constant;_Float8;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;161;-575.1207,-54.72275;Inherit;False;Property;_AudioAmplitudeEnabled2;Audio Amplitude Enabled;32;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;-232.9443,64.93274;Float;False;Property;_AudioAmplitudeOffsetPower2;Audio Amplitude Offset Power;34;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;137;-284.2064,939.9142;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-2130.609,775.3364;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;163;-59.53748,477.2304;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-218.6464,-129.685;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;103.1589,48.35495;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;165;100.149,192.1474;Float;False;Constant;_Float6;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;138;-56.71106,984.5818;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-198.335,717.9164;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;46.69995,814.0266;Float;False;Property;_OffsetPower;Offset Power;11;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;139;86.19614,984.4117;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;167;298.0264,95.44534;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;89;59.82315,722.0725;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-43.23003,-796.5675;Float;False;Property;_FinalPower;Final Power;4;0;Create;True;0;0;False;0;6;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;136;-817.7505,-1089.046;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;29.55398,-1088.316;Float;False;Property;_RampEnabled;Ramp Enabled;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1022.638,-873.7692;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-812.5833,-919.587;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;14;-871.1545,-1259.316;Float;False;Property;_FinalColor;Final Color;1;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-876.8575,-1445.834;Float;False;Property;_FinalColor2;Final Color 2;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;148;-3006.642,-610.7631;Float;False;Property;_AffectorCount;Affector Count;3;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-544.9852,-1361.165;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-1155.75,-1041.046;Float;False;Property;_FinalExp;Final Exp;5;0;Create;True;0;0;False;0;2;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;147;-59.34668,-705.358;Inherit;True;Property;_FinalTexture;Final Texture;0;0;Create;True;0;0;False;0;-1;None;a8b8a3b14f2650542890347948aafe87;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;82;-437.946,-1036.915;Inherit;True;Property;_Ramp;Ramp;8;0;Create;True;0;0;False;0;-1;None;96f1785558043bf48bacf57b6511b602;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;441.4877,-984.6585;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;365.1351,736.2018;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-238.6174,-35.62854;Float;False;Property;_AudioAmplitudeEmissionPower2;Audio Amplitude Emission Power;33;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;170;76.26575,-228.8945;Float;False;Constant;_Float3;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;168;303.2668,-186.8945;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;101.3843,-91.62854;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;69.31149,-969.7088;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1132.582,-956.051;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;201;993.235,-582.7628;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;199;993.235,-582.7628;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;5;SineVFX/LivingParticles/LivingParticleFloorArrayURP;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;0;Forward;7;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;10;Surface;0;  Blend;0;Two Sided;1;Cast Shadows;1;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;0;Built-in Fog;0;Meta Pass;0;Vertex Position,InvertActionOnDeselection;1;0;4;True;True;True;False;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;200;993.235,-582.7628;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;202;993.235,-582.7628;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
WireConnection;17;0;153;3
WireConnection;17;1;153;4
WireConnection;17;2;154;1
WireConnection;102;0;17;0
WireConnection;104;0;102;0
WireConnection;104;1;102;2
WireConnection;174;0;172;3
WireConnection;174;1;172;4
WireConnection;174;2;173;1
WireConnection;142;0;102;0
WireConnection;142;1;102;1
WireConnection;143;0;102;2
WireConnection;143;1;102;1
WireConnection;140;1;104;0
WireConnection;140;0;142;0
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;176;0;174;0
WireConnection;176;1;175;0
WireConnection;141;1;140;0
WireConnection;141;0;143;0
WireConnection;94;0;17;0
WireConnection;94;1;93;0
WireConnection;151;0;150;0
WireConnection;151;1;93;0
WireConnection;177;0;176;0
WireConnection;106;0;141;0
WireConnection;149;0;94;0
WireConnection;149;1;151;0
WireConnection;149;2;93;0
WireConnection;179;0;177;0
WireConnection;179;1;178;0
WireConnection;45;0;149;0
WireConnection;180;0;179;0
WireConnection;180;2;178;0
WireConnection;183;0;180;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;186;0;183;0
WireConnection;186;1;181;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;31;0;25;0
WireConnection;185;0;182;0
WireConnection;185;1;178;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;132;1;131;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;188;0;176;0
WireConnection;188;1;185;0
WireConnection;187;0;186;0
WireConnection;187;1;184;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;190;0;188;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;191;0;187;0
WireConnection;23;0;28;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;193;1;189;0
WireConnection;193;0;191;0
WireConnection;192;1;190;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;98;1;128;0
WireConnection;99;1;127;0
WireConnection;195;0;193;0
WireConnection;195;1;192;1
WireConnection;195;2;194;0
WireConnection;53;0;33;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;111;0;105;0
WireConnection;197;0;195;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;198;1;196;0
WireConnection;198;0;197;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;198;0
WireConnection;157;0;156;0
WireConnection;159;0;157;0
WireConnection;159;1;193;0
WireConnection;88;0;117;0
WireConnection;161;1;160;0
WireConnection;161;0;158;0
WireConnection;90;0;88;0
WireConnection;163;0;159;0
WireConnection;166;0;164;0
WireConnection;166;1;162;0
WireConnection;166;2;161;0
WireConnection;166;3;163;0
WireConnection;138;0;137;2
WireConnection;138;1;137;3
WireConnection;138;2;137;4
WireConnection;139;0;138;0
WireConnection;167;0;166;0
WireConnection;167;1;165;0
WireConnection;89;0;92;0
WireConnection;136;0;91;0
WireConnection;136;1;135;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;136;0
WireConnection;82;1;83;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;147;1
WireConnection;3;4;168;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;139;0
WireConnection;42;3;167;0
WireConnection;168;0;170;0
WireConnection;168;1;169;0
WireConnection;169;0;164;0
WireConnection;169;1;171;0
WireConnection;169;2;161;0
WireConnection;169;3;163;0
WireConnection;199;2;3;0
WireConnection;199;5;42;0
ASEEND*/
//CHKSM=0F93BC9B6553EF705C2B89BBA75753B68717EAA6