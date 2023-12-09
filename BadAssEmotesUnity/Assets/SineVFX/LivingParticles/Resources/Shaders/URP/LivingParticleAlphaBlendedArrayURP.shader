// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleAlphaBlendedArrayURP"
{
	Properties
	{
		_AffectorCount("Affector Count", Float) = 5
		_FinalTexture("Final Texture", 2D) = "white" {}
		_FinalColor("Final Color", Color) = (1,0,0,1)
		_FinalColor2("Final Color 2", Color) = (0,0,0,0)
		_FinalPower("Final Power", Range( 0 , 10)) = 6
		_FinalMaskMultiply("Final Mask Multiply", Range( 0 , 10)) = 2
		[Toggle(_RAMPENABLED_ON)] _RampEnabled("Ramp Enabled", Float) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_Distance("Distance", Float) = 1
		_DistancePower("Distance Power", Range( 0.2 , 4)) = 1
		_OffsetPower("Offset Power", Float) = 0
		[Toggle(_OFFSETYLOCK_ON)] _OffsetYLock("Offset Y Lock", Float) = 0
		[Toggle(_CAMERAFADEENABLED_ON)] _CameraFadeEnabled("Camera Fade Enabled", Float) = 1
		_CameraFadeDistance("Camera Fade Distance", Float) = 1
		_CameraFadeOffset("Camera Fade Offset", Float) = 0.2
		[Toggle(_CLOSEFADEENABLED_ON)] _CloseFadeEnabled("Close Fade Enabled", Float) = 0
		_CloseFadeDistance("Close Fade Distance", Float) = 0.65
		_SoftParticleDistance("Soft Particle Distance", Float) = 0.25
		[Toggle(_MASKAFFECTSTRANSPARENCY_ON)] _MaskAffectsTransparency("Mask Affects Transparency", Float) = 0
		_MaskOpacityPower("Mask Opacity Power", Range( 0 , 10)) = 1

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Cull Back
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL

		
		Pass
		{
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend SrcAlpha OneMinusSrcAlpha , One OneMinusSrcAlpha
			ZWrite Off
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

			#pragma shader_feature _OFFSETYLOCK_ON
			#pragma shader_feature _RAMPENABLED_ON
			#pragma shader_feature _MASKAFFECTSTRANSPARENCY_ON
			#pragma shader_feature _CAMERAFADEENABLED_ON
			#pragma shader_feature _CLOSEFADEENABLED_ON


			float4 _Affectors[20];
			sampler2D _Ramp;
			sampler2D _FinalTexture;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _Distance;
			float _DistancePower;
			float _OffsetPower;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _SoftParticleDistance;
			float _CameraFadeDistance;
			float _CameraFadeOffset;
			float _CloseFadeDistance;
			float _MaskOpacityPower;
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
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			float CE1114( float4 ParticleCenterCE , float4 AffectorsCE )
			{
				float DistanceMaskMY;
				for (int w = 0; w < _AffectorCount; w++) {
				if(w == 0){
				DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w]);
				}else{
				DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w]) );	
				}
				}
				DistanceMaskMY = 1.0 - DistanceMaskMY;
				return DistanceMaskMY;
			}
			
			float4 CE2111( float4 ParticleCenterCE , float4 AffectorsCE )
			{
				float4 normalizeResultMY;
				for (int w = 0; w < _AffectorCount; w++) {
				if(w == 0){
				normalizeResultMY = normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 );
				}else{
				normalizeResultMY = normalizeResultMY + normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 );
				}
				}
				return normalize(normalizeResultMY);
			}
			

			VertexOutput vert ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE114 = appendResult17;
				float4 AffectorsCE114 = _Affectors[0];
				float localCE1114 = CE1114( ParticleCenterCE114 , AffectorsCE114 );
				float DistanceMask45 = localCE1114;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float temp_output_33_0 = pow( clampResult23 , _DistancePower );
				float ResultMask53 = temp_output_33_0;
				float4 ParticleCenterCE111 = appendResult17;
				float4 AffectorsCE111 = _Affectors[0];
				float4 localCE2111 = CE2111( ParticleCenterCE111 , AffectorsCE111 );
				float4 CenterVector44 = localCE2111;
				float3 temp_cast_0 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_0;
				#endif
				
				float3 objectToViewPos = TransformWorldToView(TransformObjectToWorld(v.vertex.xyz));
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord3.x = eyeDepth;
				
				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.yzw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ResultMask53 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ).xyz;
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
				float4 ParticleCenterCE114 = appendResult17;
				float4 AffectorsCE114 = _Affectors[0];
				float localCE1114 = CE1114( ParticleCenterCE114 , AffectorsCE114 );
				float DistanceMask45 = localCE1114;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float temp_output_33_0 = pow( clampResult23 , _DistancePower );
				float ResultMask53 = temp_output_33_0;
				float clampResult88 = clamp( ( ResultMask53 * _FinalMaskMultiply ) , 0.0 , 1.0 );
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , clampResult88);
				float2 appendResult83 = (float2(clampResult88 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				
				float2 uv0_FinalTexture = IN.ase_texcoord1.xy * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
				float clampResult58 = clamp( _SoftParticleDistance , 1.0 , 1.0 );
				float eyeDepth = IN.ase_texcoord3.x;
				float cameraDepthFade60 = (( eyeDepth -_ProjectionParams.y - _CameraFadeOffset ) / _CameraFadeDistance);
				float clampResult61 = clamp( cameraDepthFade60 , 0.0 , 1.0 );
				#ifdef _CAMERAFADEENABLED_ON
				float staticSwitch63 = clampResult61;
				#else
				float staticSwitch63 = 1.0;
				#endif
				float clampResult71 = clamp( ( ( temp_output_33_0 - _CloseFadeDistance ) * 8.0 ) , 0.0 , 1.0 );
				#ifdef _CLOSEFADEENABLED_ON
				float staticSwitch78 = clampResult71;
				#else
				float staticSwitch78 = 0.0;
				#endif
				float TooClose75 = staticSwitch78;
				float temp_output_57_0 = ( tex2D( _FinalTexture, uv0_FinalTexture ).r * clampResult58 * staticSwitch63 * ( 1.0 - TooClose75 ) * IN.ase_color.a );
				float3 desaturateInitialColor95 = staticSwitch81.rgb;
				float desaturateDot95 = dot( desaturateInitialColor95, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar95 = lerp( desaturateInitialColor95, desaturateDot95.xxx, 1.0 );
				#ifdef _MASKAFFECTSTRANSPARENCY_ON
				float staticSwitch91 = ( _MaskOpacityPower * desaturateVar95.x * temp_output_57_0 );
				#else
				float staticSwitch91 = temp_output_57_0;
				#endif
				float clampResult74 = clamp( staticSwitch91 , 0.0 , 1.0 );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( staticSwitch81 * IN.ase_color * _FinalPower ).rgb;
				float Alpha = clampResult74;
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

			#pragma shader_feature _OFFSETYLOCK_ON
			#pragma shader_feature _MASKAFFECTSTRANSPARENCY_ON
			#pragma shader_feature _CAMERAFADEENABLED_ON
			#pragma shader_feature _CLOSEFADEENABLED_ON
			#pragma shader_feature _RAMPENABLED_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			float4 _Affectors[20];
			sampler2D _FinalTexture;
			sampler2D _Ramp;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _Distance;
			float _DistancePower;
			float _OffsetPower;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _SoftParticleDistance;
			float _CameraFadeDistance;
			float _CameraFadeOffset;
			float _CloseFadeDistance;
			float _MaskOpacityPower;
			CBUFFER_END


			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			float CE1114( float4 ParticleCenterCE , float4 AffectorsCE )
			{
				float DistanceMaskMY;
				for (int w = 0; w < _AffectorCount; w++) {
				if(w == 0){
				DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w]);
				}else{
				DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w]) );	
				}
				}
				DistanceMaskMY = 1.0 - DistanceMaskMY;
				return DistanceMaskMY;
			}
			
			float4 CE2111( float4 ParticleCenterCE , float4 AffectorsCE )
			{
				float4 normalizeResultMY;
				for (int w = 0; w < _AffectorCount; w++) {
				if(w == 0){
				normalizeResultMY = normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 );
				}else{
				normalizeResultMY = normalizeResultMY + normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 );
				}
				}
				return normalize(normalizeResultMY);
			}
			

			float3 _LightDirection;

			VertexOutput ShadowPassVertex( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE114 = appendResult17;
				float4 AffectorsCE114 = _Affectors[0];
				float localCE1114 = CE1114( ParticleCenterCE114 , AffectorsCE114 );
				float DistanceMask45 = localCE1114;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float temp_output_33_0 = pow( clampResult23 , _DistancePower );
				float ResultMask53 = temp_output_33_0;
				float4 ParticleCenterCE111 = appendResult17;
				float4 AffectorsCE111 = _Affectors[0];
				float4 localCE2111 = CE2111( ParticleCenterCE111 , AffectorsCE111 );
				float4 CenterVector44 = localCE2111;
				float3 temp_cast_0 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_0;
				#endif
				
				float3 objectToViewPos = TransformWorldToView(TransformObjectToWorld(v.vertex.xyz));
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord8.x = eyeDepth;
				
				o.ase_texcoord7 = v.ase_texcoord;
				o.ase_texcoord9 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.yzw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ResultMask53 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ).xyz;
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

				float2 uv0_FinalTexture = IN.ase_texcoord7 * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
				float clampResult58 = clamp( _SoftParticleDistance , 1.0 , 1.0 );
				float eyeDepth = IN.ase_texcoord8.x;
				float cameraDepthFade60 = (( eyeDepth -_ProjectionParams.y - _CameraFadeOffset ) / _CameraFadeDistance);
				float clampResult61 = clamp( cameraDepthFade60 , 0.0 , 1.0 );
				#ifdef _CAMERAFADEENABLED_ON
				float staticSwitch63 = clampResult61;
				#else
				float staticSwitch63 = 1.0;
				#endif
				float4 appendResult17 = (float4(IN.ase_texcoord7.z , IN.ase_texcoord7.w , IN.ase_texcoord9.x , 0.0));
				float4 ParticleCenterCE114 = appendResult17;
				float4 AffectorsCE114 = _Affectors[0];
				float localCE1114 = CE1114( ParticleCenterCE114 , AffectorsCE114 );
				float DistanceMask45 = localCE1114;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float temp_output_33_0 = pow( clampResult23 , _DistancePower );
				float clampResult71 = clamp( ( ( temp_output_33_0 - _CloseFadeDistance ) * 8.0 ) , 0.0 , 1.0 );
				#ifdef _CLOSEFADEENABLED_ON
				float staticSwitch78 = clampResult71;
				#else
				float staticSwitch78 = 0.0;
				#endif
				float TooClose75 = staticSwitch78;
				float temp_output_57_0 = ( tex2D( _FinalTexture, uv0_FinalTexture ).r * clampResult58 * staticSwitch63 * ( 1.0 - TooClose75 ) * IN.ase_color.a );
				float ResultMask53 = temp_output_33_0;
				float clampResult88 = clamp( ( ResultMask53 * _FinalMaskMultiply ) , 0.0 , 1.0 );
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , clampResult88);
				float2 appendResult83 = (float2(clampResult88 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float3 desaturateInitialColor95 = staticSwitch81.rgb;
				float desaturateDot95 = dot( desaturateInitialColor95, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar95 = lerp( desaturateInitialColor95, desaturateDot95.xxx, 1.0 );
				#ifdef _MASKAFFECTSTRANSPARENCY_ON
				float staticSwitch91 = ( _MaskOpacityPower * desaturateVar95.x * temp_output_57_0 );
				#else
				float staticSwitch91 = temp_output_57_0;
				#endif
				float clampResult74 = clamp( staticSwitch91 , 0.0 , 1.0 );
				
				float Alpha = clampResult74;
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

			#pragma shader_feature _OFFSETYLOCK_ON
			#pragma shader_feature _MASKAFFECTSTRANSPARENCY_ON
			#pragma shader_feature _CAMERAFADEENABLED_ON
			#pragma shader_feature _CLOSEFADEENABLED_ON
			#pragma shader_feature _RAMPENABLED_ON


			float4 _Affectors[20];
			sampler2D _FinalTexture;
			sampler2D _Ramp;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _Distance;
			float _DistancePower;
			float _OffsetPower;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _FinalTexture_ST;
			float _SoftParticleDistance;
			float _CameraFadeDistance;
			float _CameraFadeOffset;
			float _CloseFadeDistance;
			float _MaskOpacityPower;
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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			float CE1114( float4 ParticleCenterCE , float4 AffectorsCE )
			{
				float DistanceMaskMY;
				for (int w = 0; w < _AffectorCount; w++) {
				if(w == 0){
				DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w]);
				}else{
				DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w]) );	
				}
				}
				DistanceMaskMY = 1.0 - DistanceMaskMY;
				return DistanceMaskMY;
			}
			
			float4 CE2111( float4 ParticleCenterCE , float4 AffectorsCE )
			{
				float4 normalizeResultMY;
				for (int w = 0; w < _AffectorCount; w++) {
				if(w == 0){
				normalizeResultMY = normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 );
				}else{
				normalizeResultMY = normalizeResultMY + normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 );
				}
				}
				return normalize(normalizeResultMY);
			}
			

			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE114 = appendResult17;
				float4 AffectorsCE114 = _Affectors[0];
				float localCE1114 = CE1114( ParticleCenterCE114 , AffectorsCE114 );
				float DistanceMask45 = localCE1114;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float temp_output_33_0 = pow( clampResult23 , _DistancePower );
				float ResultMask53 = temp_output_33_0;
				float4 ParticleCenterCE111 = appendResult17;
				float4 AffectorsCE111 = _Affectors[0];
				float4 localCE2111 = CE2111( ParticleCenterCE111 , AffectorsCE111 );
				float4 CenterVector44 = localCE2111;
				float3 temp_cast_0 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_0;
				#endif
				
				float3 objectToViewPos = TransformWorldToView(TransformObjectToWorld(v.vertex.xyz));
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord1.x = eyeDepth;
				
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.yzw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( ResultMask53 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ).xyz;
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

				float2 uv0_FinalTexture = IN.ase_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
				float clampResult58 = clamp( _SoftParticleDistance , 1.0 , 1.0 );
				float eyeDepth = IN.ase_texcoord1.x;
				float cameraDepthFade60 = (( eyeDepth -_ProjectionParams.y - _CameraFadeOffset ) / _CameraFadeDistance);
				float clampResult61 = clamp( cameraDepthFade60 , 0.0 , 1.0 );
				#ifdef _CAMERAFADEENABLED_ON
				float staticSwitch63 = clampResult61;
				#else
				float staticSwitch63 = 1.0;
				#endif
				float4 appendResult17 = (float4(IN.ase_texcoord.z , IN.ase_texcoord.w , IN.ase_texcoord2.x , 0.0));
				float4 ParticleCenterCE114 = appendResult17;
				float4 AffectorsCE114 = _Affectors[0];
				float localCE1114 = CE1114( ParticleCenterCE114 , AffectorsCE114 );
				float DistanceMask45 = localCE1114;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float temp_output_33_0 = pow( clampResult23 , _DistancePower );
				float clampResult71 = clamp( ( ( temp_output_33_0 - _CloseFadeDistance ) * 8.0 ) , 0.0 , 1.0 );
				#ifdef _CLOSEFADEENABLED_ON
				float staticSwitch78 = clampResult71;
				#else
				float staticSwitch78 = 0.0;
				#endif
				float TooClose75 = staticSwitch78;
				float temp_output_57_0 = ( tex2D( _FinalTexture, uv0_FinalTexture ).r * clampResult58 * staticSwitch63 * ( 1.0 - TooClose75 ) * IN.ase_color.a );
				float ResultMask53 = temp_output_33_0;
				float clampResult88 = clamp( ( ResultMask53 * _FinalMaskMultiply ) , 0.0 , 1.0 );
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , clampResult88);
				float2 appendResult83 = (float2(clampResult88 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float3 desaturateInitialColor95 = staticSwitch81.rgb;
				float desaturateDot95 = dot( desaturateInitialColor95, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar95 = lerp( desaturateInitialColor95, desaturateDot95.xxx, 1.0 );
				#ifdef _MASKAFFECTSTRANSPARENCY_ON
				float staticSwitch91 = ( _MaskOpacityPower * desaturateVar95.x * temp_output_57_0 );
				#else
				float staticSwitch91 = temp_output_57_0;
				#endif
				float clampResult74 = clamp( staticSwitch91 , 0.0 , 1.0 );
				
				float Alpha = clampResult74;
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
1;387;1906;629;3390.013;1008.498;2.911364;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;103;-3256.097,-1824.74;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;102;-3263.097,-2073.739;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GlobalArrayNode;112;-3020.516,-1638.861;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2928.958,-1908.748;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;114;-2468.219,-1515.889;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w])@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w]) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;2;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;CE1;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3451.799,73.12525;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-1947.588,-1735.546;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3452.354,-29.66669;Float;False;Property;_Distance;Distance;9;0;Create;True;0;0;False;0;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3261.688,12.73193;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3514.844,-124.8021;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-3033.888,-105.8898;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-3013.589,-55.18353;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2754.534,-140.6913;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2772.243,30.36653;Float;False;Property;_DistancePower;Distance Power;10;0;Create;True;0;0;False;0;1;4;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2570.352,-140.1038;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-2335.243,-59.63376;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1977.432,183.3593;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2323.462,-404.4654;Float;False;Property;_CloseFadeDistance;Close Fade Distance;17;0;Create;True;0;0;False;0;0.65;0.65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;-2068.815,-387.3524;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2069.815,-286.3523;Float;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1178.375,-1105.831;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1251.323,-1023.654;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;6;0;Create;True;0;0;False;0;2;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-944.322,-1073.654;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-1904.428,-382.739;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;71;-1753.815,-384.3524;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-787.5012,-1077.213;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1752.043,-248.3803;Float;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-794.3374,-946.2294;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-598.5833,-1013.587;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;36;-876.8575,-1445.834;Float;False;Property;_FinalColor2;Final Color 2;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;78;-1578.043,-334.3803;Float;False;Property;_CloseFadeEnabled;Close Fade Enabled;16;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-902.6503,-85.84533;Float;False;Property;_CameraFadeDistance;Camera Fade Distance;14;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-887.9404,26.14351;Float;False;Property;_CameraFadeOffset;Camera Fade Offset;15;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-871.1545,-1259.316;Float;False;Property;_FinalColor;Final Color;3;0;Create;True;0;0;False;0;1,0,0,1;0.4264703,0.9050709,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;37;-544.9852,-1361.165;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CameraDepthFade;60;-638.0836,-59.33221;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-1307.04,-333.401;Float;False;TooClose;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-437.946,-1036.915;Inherit;True;Property;_Ramp;Ramp;8;0;Create;True;0;0;False;0;-1;None;96f1785558043bf48bacf57b6511b602;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;59;-864.9873,-190.9568;Float;False;Property;_SoftParticleDistance;Soft Particle Distance;18;0;Create;True;0;0;False;0;0.25;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-573.4335,-153.3245;Float;False;Constant;_Float6;Float 6;21;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-334.5116,153.5335;Inherit;False;75;TooClose;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-854.4335,-633.3245;Inherit;False;0;101;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;61;-385.0013,-61.80219;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-386.9198,56.40814;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;45.88528,-1095.46;Float;False;Property;_RampEnabled;Ramp Enabled;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;101;-534.2034,-388.7517;Inherit;True;Property;_FinalTexture;Final Texture;2;0;Create;True;0;0;False;0;-1;None;7274495111a104d428fd6376d142ecfe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;80;-92.39857,147.2609;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;58;-387.9864,-188.9068;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;-439.9725,-713.249;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;63;-182.9198,-21.59186;Float;False;Property;_CameraFadeEnabled;Camera Fade Enabled;13;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;95;335.2216,-572.99;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;158.9322,-246.9111;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;96;507.9224,-570.6298;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;97;483.5101,-660.0831;Float;False;Property;_MaskOpacityPower;Mask Opacity Power;20;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;111;-2500.186,-2085.818;Float;False;float4 normalizeResultMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$normalizeResultMY = normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 )@$}else{$normalizeResultMY = normalizeResultMY + normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 )@$}$}$return normalize(normalizeResultMY)@;4;False;2;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;CE2;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-476.5721,1157.769;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;51;-504.572,1001.77;Float;False;Constant;_Vector0;Vector 0;8;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1957.393,-1950.675;Float;False;CenterVector;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;842.0498,-588.5196;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-249.978,792.1231;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-258.27,882.7471;Inherit;False;44;CenterVector;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;91;1144.967,-396.0954;Float;False;Property;_MaskAffectsTransparency;Mask Affects Transparency;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-220.0562,967.436;Float;False;Property;_OffsetPower;Offset Power;11;0;Create;True;0;0;False;0;0;1.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;49;-240.1896,1060.656;Float;False;Property;_OffsetYLock;Offset Y Lock;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DepthFade;56;-855.3602,-397.9615;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2982.624,-1725.355;Float;False;Property;_AffectorCount;Affector Count;1;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;441.4877,-984.6585;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-30.49794,-980.2728;Float;False;Property;_FinalPower;Final Power;5;0;Create;True;0;0;False;0;6;8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;109;1364.938,-255.9338;Float;False;Property;_LWPRAlphaClipThreshold;LWPR Alpha Clip Threshold;0;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;109.472,875.3488;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;74;1489.643,-390.9211;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;119;2555.304,-451.5145;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;120;2555.304,-451.5145;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;118;2555.304,-451.5145;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;5;SineVFX/LivingParticles/LivingParticleAlphaBlendedArrayURP;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;0;Forward;7;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;True;1;5;False;-1;10;False;-1;1;1;False;-1;10;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;10;Surface;1;  Blend;0;Two Sided;1;Cast Shadows;1;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;0;Built-in Fog;0;Meta Pass;0;Vertex Position,InvertActionOnDeselection;1;0;4;True;True;True;False;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;121;2555.304,-451.5145;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
WireConnection;17;0;102;3
WireConnection;17;1;102;4
WireConnection;17;2;103;1
WireConnection;114;0;17;0
WireConnection;114;1;112;0
WireConnection;45;0;114;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;31;0;25;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;23;0;28;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;53;0;33;0
WireConnection;66;0;33;0
WireConnection;66;1;76;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;68;0;66;0
WireConnection;68;1;69;0
WireConnection;71;0;68;0
WireConnection;88;0;85;0
WireConnection;83;0;88;0
WireConnection;83;1;84;0
WireConnection;78;1;79;0
WireConnection;78;0;71;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;88;0
WireConnection;60;0;62;0
WireConnection;60;1;65;0
WireConnection;75;0;78;0
WireConnection;82;1;83;0
WireConnection;61;0;60;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;101;1;117;0
WireConnection;80;0;77;0
WireConnection;58;0;59;0
WireConnection;58;1;116;0
WireConnection;58;2;116;0
WireConnection;63;1;64;0
WireConnection;63;0;61;0
WireConnection;95;0;81;0
WireConnection;57;0;101;1
WireConnection;57;1;58;0
WireConnection;57;2;63;0
WireConnection;57;3;80;0
WireConnection;57;4;52;4
WireConnection;96;0;95;0
WireConnection;111;0;17;0
WireConnection;111;1;112;0
WireConnection;44;0;111;0
WireConnection;93;0;97;0
WireConnection;93;1;96;0
WireConnection;93;2;57;0
WireConnection;91;1;57;0
WireConnection;91;0;93;0
WireConnection;49;1;50;0
WireConnection;49;0;51;0
WireConnection;56;0;59;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;42;0;55;0
WireConnection;42;1;46;0
WireConnection;42;2;43;0
WireConnection;42;3;49;0
WireConnection;74;0;91;0
WireConnection;118;2;3;0
WireConnection;118;3;74;0
WireConnection;118;5;42;0
ASEEND*/
//CHKSM=729E2297E599D7667D0B2E25E11CE7F1ED44C817