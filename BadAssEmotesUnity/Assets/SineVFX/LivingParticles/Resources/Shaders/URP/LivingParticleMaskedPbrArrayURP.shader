// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleMaskedPbrArrayURP"
{
	Properties
	{
		_LWRPAlphaClipThreshold("LWRP Alpha Clip Threshold", Float) = 0.5
		_AffectorCount("Affector Count", Float) = 5
		_Albedo("Albedo", 2D) = "white" {}
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MetallicSmoothness("MetallicSmoothness", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0.5
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		_Normal("Normal", 2D) = "bump" {}
		_Emission("Emission", 2D) = "white" {}
		_FinalColor("Final Color", Color) = (1,0,0,1)
		_FinalColor2("Final Color 2", Color) = (0,0,0,0)
		_FinalPower("Final Power", Range( 0 , 10)) = 6
		_FinalMaskMultiply("Final Mask Multiply", Range( 0 , 10)) = 2
		[Toggle(_RAMPENABLED_ON)] _RampEnabled("Ramp Enabled", Float) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_Distance("Distance", Float) = 1
		_DistancePower("Distance Power", Range( 0.2 , 4)) = 1
		[Toggle(_OFFSETYLOCK_ON)] _OffsetYLock("Offset Y Lock", Float) = 0
		_OffsetPower("Offset Power", Float) = 0
		[Toggle(_CENTERMASKENABLED_ON)] _CenterMaskEnabled("Center Mask Enabled", Float) = 0
		_CenterMaskMultiply("Center Mask Multiply", Float) = 4
		_CenterMaskSubtract("Center Mask Subtract", Float) = 0.75
		[Toggle(_VERTEXDISTORTIONENABLED_ON)] _VertexDistortionEnabled("Vertex Distortion Enabled", Float) = 0
		_VertexOffsetTexture("Vertex Offset Texture", 2D) = "white" {}
		_VertexDistortionPower("Vertex Distortion Power", Float) = 0.1
		_VertexDistortionTiling("Vertex Distortion Tiling", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Cull Off
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
			#define ASE_TEXTURE_PARAMS(textureName) textureName
			
			#define _NORMALMAP 1
			#define _AlphaClip 1

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
			
			#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
			#pragma shader_feature _CENTERMASKENABLED_ON
			#pragma shader_feature _OFFSETYLOCK_ON
			#pragma shader_feature _RAMPENABLED_ON


			sampler2D _VertexOffsetTexture;
			float4 _Affectors[20];
			sampler2D _Albedo;
			sampler2D _Normal;
			sampler2D _Ramp;
			sampler2D _Emission;
			sampler2D _MetallicSmoothness;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _VertexDistortionPower;
			float _VertexDistortionTiling;
			float _Distance;
			float _DistancePower;
			float _CenterMaskSubtract;
			float _CenterMaskMultiply;
			float _OffsetPower;
			float4 _ColorTint;
			float4 _Albedo_ST;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _Emission_ST;
			float _Metallic;
			float4 _MetallicSmoothness_ST;
			float _Smoothness;
			float _LWRPAlphaClipThreshold;
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

			inline float4 TriplanarSamplingSV( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.zy * float2( nsign.x, 1.0 ), 0, 0 ) ) );
				yNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xz * float2( nsign.y, 1.0 ), 0, 0 ) ) );
				zNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xy * float2( -nsign.z, 1.0 ), 0, 0 ) ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float CE1141( float4 ParticleCenterCE , float4 AffectorsCE )
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
			
			float4 CE2140( float4 ParticleCenterCE , float4 AffectorsCE )
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

				float3 temp_cast_0 = (0.0).xxx;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float4 triplanar111 = TriplanarSamplingSV( _VertexOffsetTexture, ase_worldPos, ase_worldNormal, 1.0, _VertexDistortionTiling, 1.0, 0 );
				float4 break114 = triplanar111;
				float3 appendResult115 = (float3(break114.x , break114.y , break114.z));
				#ifdef _VERTEXDISTORTIONENABLED_ON
				float3 staticSwitch120 = ( _VertexDistortionPower * (float3( -1,-1,-1 ) + (appendResult115 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) );
				#else
				float3 staticSwitch120 = temp_cast_0;
				#endif
				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.texcoord1.xyzw.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult105 = clamp( ( ResultMask53 - _CenterMaskSubtract ) , 0.0 , 1.0 );
				#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( ResultMask53 - ( clampResult105 * _CenterMaskMultiply ) );
				#else
				float staticSwitch109 = ResultMask53;
				#endif
				float4 ParticleCenterCE140 = appendResult17;
				float4 AffectorsCE140 = _Affectors[0];
				float4 localCE2140 = CE2140( ParticleCenterCE140 , AffectorsCE140 );
				float4 CenterVector44 = localCE2140;
				float3 temp_cast_2 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_2;
				#endif
				
				o.ase_texcoord7 = v.ase_texcoord;
				o.ase_texcoord8 = v.texcoord1.xyzw;
				o.ase_color = v.ase_color;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ).xyz;
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

			half4 frag ( VertexOutput IN , half ase_vface : VFACE ) : SV_Target
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
				float4 tex2DNode89 = tex2D( _Albedo, uv_Albedo );
				
				float2 uv_Normal = IN.ase_texcoord7.xy * _Normal_ST.xy + _Normal_ST.zw;
				float3 tex2DNode91 = UnpackNormalScale( tex2D( _Normal, uv_Normal ), 1.0f );
				float3 switchResult125 = (((ase_vface>0)?(( float3(1,1,1) * tex2DNode91 )):(( tex2DNode91 * float3(-1,-1,-1) ))));
				
				float4 appendResult17 = (float4(IN.ase_texcoord7.z , IN.ase_texcoord7.w , IN.ase_texcoord8.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult88 = clamp( ( ResultMask53 * _FinalMaskMultiply ) , 0.0 , 1.0 );
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , clampResult88);
				float2 appendResult83 = (float2(clampResult88 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float2 uv_Emission = IN.ase_texcoord7.xy * _Emission_ST.xy + _Emission_ST.zw;
				
				float2 uv_MetallicSmoothness = IN.ase_texcoord7.xy * _MetallicSmoothness_ST.xy + _MetallicSmoothness_ST.zw;
				float4 tex2DNode90 = tex2D( _MetallicSmoothness, uv_MetallicSmoothness );
				
				float3 Albedo = ( _ColorTint * tex2DNode89 ).rgb;
				float3 Normal = switchResult125;
				float3 Emission = ( staticSwitch81 * IN.ase_color * _FinalPower * IN.ase_color.a * tex2D( _Emission, uv_Emission ).r ).rgb;
				float3 Specular = 0.5;
				float Metallic = ( _Metallic * tex2DNode90.r );
				float Smoothness = ( tex2DNode90.a * _Smoothness );
				float Occlusion = 1;
				float Alpha = tex2DNode89.a;
				float AlphaClipThreshold = _LWRPAlphaClipThreshold;
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
			#define ASE_TEXTURE_PARAMS(textureName) textureName
			
			#define _AlphaClip 1

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex ShadowPassVertex
			#pragma fragment ShadowPassFragment


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
			#pragma shader_feature _CENTERMASKENABLED_ON
			#pragma shader_feature _OFFSETYLOCK_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _VertexOffsetTexture;
			float4 _Affectors[20];
			sampler2D _Albedo;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _VertexDistortionPower;
			float _VertexDistortionTiling;
			float _Distance;
			float _DistancePower;
			float _CenterMaskSubtract;
			float _CenterMaskMultiply;
			float _OffsetPower;
			float4 _ColorTint;
			float4 _Albedo_ST;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _Emission_ST;
			float _Metallic;
			float4 _MetallicSmoothness_ST;
			float _Smoothness;
			float _LWRPAlphaClipThreshold;
			CBUFFER_END


			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			inline float4 TriplanarSamplingSV( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.zy * float2( nsign.x, 1.0 ), 0, 0 ) ) );
				yNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xz * float2( nsign.y, 1.0 ), 0, 0 ) ) );
				zNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xy * float2( -nsign.z, 1.0 ), 0, 0 ) ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float CE1141( float4 ParticleCenterCE , float4 AffectorsCE )
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
			
			float4 CE2140( float4 ParticleCenterCE , float4 AffectorsCE )
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

				float3 temp_cast_0 = (0.0).xxx;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float4 triplanar111 = TriplanarSamplingSV( _VertexOffsetTexture, ase_worldPos, ase_worldNormal, 1.0, _VertexDistortionTiling, 1.0, 0 );
				float4 break114 = triplanar111;
				float3 appendResult115 = (float3(break114.x , break114.y , break114.z));
				#ifdef _VERTEXDISTORTIONENABLED_ON
				float3 staticSwitch120 = ( _VertexDistortionPower * (float3( -1,-1,-1 ) + (appendResult115 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) );
				#else
				float3 staticSwitch120 = temp_cast_0;
				#endif
				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult105 = clamp( ( ResultMask53 - _CenterMaskSubtract ) , 0.0 , 1.0 );
				#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( ResultMask53 - ( clampResult105 * _CenterMaskMultiply ) );
				#else
				float staticSwitch109 = ResultMask53;
				#endif
				float4 ParticleCenterCE140 = appendResult17;
				float4 AffectorsCE140 = _Affectors[0];
				float4 localCE2140 = CE2140( ParticleCenterCE140 , AffectorsCE140 );
				float4 CenterVector44 = localCE2140;
				float3 temp_cast_2 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_2;
				#endif
				
				o.ase_texcoord7 = v.ase_texcoord;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ).xyz;
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

				float2 uv_Albedo = IN.ase_texcoord7 * _Albedo_ST.xy + _Albedo_ST.zw;
				float4 tex2DNode89 = tex2D( _Albedo, uv_Albedo );
				
				float Alpha = tex2DNode89.a;
				float AlphaClipThreshold = _LWRPAlphaClipThreshold;

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
			#define ASE_TEXTURE_PARAMS(textureName) textureName
			
			#define _AlphaClip 1

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
			#pragma shader_feature _CENTERMASKENABLED_ON
			#pragma shader_feature _OFFSETYLOCK_ON


			sampler2D _VertexOffsetTexture;
			float4 _Affectors[20];
			sampler2D _Albedo;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _VertexDistortionPower;
			float _VertexDistortionTiling;
			float _Distance;
			float _DistancePower;
			float _CenterMaskSubtract;
			float _CenterMaskMultiply;
			float _OffsetPower;
			float4 _ColorTint;
			float4 _Albedo_ST;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _Emission_ST;
			float _Metallic;
			float4 _MetallicSmoothness_ST;
			float _Smoothness;
			float _LWRPAlphaClipThreshold;
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
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			inline float4 TriplanarSamplingSV( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.zy * float2( nsign.x, 1.0 ), 0, 0 ) ) );
				yNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xz * float2( nsign.y, 1.0 ), 0, 0 ) ) );
				zNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xy * float2( -nsign.z, 1.0 ), 0, 0 ) ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float CE1141( float4 ParticleCenterCE , float4 AffectorsCE )
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
			
			float4 CE2140( float4 ParticleCenterCE , float4 AffectorsCE )
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

				float3 temp_cast_0 = (0.0).xxx;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float4 triplanar111 = TriplanarSamplingSV( _VertexOffsetTexture, ase_worldPos, ase_worldNormal, 1.0, _VertexDistortionTiling, 1.0, 0 );
				float4 break114 = triplanar111;
				float3 appendResult115 = (float3(break114.x , break114.y , break114.z));
				#ifdef _VERTEXDISTORTIONENABLED_ON
				float3 staticSwitch120 = ( _VertexDistortionPower * (float3( -1,-1,-1 ) + (appendResult115 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) );
				#else
				float3 staticSwitch120 = temp_cast_0;
				#endif
				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult105 = clamp( ( ResultMask53 - _CenterMaskSubtract ) , 0.0 , 1.0 );
				#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( ResultMask53 - ( clampResult105 * _CenterMaskMultiply ) );
				#else
				float staticSwitch109 = ResultMask53;
				#endif
				float4 ParticleCenterCE140 = appendResult17;
				float4 AffectorsCE140 = _Affectors[0];
				float4 localCE2140 = CE2140( ParticleCenterCE140 , AffectorsCE140 );
				float4 CenterVector44 = localCE2140;
				float3 temp_cast_2 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_2;
				#endif
				
				o.ase_texcoord = v.ase_texcoord;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ).xyz;
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

				float2 uv_Albedo = IN.ase_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
				float4 tex2DNode89 = tex2D( _Albedo, uv_Albedo );
				
				float Alpha = tex2DNode89.a;
				float AlphaClipThreshold = _LWRPAlphaClipThreshold;

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
			#define ASE_TEXTURE_PARAMS(textureName) textureName
			
			#define _AlphaClip 1

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
			#pragma shader_feature _CENTERMASKENABLED_ON
			#pragma shader_feature _OFFSETYLOCK_ON
			#pragma shader_feature _RAMPENABLED_ON


			sampler2D _VertexOffsetTexture;
			float4 _Affectors[20];
			sampler2D _Albedo;
			sampler2D _Ramp;
			sampler2D _Emission;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _VertexDistortionPower;
			float _VertexDistortionTiling;
			float _Distance;
			float _DistancePower;
			float _CenterMaskSubtract;
			float _CenterMaskMultiply;
			float _OffsetPower;
			float4 _ColorTint;
			float4 _Albedo_ST;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _Emission_ST;
			float _Metallic;
			float4 _MetallicSmoothness_ST;
			float _Smoothness;
			float _LWRPAlphaClipThreshold;
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

			inline float4 TriplanarSamplingSV( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.zy * float2( nsign.x, 1.0 ), 0, 0 ) ) );
				yNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xz * float2( nsign.y, 1.0 ), 0, 0 ) ) );
				zNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xy * float2( -nsign.z, 1.0 ), 0, 0 ) ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float CE1141( float4 ParticleCenterCE , float4 AffectorsCE )
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
			
			float4 CE2140( float4 ParticleCenterCE , float4 AffectorsCE )
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

				float3 temp_cast_0 = (0.0).xxx;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float4 triplanar111 = TriplanarSamplingSV( _VertexOffsetTexture, ase_worldPos, ase_worldNormal, 1.0, _VertexDistortionTiling, 1.0, 0 );
				float4 break114 = triplanar111;
				float3 appendResult115 = (float3(break114.x , break114.y , break114.z));
				#ifdef _VERTEXDISTORTIONENABLED_ON
				float3 staticSwitch120 = ( _VertexDistortionPower * (float3( -1,-1,-1 ) + (appendResult115 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) );
				#else
				float3 staticSwitch120 = temp_cast_0;
				#endif
				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.texcoord1.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult105 = clamp( ( ResultMask53 - _CenterMaskSubtract ) , 0.0 , 1.0 );
				#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( ResultMask53 - ( clampResult105 * _CenterMaskMultiply ) );
				#else
				float staticSwitch109 = ResultMask53;
				#endif
				float4 ParticleCenterCE140 = appendResult17;
				float4 AffectorsCE140 = _Affectors[0];
				float4 localCE2140 = CE2140( ParticleCenterCE140 , AffectorsCE140 );
				float4 CenterVector44 = localCE2140;
				float3 temp_cast_2 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_2;
				#endif
				
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.texcoord1;
				o.ase_color = v.ase_color;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ).xyz;
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
				float4 tex2DNode89 = tex2D( _Albedo, uv_Albedo );
				
				float4 appendResult17 = (float4(IN.ase_texcoord.z , IN.ase_texcoord.w , IN.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult88 = clamp( ( ResultMask53 * _FinalMaskMultiply ) , 0.0 , 1.0 );
				float4 lerpResult37 = lerp( _FinalColor2 , _FinalColor , clampResult88);
				float2 appendResult83 = (float2(clampResult88 , 0.0));
				#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
				#else
				float4 staticSwitch81 = lerpResult37;
				#endif
				float2 uv_Emission = IN.ase_texcoord.xy * _Emission_ST.xy + _Emission_ST.zw;
				
				
				float3 Albedo = ( _ColorTint * tex2DNode89 ).rgb;
				float3 Emission = ( staticSwitch81 * IN.ase_color * _FinalPower * IN.ase_color.a * tex2D( _Emission, uv_Emission ).r ).rgb;
				float Alpha = tex2DNode89.a;
				float AlphaClipThreshold = _LWRPAlphaClipThreshold;

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
			#define ASE_TEXTURE_PARAMS(textureName) textureName
			
			#define _AlphaClip 1

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
			
			#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
			#pragma shader_feature _CENTERMASKENABLED_ON
			#pragma shader_feature _OFFSETYLOCK_ON


			sampler2D _VertexOffsetTexture;
			float4 _Affectors[20];
			sampler2D _Albedo;
			CBUFFER_START( UnityPerMaterial )
			float _AffectorCount;
			float _VertexDistortionPower;
			float _VertexDistortionTiling;
			float _Distance;
			float _DistancePower;
			float _CenterMaskSubtract;
			float _CenterMaskMultiply;
			float _OffsetPower;
			float4 _ColorTint;
			float4 _Albedo_ST;
			float4 _Normal_ST;
			float4 _FinalColor2;
			float4 _FinalColor;
			float _FinalMaskMultiply;
			float _FinalPower;
			float4 _Emission_ST;
			float _Metallic;
			float4 _MetallicSmoothness_ST;
			float _Smoothness;
			float _LWRPAlphaClipThreshold;
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

			inline float4 TriplanarSamplingSV( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.zy * float2( nsign.x, 1.0 ), 0, 0 ) ) );
				yNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xz * float2( nsign.y, 1.0 ), 0, 0 ) ) );
				zNorm = ( tex2Dlod( ASE_TEXTURE_PARAMS( topTexMap ), float4( tiling * worldPos.xy * float2( -nsign.z, 1.0 ), 0, 0 ) ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float CE1141( float4 ParticleCenterCE , float4 AffectorsCE )
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
			
			float4 CE2140( float4 ParticleCenterCE , float4 AffectorsCE )
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

				float3 temp_cast_0 = (0.0).xxx;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float4 triplanar111 = TriplanarSamplingSV( _VertexOffsetTexture, ase_worldPos, ase_worldNormal, 1.0, _VertexDistortionTiling, 1.0, 0 );
				float4 break114 = triplanar111;
				float3 appendResult115 = (float3(break114.x , break114.y , break114.z));
				#ifdef _VERTEXDISTORTIONENABLED_ON
				float3 staticSwitch120 = ( _VertexDistortionPower * (float3( -1,-1,-1 ) + (appendResult115 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) );
				#else
				float3 staticSwitch120 = temp_cast_0;
				#endif
				float4 appendResult17 = (float4(v.ase_texcoord.z , v.ase_texcoord.w , v.ase_texcoord1.x , 0.0));
				float4 ParticleCenterCE141 = appendResult17;
				float4 AffectorsCE141 = _Affectors[0];
				float localCE1141 = CE1141( ParticleCenterCE141 , AffectorsCE141 );
				float DistanceMask45 = localCE1141;
				float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
				float ResultMask53 = pow( clampResult23 , _DistancePower );
				float clampResult105 = clamp( ( ResultMask53 - _CenterMaskSubtract ) , 0.0 , 1.0 );
				#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( ResultMask53 - ( clampResult105 * _CenterMaskMultiply ) );
				#else
				float staticSwitch109 = ResultMask53;
				#endif
				float4 ParticleCenterCE140 = appendResult17;
				float4 AffectorsCE140 = _Affectors[0];
				float4 localCE2140 = CE2140( ParticleCenterCE140 , AffectorsCE140 );
				float4 CenterVector44 = localCE2140;
				float3 temp_cast_2 = (1.0).xxx;
				#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
				#else
				float3 staticSwitch49 = temp_cast_2;
				#endif
				
				o.ase_texcoord = v.ase_texcoord;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ).xyz;
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
				float4 tex2DNode89 = tex2D( _Albedo, uv_Albedo );
				
				
				float3 Albedo = ( _ColorTint * tex2DNode89 ).rgb;
				float Alpha = tex2DNode89.a;
				float AlphaClipThreshold = _LWRPAlphaClipThreshold;

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
1;387;1906;629;3485.548;1707.705;1;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;137;-2967.946,-1486.1;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;138;-2969.946,-1308.1;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2610.043,-1385.086;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GlobalArrayNode;143;-2687.151,-1142.252;Inherit;False;_Affectors;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;141;-2272.891,-970.3553;Float;False;float DistanceMaskMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$DistanceMaskMY = distance(ParticleCenterCE, _Affectors[w])@$}else{$DistanceMaskMY = min( DistanceMaskMY, distance(ParticleCenterCE, _Affectors[w]) )@	$}$}$DistanceMaskMY = 1.0 - DistanceMaskMY@$return DistanceMaskMY@;1;False;2;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;CE1;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2935.559,-420.2718;Float;False;Property;_Distance;Distance;15;0;Create;True;0;0;False;0;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-1823.797,-1029.057;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2935.004,-317.4798;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-2998.05,-515.4072;Inherit;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-2744.894,-377.8731;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2517.094,-496.4949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2496.794,-445.7886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2237.74,-531.2965;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2255.449,-360.2385;Float;False;Property;_DistancePower;Distance Power;16;0;Create;True;0;0;False;0;1;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2053.557,-530.7089;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-1818.45,-450.2388;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1577.542,-444.0035;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-508.0141,426.6689;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-535.1007,624.9363;Float;False;Property;_CenterMaskSubtract;Center Mask Subtract;21;0;Create;True;0;0;False;0;0.75;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-948.1693,174.6511;Float;False;Property;_VertexDistortionTiling;Vertex Distortion Tiling;25;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;113;-927.8683,-18.3929;Float;True;Property;_VertexOffsetTexture;Vertex Offset Texture;23;0;Create;True;0;0;False;0;None;f5b6873a85b11e24b9f21dcd42486c09;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TriplanarNode;111;-637.6868,55.03267;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;101;-284.7973,531.0767;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;114;-277.9813,55.32092;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ClampOpNode;105;-139.673,529.8535;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-230.0661,656.0699;Float;False;Property;_CenterMaskMultiply;Center Mask Multiply;20;0;Create;True;0;0;False;0;4;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;140;-2304.858,-1540.285;Float;False;float4 normalizeResultMY@$$for (int w = 0@ w < _AffectorCount@ w++) {$if(w == 0){$normalizeResultMY = normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 )@$}else{$normalizeResultMY = normalizeResultMY + normalize( ParticleCenterCE - _Affectors[w] ) * ( clamp( (0.0 + (( 1.0 - distance( ParticleCenterCE , _Affectors[w] ) + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 ) + 0.00001 )@$}$}$return normalize(normalizeResultMY)@;4;False;2;True;ParticleCenterCE;FLOAT4;0,0,0,0;In;;Float;False;True;AffectorsCE;FLOAT4;0,0,0,0;In;;Float;False;CE2;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;115;25.90511,52.74559;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;56.45676,575.2776;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;51;302.2741,764.8003;Float;False;Constant;_Vector0;Vector 0;8;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;118;125.9526,-48.14551;Float;False;Property;_VertexDistortionPower;Vertex Distortion Power;24;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;119;215.9899,48.42035;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-1,-1,-1;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;108;249.4375,451.1259;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1829.702,-1490.77;Float;False;CenterVector;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;50;330.274,920.8004;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;511.1227,42.56478;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;43;586.7905,730.4666;Float;False;Property;_OffsetPower;Offset Power;18;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;49;566.657,823.687;Float;False;Property;_OffsetYLock;Offset Y Lock;17;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;109;505.4623,524.6801;Float;False;Property;_CenterMaskEnabled;Center Mask Enabled;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;512.0356,157.9077;Float;False;Constant;_Float2;Float 2;24;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;548.5768,645.7773;Inherit;False;44;CenterVector;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;89;668.6508,-1830.123;Inherit;True;Property;_Albedo;Albedo;2;0;Create;True;0;0;False;0;-1;None;ded6b7fe70d527240a8209f20848b4ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;120;744.2634,78.4812;Float;False;Property;_VertexDistortionEnabled;Vertex Distortion Enabled;22;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;916.3195,638.3792;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;100;751.09,-2012.021;Float;False;Property;_ColorTint;Color Tint;3;0;Create;True;0;0;False;0;1,1,1,1;0.5588235,0.5588235,0.5588235,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;1071.65,-472.3644;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;91;341.8755,-1274.156;Inherit;True;Property;_Normal;Normal;7;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;765.0136,-1355.958;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;775.331,-1159.43;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;1054.089,-1918.02;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;96;730.9246,-539.3663;Float;False;Property;_Metallic;Metallic;5;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;1811.298,-804.6814;Float;False;Property;_LWRPAlphaClipThreshold;LWRP Alpha Clip Threshold;0;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;116;1370.645,339.3983;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;123;465.2533,-1443.465;Float;False;Constant;_Vector1;Vector 1;4;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;124;454.8826,-1062.489;Float;False;Constant;_Vector2;Vector 2;4;0;Create;True;0;0;False;0;-1,-1,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;1068.997,-300.0997;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;90;631.5461,-455.5333;Inherit;True;Property;_MetallicSmoothness;MetallicSmoothness;4;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;98;718.9246,-240.3667;Float;False;Property;_Smoothness;Smoothness;6;0;Create;True;0;0;False;0;0.5;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-2654.5,-1233.988;Float;False;Property;_AffectorCount;Affector Count;1;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;614.7059,-791.0023;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-425.3648,-819.9307;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;146.9107,-601.3729;Float;False;Property;_FinalPower;Final Power;11;0;Create;True;0;0;False;0;6;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1005.157,-912.1749;Inherit;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1078.105,-829.9976;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;12;0;Create;True;0;0;False;0;2;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-771.1036,-879.9979;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-621.119,-752.5731;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;125;1039.126,-1270.09;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;14;-697.9361,-1065.661;Float;False;Property;_FinalColor;Final Color;9;0;Create;True;0;0;False;0;1,0,0,1;1,0.755071,0.4926471,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;88;-614.2828,-883.5568;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-264.7276,-843.2589;Inherit;True;Property;_Ramp;Ramp;14;0;Create;True;0;0;False;0;-1;None;7150651ef88cabe44a1406ee9f810786;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;37;-371.767,-1167.51;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;128;139.5155,-511.5363;Inherit;True;Property;_Emission;Emission;8;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;81;202.7726,-894.6599;Float;False;Property;_RampEnabled;Ramp Enabled;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;52;233.7712,-787.0007;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-703.6391,-1252.178;Float;False;Property;_FinalColor2;Final Color 2;10;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;148;2309.443,-998.3845;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;145;2309.443,-998.3845;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;4;SineVFX/LivingParticles/LivingParticleMaskedPbrArrayURP;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;0;Forward;12;False;False;False;True;2;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;12;Workflow;1;Surface;0;  Blend;0;Two Sided;0;Cast Shadows;1;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;1;Built-in Fog;1;Meta Pass;1;Override Baked GI;0;Vertex Position,InvertActionOnDeselection;1;0;5;True;True;True;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;146;2309.443,-998.3845;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;147;2309.443,-998.3845;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;149;2309.443,-998.3845;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;4;Universal2D;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
WireConnection;17;0;137;3
WireConnection;17;1;137;4
WireConnection;17;2;138;1
WireConnection;141;0;17;0
WireConnection;141;1;143;0
WireConnection;45;0;141;0
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
WireConnection;111;0;113;0
WireConnection;111;3;122;0
WireConnection;101;0;55;0
WireConnection;101;1;103;0
WireConnection;114;0;111;0
WireConnection;105;0;101;0
WireConnection;140;0;17;0
WireConnection;140;1;143;0
WireConnection;115;0;114;0
WireConnection;115;1;114;1
WireConnection;115;2;114;2
WireConnection;106;0;105;0
WireConnection;106;1;107;0
WireConnection;119;0;115;0
WireConnection;108;0;55;0
WireConnection;108;1;106;0
WireConnection;44;0;140;0
WireConnection;117;0;118;0
WireConnection;117;1;119;0
WireConnection;49;1;50;0
WireConnection;49;0;51;0
WireConnection;109;1;55;0
WireConnection;109;0;108;0
WireConnection;120;1;121;0
WireConnection;120;0;117;0
WireConnection;42;0;109;0
WireConnection;42;1;46;0
WireConnection;42;2;43;0
WireConnection;42;3;49;0
WireConnection;95;0;96;0
WireConnection;95;1;90;1
WireConnection;126;0;123;0
WireConnection;126;1;91;0
WireConnection;127;0;91;0
WireConnection;127;1;124;0
WireConnection;99;0;100;0
WireConnection;99;1;89;0
WireConnection;116;0;120;0
WireConnection;116;1;42;0
WireConnection;97;0;90;4
WireConnection;97;1;98;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;52;4
WireConnection;3;4;128;1
WireConnection;83;0;88;0
WireConnection;83;1;84;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;125;0;126;0
WireConnection;125;1;127;0
WireConnection;88;0;85;0
WireConnection;82;1;83;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;88;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;145;0;99;0
WireConnection;145;1;125;0
WireConnection;145;2;3;0
WireConnection;145;3;95;0
WireConnection;145;4;97;0
WireConnection;145;6;89;4
WireConnection;145;7;139;0
WireConnection;145;8;116;0
ASEEND*/
//CHKSM=972169768AACDF8015692C3ACDC0B6A1B5B25C61