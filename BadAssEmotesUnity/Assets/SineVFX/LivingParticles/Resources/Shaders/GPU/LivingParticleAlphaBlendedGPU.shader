// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/GPU/LivingParticleAlphaBlendedGPU"
{
	Properties
	{
		_FinalTexture("Final Texture", 2D) = "white" {}
		_FinalColor("Final Color", Color) = (1,0,0,1)
		_FinalColor2("Final Color 2", Color) = (0,0,0,0)
		_FinalPower("Final Power", Range( 0 , 20)) = 6
		_FinalMaskMultiply("Final Mask Multiply", Range( 0 , 10)) = 2
		[Toggle(_RAMPENABLED_ON)] _RampEnabled("Ramp Enabled", Float) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_RampColorTint("Ramp Color Tint", Color) = (1,1,1,1)
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
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _OFFSETYLOCK_ON
		#pragma shader_feature _RAMPENABLED_ON
		#pragma shader_feature _MASKAFFECTSTRANSPARENCY_ON
		#pragma shader_feature _CAMERAFADEENABLED_ON
		#pragma shader_feature _CLOSEFADEENABLED_ON
		#define UNITY_PARTICLE_INSTANCE_DATA MyParticleInstanceData
		#define UNITY_PARTICLE_INSTANCE_DATA_NO_ANIM_FRAME
		#include "GPUinclude03.cginc"
		#include "UnityStandardParticleInstancing.cginc"
		#pragma instancing_options procedural:vertInstancingSetup
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_tex4coord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 screenPos;
			float eyeDepth;
		};

		uniform float4 _Affector;
		uniform float _Distance;
		uniform float _DistancePower;
		uniform float _OffsetPower;
		uniform float4 _FinalColor2;
		uniform float4 _FinalColor;
		uniform float _FinalMaskMultiply;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform float4 _RampColorTint;
		uniform sampler2D _FinalTexture;
		uniform float4 _FinalTexture_ST;
		uniform sampler2D _CameraDepthTexture;
		uniform float _SoftParticleDistance;
		uniform float _CameraFadeDistance;
		uniform float _CameraFadeOffset;
		uniform float _CloseFadeDistance;
		uniform float _MaskOpacityPower;


		float3 GetGPUCenter111( float3 RegularCenter )
		{
			float3 outCenter = RegularCenter;
			#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)
			UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID];
			outCenter = data.center;
			#endif
			return outCenter;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 appendResult17 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			float3 RegularCenter111 = appendResult17.xyz;
			float3 localGetGPUCenter111 = GetGPUCenter111( RegularCenter111 );
			float DistanceMask45 = ( 1.0 - distance( float4( localGetGPUCenter111 , 0.0 ) , _Affector ) );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float temp_output_33_0 = pow( clampResult23 , _DistancePower );
			float ResultMask53 = temp_output_33_0;
			float4 normalizeResult41 = normalize( ( float4( localGetGPUCenter111 , 0.0 ) - _Affector ) );
			float4 CenterVector44 = normalizeResult41;
			float3 temp_cast_3 = (1.0).xxx;
			#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
			#else
				float3 staticSwitch49 = temp_cast_3;
			#endif
			float4 transform121 = mul(unity_WorldToObject,( CenterVector44 * float4( staticSwitch49 , 0.0 ) ));
			v.vertex.xyz += ( ResultMask53 * transform121 * _OffsetPower ).xyz;
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 appendResult17 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float3 RegularCenter111 = appendResult17.xyz;
			float3 localGetGPUCenter111 = GetGPUCenter111( RegularCenter111 );
			float DistanceMask45 = ( 1.0 - distance( float4( localGetGPUCenter111 , 0.0 ) , _Affector ) );
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
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * _RampColorTint ).rgb;
			float2 uv_FinalTexture = i.uv_texcoord * _FinalTexture_ST.xy + _FinalTexture_ST.zw;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth56 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth56 = abs( ( screenDepth56 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _SoftParticleDistance ) );
			float clampResult58 = clamp( distanceDepth56 , 0.0 , 1.0 );
			float cameraDepthFade60 = (( i.eyeDepth -_ProjectionParams.y - _CameraFadeOffset ) / _CameraFadeDistance);
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
			float temp_output_57_0 = ( tex2D( _FinalTexture, uv_FinalTexture ).r * clampResult58 * staticSwitch63 * ( 1.0 - TooClose75 ) * i.vertexColor.a );
			float3 desaturateInitialColor95 = staticSwitch81.rgb;
			float desaturateDot95 = dot( desaturateInitialColor95, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar95 = lerp( desaturateInitialColor95, desaturateDot95.xxx, 1.0 );
			#ifdef _MASKAFFECTSTRANSPARENCY_ON
				float staticSwitch91 = ( _MaskOpacityPower * desaturateVar95.x * temp_output_57_0 );
			#else
				float staticSwitch91 = temp_output_57_0;
			#endif
			float clampResult74 = clamp( staticSwitch91 , 0.0 , 1.0 );
			o.Alpha = clampResult74;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15702
7;29;1906;1004;899.0638;1205.006;1;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;103;-3002.528,-1035.468;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;102;-3009.528,-1284.468;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2675.389,-1119.477;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;20;-2719.338,-964.8239;Float;False;Global;_Affector;_Affector;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;111;-2574.772,-1312.487;Float;False;float3 outCenter = RegularCenter@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outCenter = data.center@$#endif$return outCenter@;3;False;1;True;RegularCenter;FLOAT3;0,0,0;In;;Float;GetGPUCenter;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;19;-2421.929,-965.1368;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-2246.804,-964.4457;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3451.799,73.12525;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3452.354,-29.66669;Float;False;Property;_Distance;Distance;8;0;Create;True;0;0;False;0;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2039.307,-971.2188;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-3261.688,12.73193;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-3514.844,-124.8021;Float;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-3033.888,-105.8898;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-3013.589,-55.18353;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2754.534,-140.6913;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2570.352,-140.1038;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2772.243,30.36653;Float;False;Property;_DistancePower;Distance Power;9;0;Create;True;0;0;False;0;1;4;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-2335.243,-59.63376;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2323.462,-404.4654;Float;False;Property;_CloseFadeDistance;Close Fade Distance;16;0;Create;True;0;0;False;0;0.65;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1977.432,183.3593;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1251.323,-1023.654;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;4;0;Create;True;0;0;False;0;2;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;-2068.815,-387.3524;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2069.815,-286.3523;Float;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1178.375,-1105.831;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-1904.428,-382.739;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-944.322,-1073.654;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-787.5012,-1077.213;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-794.3374,-946.2294;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1752.043,-248.3803;Float;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;71;-1753.815,-384.3524;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;78;-1578.043,-334.3803;Float;False;Property;_CloseFadeEnabled;Close Fade Enabled;15;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;-876.8575,-1445.834;Float;False;Property;_FinalColor2;Final Color 2;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;83;-598.5833,-1013.587;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-974.0292,22.55648;Float;False;Property;_CameraFadeOffset;Camera Fade Offset;14;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-988.7389,-89.43237;Float;False;Property;_CameraFadeDistance;Camera Fade Distance;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-871.1545,-1259.316;Float;False;Property;_FinalColor;Final Color;1;0;Create;True;0;0;False;0;1,0,0,1;0.5294118,1,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-1307.04,-333.401;Float;False;TooClose;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-437.946,-1036.915;Float;True;Property;_Ramp;Ramp;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-2415.615,-1118.254;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;37;-544.9852,-1361.165;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-951.0761,-194.5438;Float;False;Property;_SoftParticleDistance;Soft Particle Distance;17;0;Create;True;0;0;False;0;0.25;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;60;-724.1724,-62.91924;Float;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;45.88528,-1095.46;Float;False;Property;_RampEnabled;Ramp Enabled;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;41;-2249.719,-1117.26;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DepthFade;56;-684.449,-192.5485;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;61;-385.0013,-61.80219;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-334.5116,153.5335;Float;False;75;TooClose;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-386.9198,56.40814;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;95;335.2216,-572.99;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;51;-504.572,1001.77;Float;False;Constant;_Vector0;Vector 0;8;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-2045.516,-1119.806;Float;False;CenterVector;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-476.5721,1157.769;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;101;-534.2034,-388.7517;Float;True;Property;_FinalTexture;Final Texture;0;0;Create;True;0;0;False;0;None;e52c6f3ff68523c4299e081e72006a04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;58;-387.9864,-188.9068;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;52;-439.9725,-713.249;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;80;-92.39857,147.2609;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;63;-182.9198,-21.59186;Float;False;Property;_CameraFadeEnabled;Camera Fade Enabled;12;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-258.27,882.7471;Float;False;44;CenterVector;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;49;-240.1896,1060.656;Float;False;Property;_OffsetYLock;Offset Y Lock;11;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;97;483.5101,-660.0831;Float;False;Property;_MaskOpacityPower;Mask Opacity Power;19;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;96;507.9224,-570.6298;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;158.9322,-246.9111;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-48.9557,879.2641;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;842.0498,-588.5196;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-220.0562,967.436;Float;False;Property;_OffsetPower;Offset Power;10;0;Create;True;0;0;False;0;0;4.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;121;-57.29014,537.6752;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;55;-249.978,792.1231;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;1144.967,-396.0954;Float;False;Property;_MaskAffectsTransparency;Mask Affects Transparency;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;125;-347.9052,-846.6775;Float;False;Property;_RampColorTint;Ramp Color Tint;7;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-30.49794,-980.2728;Float;False;Property;_FinalPower;Final Power;3;0;Create;True;0;0;False;0;6;8;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;113;-0.3481445,1224.956;Float;False;float outSize = RegularSize@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outSize = data.size@$#endif$return outSize@;1;False;1;True;RegularSize;FLOAT;0;In;;Float;GetGPUCenter;True;False;0;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;109.472,875.3488;Float;False;3;3;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;116;-173.2682,-662.5142;Float;False;uint outColor = RegularColor@$#if defined(UNITY_PARTICLE_INSTANCING_ENABLED)$UNITY_PARTICLE_INSTANCE_DATA data = unity_ParticleInstanceData[unity_InstanceID]@$outColor = data.color@$#endif$return outColor@;4;False;1;True;RegularColor;FLOAT4;0,0,0,0;In;;Float;GetGPUCenter;True;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;118;129.6523,-419.8219;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;74;1489.643,-390.9211;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;441.4877,-984.6585;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;112;-200.9908,1179.741;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;117;-21.58776,-570.8507;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;114;220.4509,1225.327;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;259.4509,1089.327;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;110;2555.304,-451.5145;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SineVFX/LivingParticles/GPU/LivingParticleAlphaBlendedGPU;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;5;Define;UNITY_PARTICLE_INSTANCE_DATA MyParticleInstanceData;False;;Define;UNITY_PARTICLE_INSTANCE_DATA_NO_ANIM_FRAME;False;;Include;GPUinclude03.cginc;False;;Include;UnityStandardParticleInstancing.cginc;False;;Pragma;instancing_options procedural:vertInstancingSetup;False;;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;102;3
WireConnection;17;1;102;4
WireConnection;17;2;103;1
WireConnection;111;0;17;0
WireConnection;19;0;111;0
WireConnection;19;1;20;0
WireConnection;22;0;19;0
WireConnection;45;0;22;0
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
WireConnection;68;0;66;0
WireConnection;68;1;69;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;88;0;85;0
WireConnection;71;0;68;0
WireConnection;78;1;79;0
WireConnection;78;0;71;0
WireConnection;83;0;88;0
WireConnection;83;1;84;0
WireConnection;75;0;78;0
WireConnection;82;1;83;0
WireConnection;39;0;111;0
WireConnection;39;1;20;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;88;0
WireConnection;60;0;62;0
WireConnection;60;1;65;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;41;0;39;0
WireConnection;56;0;59;0
WireConnection;61;0;60;0
WireConnection;95;0;81;0
WireConnection;44;0;41;0
WireConnection;58;0;56;0
WireConnection;80;0;77;0
WireConnection;63;1;64;0
WireConnection;63;0;61;0
WireConnection;49;1;50;0
WireConnection;49;0;51;0
WireConnection;96;0;95;0
WireConnection;57;0;101;1
WireConnection;57;1;58;0
WireConnection;57;2;63;0
WireConnection;57;3;80;0
WireConnection;57;4;52;4
WireConnection;124;0;46;0
WireConnection;124;1;49;0
WireConnection;93;0;97;0
WireConnection;93;1;96;0
WireConnection;93;2;57;0
WireConnection;121;0;124;0
WireConnection;91;1;57;0
WireConnection;91;0;93;0
WireConnection;113;0;112;2
WireConnection;42;0;55;0
WireConnection;42;1;121;0
WireConnection;42;2;43;0
WireConnection;116;0;52;0
WireConnection;118;0;117;3
WireConnection;74;0;91;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;125;0
WireConnection;117;0;116;0
WireConnection;114;0;113;0
WireConnection;115;0;43;0
WireConnection;115;1;113;0
WireConnection;110;2;3;0
WireConnection;110;9;74;0
WireConnection;110;11;42;0
ASEEND*/
//CHKSM=3711235098DF0A64547E9EB16D76BC11172C2EC6