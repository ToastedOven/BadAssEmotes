// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleFloorPbrURP"
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
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define ASE_SRP_VERSION 999999
			#define _NORMALMAP 1

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _SHADOWS_SOFT
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

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


			float4 _Affector;
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			sampler2D _Albedo;
			sampler2D _Normal;
			sampler2D _Ramp;
			sampler2D _FinalTexture;
			sampler2D _MetallicSmoothness;
			CBUFFER_START( UnityPerMaterial )
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
			float4 _Albedo_ST;
			float4 _ColorTint;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			float _MetallicSmoothnessRandomOffset;
			float _Metallic;
			float _Smoothness;
			CBUFFER_END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				float4 shadowCoord : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			VertexOutput vert ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.texcoord1.xyzw.x , 0.0));
				#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
				#else
				float3 staticSwitch93 = float3(1,1,1);
				#endif
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.texcoord1.xyzw.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2Dlod( _AudioSpectrum, float4( appendResult222, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 appendResult170 = (float4(v.texcoord1.xyzw.y , v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float4 normalizeResult171 = normalize( appendResult170 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				o.ase_texcoord7 = v.ase_texcoord;
				o.ase_texcoord8 = v.texcoord1.xyzw;
				o.ase_color = v.ase_color;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch194 * clampResult196 ) + 1.0 ) ).xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 lwWNormal = TransformObjectToWorldNormal(v.ase_normal);
				float3 lwWorldPos = TransformObjectToWorld(v.vertex.xyz);
				float3 lwWTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				float3 lwWBinormal = normalize(cross(lwWNormal, lwWTangent) * v.ase_tangent.w);
				o.tSpace0 = float4(lwWTangent.x, lwWBinormal.x, lwWNormal.x, lwWorldPos.x);
				o.tSpace1 = float4(lwWTangent.y, lwWBinormal.y, lwWNormal.y, lwWorldPos.y);
				o.tSpace2 = float4(lwWTangent.z, lwWBinormal.z, lwWNormal.z, lwWorldPos.z);

				VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
				
				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				OUTPUT_SH(lwWNormal, o.lightmapUVOrVertexSH.xyz );

				half3 vertexLight = VertexLighting(vertexInput.positionWS, lwWNormal);
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( vertexInput.positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				o.clipPos = vertexInput.positionCS;

				#ifdef _MAIN_LIGHT_SHADOWS
					o.shadowCoord = GetShadowCoord(vertexInput);
				#endif
				return o;
			}

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				float3 WorldSpaceNormal = normalize(float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z));
				float3 WorldSpaceTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldSpaceBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldSpacePosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldSpaceViewDirection = _WorldSpaceCameraPos.xyz  - WorldSpacePosition;
	
				#if SHADER_HINT_NICE_QUALITY
					WorldSpaceViewDirection = SafeNormalize( WorldSpaceViewDirection );
				#endif

				float2 uv_Albedo = IN.ase_texcoord7 * _Albedo_ST.xy + _Albedo_ST.zw;
				
				float2 uv_Normal = IN.ase_texcoord7.xy * _Normal_ST.xy + _Normal_ST.zw;
				
				float4 appendResult17 = (float4(IN.ase_texcoord7.z , IN.ase_texcoord7.w , IN.ase_texcoord8.x , 0.0));
				#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
				#else
				float3 staticSwitch93 = float3(1,1,1);
				#endif
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(IN.ase_texcoord7.z , IN.ase_texcoord7.w , IN.ase_texcoord8.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2D( _AudioSpectrum, appendResult222 ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
				float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float2 uv_FinalTexture = IN.ase_texcoord7.xy * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				float2 uv0152 = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv0139 = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
				float4 tex2DNode136 = tex2D( _MetallicSmoothness, (( _MetallicSmoothnessRandomOffset )?( ( ( uv0139 + ( IN.ase_color.a * float2( 7,9 ) ) ) * (0.5 + (IN.ase_color.a - 0.0) * (1.0 - 0.5) / (1.0 - 0.0)) ) ):( uv0152 )) );
				
				float3 Albedo = ( tex2D( _Albedo, uv_Albedo ) * _ColorTint ).rgb;
				float3 Normal = UnpackNormalScale( tex2D( _Normal, uv_Normal ), 1.0f );
				float3 Emission = ( staticSwitch81 * IN.ase_color * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower2 * staticSwitch194 * clampResult196 ) ) ).rgb;
				float3 Specular = 0.5;
				float Metallic = ( tex2DNode136.r * _Metallic );
				float Smoothness = ( tex2DNode136.a * _Smoothness );
				float Occlusion = 1;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float3 BakedGI = 0;

				InputData inputData;
				inputData.positionWS = WorldSpacePosition;

				#ifdef _NORMALMAP
					inputData.normalWS = normalize(TransformTangentToWorld(Normal, half3x3(WorldSpaceTangent, WorldSpaceBiTangent, WorldSpaceNormal)));
				#else
					#if !SHADER_HINT_NICE_QUALITY
						inputData.normalWS = WorldSpaceNormal;
					#else
						inputData.normalWS = normalize(WorldSpaceNormal);
					#endif
				#endif

				inputData.viewDirectionWS = WorldSpaceViewDirection;
				inputData.shadowCoord = IN.shadowCoord;

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, IN.lightmapUVOrVertexSH.xyz, inputData.normalWS );
				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif
				half4 color = UniversalFragmentPBR(
					inputData, 
					Albedo, 
					Metallic, 
					Specular, 
					Smoothness, 
					Occlusion, 
					Emission, 
					Alpha);

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif
				
				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif
				
				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				return color;
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
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
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

			float4 _Affector;
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			CBUFFER_START( UnityPerMaterial )
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
			float4 _Albedo_ST;
			float4 _ColorTint;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			float _MetallicSmoothnessRandomOffset;
			float _Metallic;
			float _Smoothness;
			CBUFFER_END


			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			
			float3 _LightDirection;

			VertexOutput ShadowPassVertex( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
				#else
				float3 staticSwitch93 = float3(1,1,1);
				#endif
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2Dlod( _AudioSpectrum, float4( appendResult222, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 appendResult170 = (float4(v.ase_texcoord1.y , v.ase_texcoord1.z , v.ase_texcoord1.w , 0.0));
				float4 normalizeResult171 = normalize( appendResult170 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch194 * clampResult196 ) + 1.0 ) ).xyz;
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
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
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


			float4 _Affector;
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			CBUFFER_START( UnityPerMaterial )
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
			float4 _Albedo_ST;
			float4 _ColorTint;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			float _MetallicSmoothnessRandomOffset;
			float _Metallic;
			float _Smoothness;
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
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2Dlod( _AudioSpectrum, float4( appendResult222, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 appendResult170 = (float4(v.ase_texcoord1.y , v.ase_texcoord1.z , v.ase_texcoord1.w , 0.0));
				float4 normalizeResult171 = normalize( appendResult170 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch194 * clampResult196 ) + 1.0 ) ).xyz;
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

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature _IGNOREYAXIS_ON
			#pragma shader_feature _ZYUV_ON
			#pragma shader_feature _XYUV_ON
			#pragma shader_feature _AUDIOSPECTRUMENABLED2_ON
			#pragma shader_feature _AUDIOMASKENABLED2_ON
			#pragma shader_feature _AUDIOAMPLITUDEENABLED2_ON
			#pragma shader_feature _RAMPENABLED_ON


			float4 _Affector;
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			sampler2D _Albedo;
			sampler2D _Ramp;
			sampler2D _FinalTexture;
			CBUFFER_START( UnityPerMaterial )
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
			float4 _Albedo_ST;
			float4 _ColorTint;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			float _MetallicSmoothnessRandomOffset;
			float _Metallic;
			float _Smoothness;
			CBUFFER_END


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.texcoord1.x , 0.0));
				#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
				#else
				float3 staticSwitch93 = float3(1,1,1);
				#endif
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.texcoord1.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2Dlod( _AudioSpectrum, float4( appendResult222, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 appendResult170 = (float4(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w , 0.0));
				float4 normalizeResult171 = normalize( appendResult170 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.texcoord1;
				o.ase_color = v.ase_color;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch194 * clampResult196 ) + 1.0 ) ).xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				o.clipPos = MetaVertexPosition( v.vertex, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_Albedo = IN.ase_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
				
				float4 appendResult17 = (float4(IN.ase_texcoord.z , IN.ase_texcoord.w , IN.ase_texcoord1.x , 0.0));
				#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
				#else
				float3 staticSwitch93 = float3(1,1,1);
				#endif
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(IN.ase_texcoord.z , IN.ase_texcoord.w , IN.ase_texcoord1.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2D( _AudioSpectrum, appendResult222 ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , pow( ResultMaskModified90 , _FinalExp ));
				float2 appendResult83 = (float2(ResultMaskModified90 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float2 uv_FinalTexture = IN.ase_texcoord.xy * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				
				float3 Albedo = ( tex2D( _Albedo, uv_Albedo ) * _ColorTint ).rgb;
				float3 Emission = ( staticSwitch81 * IN.ase_color * _FinalPower * tex2D( _FinalTexture, uv_FinalTexture ).r * ( 1.0 + ( _AudioAverageAmplitude * _AudioAmplitudeEmissionPower2 * staticSwitch194 * clampResult196 ) ) ).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = Albedo;
				metaInput.Emission = Emission;
				
				return MetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero , One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define ASE_SRP_VERSION 999999

			#pragma enable_d3d11_debug_symbols
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


			float4 _Affector;
			sampler2D _Noise02;
			sampler2D _NoiseDistortion;
			sampler2D _Noise01;
			float3 _AudioPosition2;
			sampler2D _AudioSpectrum;
			float _AudioAverageAmplitude;
			sampler2D _Albedo;
			CBUFFER_START( UnityPerMaterial )
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
			float4 _Albedo_ST;
			float4 _ColorTint;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalExp;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _AudioAmplitudeEmissionPower2;
			float _MetallicSmoothnessRandomOffset;
			float _Metallic;
			float _Smoothness;
			CBUFFER_END


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

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
				float4 ase_texcoord : TEXCOORD0;
			};

			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				#ifdef _IGNOREYAXIS_ON
				float3 staticSwitch93 = float3(1,0,1);
				#else
				float3 staticSwitch93 = float3(1,1,1);
				#endif
				float DistanceMask45 = ( 1.0 - distance( ( appendResult17 * float4( staticSwitch93 , 0.0 ) ) , ( _Affector * float4( staticSwitch93 , 0.0 ) ) ) );
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
				float4 appendResult206 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float temp_output_208_0 = distance( appendResult206 , float4( _AudioPosition2 , 0.0 ) );
				float clampResult215 = clamp( (0.0 + (( -temp_output_208_0 + _AudioSpectrumDistanceTiling2 ) - 0.0) * (1.0 - 0.0) / (_AudioSpectrumDistanceTiling2 - 0.0)) , 0.0 , 1.0 );
				float clampResult223 = clamp( ( pow( clampResult215 , _AudioMaskExp2 ) * _AudioMaskMultiply2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOMASKENABLED2_ON
				float staticSwitch225 = clampResult223;
				#else
				float staticSwitch225 = 1.0;
				#endif
				float2 appendResult222 = (float2(( temp_output_208_0 * ( 1.0 / _AudioSpectrumDistanceTiling2 ) ) , 0.0));
				float clampResult229 = clamp( ( staticSwitch225 * tex2Dlod( _AudioSpectrum, float4( appendResult222, 0, 0.0) ).r * _AudioSpectrumPower2 ) , 0.0 , 1.0 );
				#ifdef _AUDIOSPECTRUMENABLED2_ON
				float staticSwitch230 = clampResult229;
				#else
				float staticSwitch230 = 0.0;
				#endif
				float clampResult88 = clamp( ( ( ResultMask53 * _FinalMaskMultiply ) + ResultNoise111 + staticSwitch230 ) , 0.0 , 1.0 );
				float ResultMaskModified90 = clampResult88;
				float4 appendResult170 = (float4(v.ase_texcoord1.y , v.ase_texcoord1.z , v.ase_texcoord1.w , 0.0));
				float4 normalizeResult171 = normalize( appendResult170 );
				#ifdef _AUDIOAMPLITUDEENABLED2_ON
				float staticSwitch194 = 1.0;
				#else
				float staticSwitch194 = 0.0;
				#endif
				float clampResult196 = clamp( ( ( 1.0 - _AudioMaskAffectsAmplitude2 ) + staticSwitch225 ) , 0.0 , 1.0 );
				
				o.ase_texcoord = v.ase_texcoord;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ( 1.0 - ResultMaskModified90 ) * _OffsetPower * normalizeResult171 * ( ( _AudioAverageAmplitude * _AudioAmplitudeOffsetPower2 * staticSwitch194 * clampResult196 ) + 1.0 ) ).xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.vertex.xyz );
				o.clipPos = vertexInput.positionCS;
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				float2 uv_Albedo = IN.ase_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
				
				
				float3 Albedo = ( tex2D( _Albedo, uv_Albedo ) * _ColorTint ).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				half4 color = half4( Albedo, Alpha );

				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}
		
	}
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=17500
1;387;1906;629;918.571;1306.822;2.3061;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;187;-3983.159,-1270.449;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;188;-3988.159,-1048.449;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2987.389,-1125.477;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;231;-4722.461,448.0713;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;205;-4699.495,683.3885;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;96;-3280.945,-863.9004;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;97;-3274.945,-713.9004;Float;False;Constant;_Vector2;Vector 2;11;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-2776.5,-1316.361;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;164;-2496.353,-1417.59;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;206;-4363.496,619.3885;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;207;-4411.495,843.3885;Inherit;False;Global;_AudioPosition2;_AudioPosition;33;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;165;-2498.185,-1310.03;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;20;-3031.338,-970.8239;Float;False;Global;_Affector;_Affector;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;93;-3043.945,-791.9004;Float;False;Property;_IgnoreYAxis;Ignore Y Axis;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;208;-4091.496,731.3885;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;167;-2253.321,-1448.433;Float;False;Property;_XYUV;XY UV;28;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2739.945,-969.9004;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-2744.945,-1111.9;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;166;-2486.539,-1537.903;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;168;-2005.073,-1527.534;Float;False;Property;_ZYUV;ZY UV;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;19;-2446.929,-1046.137;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-3707.496,955.3885;Float;False;Property;_AudioSpectrumDistanceTiling2;Audio Spectrum Distance Tiling;33;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;209;-3611.496,1275.388;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1809.465,-1528.039;Float;False;ParticlePositionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;22;-2283.804,-1040.446;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;211;-3451.496,1339.388;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3323.018,-279.5234;Float;False;Property;_Distance;Distance;15;0;Create;True;0;0;False;0;1;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;212;-3307.495,1339.388;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;124;-3988.08,-2455.51;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;120;-3786.271,-1925.718;Float;False;Property;_NoiseTiling;Noise Tiling;27;0;Create;True;0;0;False;0;0.25;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-4061.681,-2638.726;Float;False;Property;_NoiseDistortionScrollSpeed;Noise Distortion Scroll Speed;24;0;Create;True;0;0;False;0;0.05;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2107.307,-1043.219;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3322.463,-176.7314;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-3865.778,-2001.611;Inherit;False;106;ParticlePositionUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4014.08,-2538.51;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;22;0;Create;True;0;0;False;0;0.15;0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3132.352,-237.1247;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4012.08,-2307.51;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;21;0;Create;True;0;0;False;0;0.1;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-3582.353,-2614.693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;215;-3131.495,1339.388;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3385.508,-374.6587;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;214;-3579.496,875.3885;Float;False;Constant;_Float7;Float 4;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-3275.495,1531.388;Float;False;Property;_AudioMaskExp2;Audio Mask Exp;35;0;Create;True;0;0;False;0;1;1;0.1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3581.271,-1988.717;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3586.08,-2505.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3587.08,-2380.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;131;-3242.619,-2882.083;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.05,0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2884.253,-305.0402;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;218;-2923.495,1371.388;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;217;-3403.496,907.3885;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;216;-3051.495,1627.388;Float;False;Property;_AudioMaskMultiply2;Audio Mask Multiply;36;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2904.552,-355.7464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;219;-2667.495,1499.388;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;109;-2909.619,-2349.673;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2625.198,-390.5479;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-3227.495,715.3885;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;110;-2906.136,-2089.58;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-3014.997,-2687.215;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;25;0;Create;True;0;0;False;0;0.1;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;-3037.619,-2899.083;Inherit;True;Property;_NoiseDistortion;Noise Distortion;23;0;Create;True;0;0;False;0;-1;None;19bfab0886d4ce348ba29f17a191277b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;223;-2523.495,1483.388;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-2923.495,1227.388;Float;False;Constant;_Float10;Float 8;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;128;-2440.74,-2356.307;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;222;-3051.495,715.3885;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2642.906,-219.4901;Float;False;Property;_DistancePower;Distance Power;16;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;-2444.489,-2599.995;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2441.016,-389.9604;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-2205.906,-309.4904;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1901.047,-2176.647;Float;False;Property;_NoisePower;Noise Power;26;0;Create;True;0;0;False;0;4;8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-1922.118,-2380.805;Inherit;True;Property;_Noise01;Noise 01;19;0;Create;True;0;0;False;0;-1;None;e16f8e2dd5ea82044bade391afc45676;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;-1920.546,-2647.616;Inherit;True;Property;_Noise02;Noise 02;20;0;Create;True;0;0;False;0;-1;None;fe9b27216f3b18f499e61ce73ae8dad2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;225;-2582.347,1161.384;Float;False;Property;_AudioMaskEnabled2;Audio Mask Enabled;34;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;224;-2907.495,683.3885;Inherit;True;Property;_AudioSpectrum;Audio Spectrum;31;1;[HideInInspector];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;226;-2891.495,891.3885;Inherit;False;Property;_AudioSpectrumPower2;Audio Spectrum Power;32;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-2016.534,-316.0599;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1462.533,-2492.596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;227;-2555.495,635.3885;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1977.149,-64.54962;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1295.742,-2496.78;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2050.098,17.62714;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;12;0;Create;True;0;0;False;0;2;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;229;-2283.495,715.3885;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;228;-2059.495,699.3885;Float;False;Constant;_Float4;Float 2;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-1743.097,-32.37284;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-1818.867,292.9186;Inherit;False;111;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;230;-1883.495,715.3885;Float;False;Property;_AudioSpectrumEnabled2;Audio Spectrum Enabled;30;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-1064.267,1283.147;Inherit;False;Property;_AudioMaskAffectsAmplitude2;Audio Mask Affects Amplitude;37;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-1501.026,112.467;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;190;-701.4778,1340.827;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;-1063.998,880.6917;Inherit;False;Constant;_Float8;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-1064.998,953.6917;Inherit;False;Constant;_Float9;Float 7;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;192;-502.709,1422.938;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-1268.922,-42.20346;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-541.8853,1015.53;Float;False;Property;_AudioAmplitudeOffsetPower2;Audio Amplitude Offset Power;40;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;196;-368.4784,1427.827;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;194;-884.0616,895.8741;Inherit;False;Property;_AudioAmplitudeEnabled2;Audio Amplitude Enabled;38;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;169;62.92979,2380.91;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1102.293,-42.68261;Float;False;ResultMaskModified;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;197;-527.5873,820.9119;Float;False;Global;_AudioAverageAmplitude;_AudioAverageAmplitude;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;170;290.4253,2425.578;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;-205.782,998.9518;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;166.1718,2218.992;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;198;-208.792,1142.744;Float;False;Constant;_Float6;Float 3;28;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;89;424.33,2223.148;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;135;237.3863,-1397.21;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;-1;None;d517ad3e48ab0924eb8f1c4a6f7308ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;156;415.4019,-1202.201;Float;False;Property;_ColorTint;Color Tint;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;200;-10.91457,1046.042;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;411.2067,2315.102;Float;False;Property;_OffsetPower;Offset Power;17;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;171;433.333,2425.407;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;173;-3633.083,-1261.739;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-3345.552,-1041.854;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;154;-1306.386,-1171.877;Float;False;Constant;_Vector3;Vector 3;25;0;Create;True;0;0;False;0;7,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;138;327.8085,-1023.09;Inherit;True;Property;_Normal;Normal;6;0;Create;True;0;0;False;0;-1;None;b6c0ff317b9dc454b834376f013eb695;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;159;486.5865,-635.9687;Float;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-735.6873,-1281.52;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;160;464.13,-558.3915;Float;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;715.2351,-639.0311;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;174;-3631.083,-1071.739;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;723.4019,-1287.201;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-528.9289,-1245.926;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;729.6418,2237.278;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;152;-602.516,-1133.348;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;139;-1079.168,-1360.118;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;460.6085,-334.5538;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-989.4111,-1220.116;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-3348.996,-1266.742;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;707.0691,-770.708;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;147;-1011.197,-1098.789;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-418.8253,-386.8104;Inherit;True;Property;_Ramp;Ramp;14;0;Create;True;0;0;False;0;-1;None;878a9243ba57bf04194c029c2404cdcc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;153;-255.6098,-1199.933;Float;False;Property;_MetallicSmoothnessRandomOffset;MetallicSmoothness Random Offset;5;0;Create;True;0;0;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1237.551,-390.96;Float;False;Property;_FinalExp;Final Exp;11;0;Create;True;0;0;False;0;2;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1107.518,-221.6646;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1216.461,-310.9464;Inherit;False;90;ResultMaskModified;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;144;-786.7141,-437.1918;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-547.5583,914.9683;Float;False;Property;_AudioAmplitudeEmissionPower2;Audio Amplitude Emission Power;39;0;Create;True;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-775.4625,-268.4824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;36;-857.7367,-795.7299;Float;False;Property;_FinalColor2;Final Color 2;9;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;14;-852.0337,-609.2119;Float;False;Property;_FinalColor;Final Color;8;0;Create;True;0;0;False;0;1,0,0,1;1,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;203;-232.6752,721.7024;Float;False;Constant;_Float3;Float 1;27;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;202;-207.5566,858.9683;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-525.8644,-711.061;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;141;-1326.989,-1341.416;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;201;-5.674164,763.7024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;172;-40.35896,-54.8124;Inherit;True;Property;_FinalTexture;Final Texture;7;0;Create;True;0;0;False;0;-1;None;a0c8393bc92291e438c0a270fbfa611f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;52;88.43221,-319.6041;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-24.1093,-146.4627;Float;False;Property;_FinalPower;Final Power;10;0;Create;True;0;0;False;0;6;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;48.67471,-438.2115;Float;False;Property;_RampEnabled;Ramp Enabled;13;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;136;254.3383,-829.4268;Inherit;True;Property;_MetallicSmoothness;MetallicSmoothness;2;0;Create;True;0;0;False;0;-1;None;716d7ba1113de9c47830d83623210506;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;234;1646.991,-793.9543;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;235;1646.991,-793.9543;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;232;1646.991,-793.9543;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;4;SineVFX/LivingParticles/LivingParticleFloorPbrURP;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;0;Forward;12;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;12;Workflow;1;Surface;0;  Blend;0;Two Sided;1;Cast Shadows;1;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;1;Built-in Fog;1;Meta Pass;1;Override Baked GI;0;Vertex Position,InvertActionOnDeselection;1;0;5;True;True;True;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;233;1646.991,-793.9543;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;236;1646.991,-793.9543;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;4;Universal2D;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
WireConnection;17;0;187;3
WireConnection;17;1;187;4
WireConnection;17;2;188;1
WireConnection;163;0;17;0
WireConnection;164;0;163;0
WireConnection;164;1;163;1
WireConnection;206;0;231;3
WireConnection;206;1;231;4
WireConnection;206;2;205;1
WireConnection;165;0;163;0
WireConnection;165;1;163;2
WireConnection;93;1;97;0
WireConnection;93;0;96;0
WireConnection;208;0;206;0
WireConnection;208;1;207;0
WireConnection;167;1;165;0
WireConnection;167;0;164;0
WireConnection;95;0;20;0
WireConnection;95;1;93;0
WireConnection;94;0;17;0
WireConnection;94;1;93;0
WireConnection;166;0;163;2
WireConnection;166;1;163;1
WireConnection;168;1;167;0
WireConnection;168;0;166;0
WireConnection;19;0;94;0
WireConnection;19;1;95;0
WireConnection;209;0;208;0
WireConnection;106;0;168;0
WireConnection;22;0;19;0
WireConnection;211;0;209;0
WireConnection;211;1;210;0
WireConnection;212;0;211;0
WireConnection;212;2;210;0
WireConnection;45;0;22;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;133;0;124;2
WireConnection;133;1;134;0
WireConnection;215;0;212;0
WireConnection;119;0;107;0
WireConnection;119;1;120;0
WireConnection;125;0;124;2
WireConnection;125;1;122;0
WireConnection;126;0;124;2
WireConnection;126;1;121;0
WireConnection;131;0;119;0
WireConnection;131;1;133;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;218;0;215;0
WireConnection;218;1;213;0
WireConnection;217;0;214;0
WireConnection;217;1;210;0
WireConnection;31;0;25;0
WireConnection;219;0;218;0
WireConnection;219;1;216;0
WireConnection;109;0;119;0
WireConnection;109;1;125;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;220;0;208;0
WireConnection;220;1;217;0
WireConnection;110;0;119;0
WireConnection;110;1;126;0
WireConnection;132;1;131;0
WireConnection;223;0;219;0
WireConnection;128;0;110;0
WireConnection;128;1;132;1
WireConnection;128;2;129;0
WireConnection;222;0;220;0
WireConnection;127;0;109;0
WireConnection;127;1;132;1
WireConnection;127;2;129;0
WireConnection;23;0;28;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;98;1;128;0
WireConnection;99;1;127;0
WireConnection;225;1;221;0
WireConnection;225;0;223;0
WireConnection;224;1;222;0
WireConnection;53;0;33;0
WireConnection;105;0;99;1
WireConnection;105;1;98;1
WireConnection;105;2;114;0
WireConnection;227;0;225;0
WireConnection;227;1;224;1
WireConnection;227;2;226;0
WireConnection;111;0;105;0
WireConnection;229;0;227;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;230;1;228;0
WireConnection;230;0;229;0
WireConnection;117;0;85;0
WireConnection;117;1;118;0
WireConnection;117;2;230;0
WireConnection;190;0;189;0
WireConnection;192;0;190;0
WireConnection;192;1;225;0
WireConnection;88;0;117;0
WireConnection;196;0;192;0
WireConnection;194;1;193;0
WireConnection;194;0;191;0
WireConnection;90;0;88;0
WireConnection;170;0;169;2
WireConnection;170;1;169;3
WireConnection;170;2;169;4
WireConnection;199;0;197;0
WireConnection;199;1;195;0
WireConnection;199;2;194;0
WireConnection;199;3;196;0
WireConnection;89;0;92;0
WireConnection;200;0;199;0
WireConnection;200;1;198;0
WireConnection;171;0;170;0
WireConnection;140;0;139;0
WireConnection;140;1;145;0
WireConnection;158;0;136;4
WireConnection;158;1;160;0
WireConnection;155;0;135;0
WireConnection;155;1;156;0
WireConnection;148;0;140;0
WireConnection;148;1;147;0
WireConnection;42;0;89;0
WireConnection;42;1;43;0
WireConnection;42;2;171;0
WireConnection;42;3;200;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;172;1
WireConnection;3;4;201;0
WireConnection;145;0;141;4
WireConnection;145;1;154;0
WireConnection;157;0;136;1
WireConnection;157;1;159;0
WireConnection;147;0;141;4
WireConnection;82;1;83;0
WireConnection;153;0;152;0
WireConnection;153;1;148;0
WireConnection;144;0;91;0
WireConnection;144;1;143;0
WireConnection;83;0;91;0
WireConnection;83;1;84;0
WireConnection;202;0;197;0
WireConnection;202;1;204;0
WireConnection;202;2;194;0
WireConnection;202;3;196;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;144;0
WireConnection;201;0;203;0
WireConnection;201;1;202;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;136;1;153;0
WireConnection;232;0;155;0
WireConnection;232;1;138;0
WireConnection;232;2;3;0
WireConnection;232;3;157;0
WireConnection;232;4;158;0
WireConnection;232;8;42;0
ASEEND*/
//CHKSM=8062D9E9A71933891197FF8115EEC1160A14F575