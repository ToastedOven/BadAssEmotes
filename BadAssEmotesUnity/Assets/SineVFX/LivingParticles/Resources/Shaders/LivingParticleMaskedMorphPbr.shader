// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleMaskedMorphPbr"
{
	Properties
	{
		[Toggle(_FLIPMORPHMASK_ON)] _FlipMorphMask("Flip Morph Mask", Float) = 0
		[Toggle(_FLIPEMISSIONMASK_ON)] _FlipEmissionMask("Flip Emission Mask", Float) = 0
		[Toggle(_FLIPOFFSETMASK_ON)] _FlipOffsetMask("Flip Offset Mask", Float) = 0
		_MorphMain("Morph Main", 2D) = "white" {}
		_MorphNormal("Morph Normal", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MetallicSmoothness("MetallicSmoothness", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0.5
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		_Normal("Normal", 2D) = "bump" {}
		_Emission("Emission", 2D) = "white" {}
		_FinalColorOne("Final Color One", Color) = (1,0,0,1)
		_FinalColorTwo("Final Color Two", Color) = (0,0,0,0)
		_FinalPower("Final Power", Range( 0 , 20)) = 6
		_FinalMaskMultiply("Final Mask Multiply", Range( 0 , 10)) = 2
		[Toggle(_RAMPENABLED_ON)] _RampEnabled("Ramp Enabled", Float) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_Distance("Distance", Float) = 1
		_DistancePower("Distance Power", Range( 0.2 , 4)) = 1
		_DistanceRemap("Distance Remap", Range( 1 , 4)) = 1
		[Toggle(_OFFSETYLOCK_ON)] _OffsetYLock("Offset Y Lock", Float) = 0
		_OffsetPower("Offset Power", Float) = 0
		[Toggle(_CENTERMASKENABLED_ON)] _CenterMaskEnabled("Center Mask Enabled", Float) = 0
		_CenterMaskMultiply("Center Mask Multiply", Float) = 4
		_CenterMaskSubtract("Center Mask Subtract", Float) = 0.75
		[Toggle(_VERTEXDISTORTIONENABLED_ON)] _VertexDistortionEnabled("Vertex Distortion Enabled", Float) = 0
		_VertexOffsetTexture("Vertex Offset Texture", 2D) = "white" {}
		_VertexDistortionPower("Vertex Distortion Power", Float) = 0.1
		_VertexDistortionTiling("Vertex Distortion Tiling", Float) = 1
		[Toggle(_USEGAMMARENDERING_ON)] _UseGammaRendering("Use Gamma Rendering", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
		#pragma shader_feature _CENTERMASKENABLED_ON
		#pragma shader_feature _FLIPOFFSETMASK_ON
		#pragma shader_feature _OFFSETYLOCK_ON
		#pragma shader_feature _USEGAMMARENDERING_ON
		#pragma shader_feature _FLIPMORPHMASK_ON
		#pragma shader_feature _RAMPENABLED_ON
		#pragma shader_feature _FLIPEMISSIONMASK_ON
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nolightmap  vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 uv3_tex4coord3;
			float4 vertexColor : COLOR;
		};

		uniform float _VertexDistortionPower;
		uniform sampler2D _VertexOffsetTexture;
		uniform float _VertexDistortionTiling;
		uniform float4 _Affector;
		uniform float _Distance;
		uniform float _DistanceRemap;
		uniform float _DistancePower;
		uniform float _CenterMaskSubtract;
		uniform float _CenterMaskMultiply;
		uniform float _OffsetPower;
		uniform sampler2D _MorphMain;
		uniform sampler2D _MorphNormal;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float4 _ColorTint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _FinalColorTwo;
		uniform float4 _FinalColorOne;
		uniform float _FinalMaskMultiply;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _Metallic;
		uniform sampler2D _MetallicSmoothness;
		uniform float4 _MetallicSmoothness_ST;
		uniform float _Smoothness;


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


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float4 triplanar111 = TriplanarSamplingSV( _VertexOffsetTexture, ase_worldPos, ase_worldNormal, 1.0, _VertexDistortionTiling, 1.0, 0 );
			float4 break114 = triplanar111;
			float3 appendResult115 = (float3(break114.x , break114.y , break114.z));
			#ifdef _VERTEXDISTORTIONENABLED_ON
				float3 staticSwitch120 = ( _VertexDistortionPower * (float3( -1,-1,-1 ) + (appendResult115 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) );
			#else
				float3 staticSwitch120 = temp_cast_0;
			#endif
			float4 appendResult17 = (float4(v.texcoord1.w , v.texcoord2.x , v.texcoord2.y , 0.0));
			float DistanceMask45 = ( 1.0 - distance( appendResult17 , _Affector ) );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (_DistanceRemap - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			#ifdef _FLIPOFFSETMASK_ON
				float staticSwitch225 = ( 1.0 - ResultMask53 );
			#else
				float staticSwitch225 = ResultMask53;
			#endif
			float clampResult105 = clamp( ( staticSwitch225 - _CenterMaskSubtract ) , 0.0 , 1.0 );
			#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( staticSwitch225 - ( clampResult105 * _CenterMaskMultiply ) );
			#else
				float staticSwitch109 = staticSwitch225;
			#endif
			float4 normalizeResult41 = normalize( ( appendResult17 - _Affector ) );
			float4 CenterVector44 = normalizeResult41;
			float3 temp_cast_2 = (1.0).xxx;
			#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
			#else
				float3 staticSwitch49 = temp_cast_2;
			#endif
			float3 appendResult218 = (float3(v.texcoord2.z , v.texcoord2.w , v.texcoord3.x));
			float3 RotationInRadian216 = -appendResult218;
			float3 break207 = RotationInRadian216;
			#ifdef _FLIPMORPHMASK_ON
				float staticSwitch202 = ( 1.0 - ResultMask53 );
			#else
				float staticSwitch202 = ResultMask53;
			#endif
			float2 appendResult177 = (float2(v.texcoord1.xy.x , ( v.texcoord1.xy.y + (-0.5 + (staticSwitch202 - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) )));
			float4 tex2DNode132 = tex2Dlod( _MorphMain, float4( appendResult177, 0, 0.0) );
			float3 gammaToLinear230 = GammaToLinearSpace( tex2DNode132.rgb );
			#ifdef _USEGAMMARENDERING_ON
				float4 staticSwitch229 = float4( gammaToLinear230 , 0.0 );
			#else
				float4 staticSwitch229 = tex2DNode132;
			#endif
			float4 break179 = staticSwitch229;
			float4 appendResult184 = (float4(( break179.r * -1.0 ) , ( break179.g * -1.0 ) , ( break179.b * 1.0 ) , ( break179.a * 1.0 )));
			float4 Morph186 = ( appendResult184 * v.texcoord1.z );
			float3 rotatedValue208 = RotateAroundAxis( float3( 0,0,0 ), Morph186.xyz, float3( 0,0,-1 ), break207.z );
			float3 rotatedValue210 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue208, float3( -1,0,0 ), break207.x );
			float3 rotatedValue213 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue210, float3( 0,-1,0 ), break207.y );
			float4 OffsetFinal154 = ( ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ) + float4( rotatedValue213 , 0.0 ) );
			v.vertex.xyz += OffsetFinal154.xyz;
			float3 break206 = RotationInRadian216;
			float4 break191 = tex2Dlod( _MorphNormal, float4( appendResult177, 0, 0.0) );
			float4 appendResult196 = (float4(( break191.r * 1.0 ) , ( break191.g * 1.0 ) , ( break191.b * 1.0 ) , ( break191.a * 1.0 )));
			float4 MorphNormals152 = (float4( 1,1,-1,-1 ) + (appendResult196 - float4( 0,0,0,0 )) * (float4( -1,-1,1,1 ) - float4( 1,1,-1,-1 )) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 )));
			float3 rotatedValue209 = RotateAroundAxis( float3( 0,0,0 ), MorphNormals152.xyz, float3( 0,0,-1 ), break206.z );
			float3 rotatedValue211 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue209, float3( -1,0,0 ), break206.x );
			float3 rotatedValue212 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue211, float3( 0,-1,0 ), break206.y );
			float3 VertexNormalsFinal222 = rotatedValue212;
			v.normal = VertexNormalsFinal222;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( _ColorTint * tex2D( _Albedo, uv_Albedo ) ).rgb;
			float4 appendResult17 = (float4(i.uv2_tex4coord2.w , i.uv3_tex4coord3.x , i.uv3_tex4coord3.y , 0.0));
			float DistanceMask45 = ( 1.0 - distance( appendResult17 , _Affector ) );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (_DistanceRemap - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			#ifdef _FLIPEMISSIONMASK_ON
				float staticSwitch223 = ( 1.0 - ResultMask53 );
			#else
				float staticSwitch223 = ResultMask53;
			#endif
			float clampResult88 = clamp( ( staticSwitch223 * _FinalMaskMultiply ) , 0.0 , 1.0 );
			float4 lerpResult37 = lerp( _FinalColorTwo , _FinalColorOne , clampResult88);
			float2 appendResult83 = (float2(clampResult88 , 0.0));
			#ifdef _RAMPENABLED_ON
				float4 staticSwitch81 = tex2D( _Ramp, appendResult83 );
			#else
				float4 staticSwitch81 = lerpResult37;
			#endif
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * tex2D( _Emission, uv_Emission ).r * i.vertexColor.a ).rgb;
			float2 uv_MetallicSmoothness = i.uv_texcoord * _MetallicSmoothness_ST.xy + _MetallicSmoothness_ST.zw;
			float4 tex2DNode90 = tex2D( _MetallicSmoothness, uv_MetallicSmoothness );
			o.Metallic = ( _Metallic * tex2DNode90.r );
			o.Smoothness = ( tex2DNode90.a * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16807
7;29;1906;1004;3210.605;1093.555;3.764763;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;175;-2992.718,-1074.403;Float;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;174;-2993.354,-1245.181;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2674.528,-1127.697;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;20;-2718.477,-973.0436;Float;False;Global;_Affector;_Affector;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;19;-2421.068,-973.3565;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-2245.944,-972.6654;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2038.447,-979.4384;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2935.004,-317.4798;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2935.559,-420.2718;Float;False;Property;_Distance;Distance;18;0;Create;True;0;0;False;0;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-2998.05,-515.4072;Float;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-2744.894,-377.8731;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2496.794,-445.7886;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2517.094,-496.4949;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;227;-2690.188,-642.8907;Float;False;Property;_DistanceRemap;Distance Remap;20;0;Create;True;0;0;False;0;1;1;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2237.74,-531.2965;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2053.557,-530.7089;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2255.449,-360.2385;Float;False;Property;_DistancePower;Distance Power;19;0;Create;True;0;0;False;0;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-1818.45,-450.2388;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1637.644,-457.1917;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;-3366.347,1857.43;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;203;-3180.155,2059.244;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;202;-3005.155,1959.243;Float;False;Property;_FlipMorphMask;Flip Morph Mask;0;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;187;-2707.247,1962.092;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.5;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;189;-2697.35,1611.004;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;176;-2474.264,1856.568;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;177;-2280.953,1743.604;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;132;-1947.373,1486.319;Float;True;Property;_MorphMain;Morph Main;3;0;Create;True;0;0;False;0;None;0375bff8996bd734e96bd48295092eeb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GammaToLinearNode;230;-2028.139,1064.319;Float;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;229;-1797.834,1032.073;Float;False;Property;_UseGammaRendering;Use Gamma Rendering;30;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1046.615,398.8686;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;179;-1603.782,1491.728;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TexCoordVertexDataNode;219;-2902.337,-124.1142;Float;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;220;-2901.315,152.3236;Float;False;3;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;133;-1928.339,1978.218;Float;True;Property;_MorphNormal;Morph Normal;4;0;Create;True;0;0;False;0;None;9415ef6bad22e604bae687c3adc0ee3f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;226;-829.6511,528.6901;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-1256.783,1482.728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-1253.783,1583.728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-1251.782,1688.729;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;183;-1260.783,1389.728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;218;-2615.314,23.32343;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;191;-1579.565,1989.366;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;122;-948.1693,174.6511;Float;False;Property;_VertexDistortionTiling;Vertex Distortion Tiling;29;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-535.1007,624.9363;Float;False;Property;_CenterMaskSubtract;Center Mask Subtract;25;0;Create;True;0;0;False;0;0.75;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;113;-927.8683,-18.3929;Float;True;Property;_VertexOffsetTexture;Vertex Offset Texture;27;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.StaticSwitch;225;-635.4039,395.0158;Float;False;Property;_FlipOffsetMask;Flip Offset Mask;2;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;199;-983.8941,1728.685;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-1271.831,2026.093;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;192;-1268.178,1933.093;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;217;-2458.654,21.65442;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;184;-991.3842,1501.629;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TriplanarNode;111;-637.6868,55.03267;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-1263.429,2226.967;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;101;-284.7973,531.0767;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-1264.679,2127.093;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;216;-2311.828,16.77723;Float;False;RotationInRadian;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-2414.754,-1126.474;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-631.4807,1623.868;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;196;-1020.052,2037.466;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;105;-139.673,529.8535;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;114;-277.9813,55.32092;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1461.157,-1010.175;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-230.0661,656.0699;Float;False;Property;_CenterMaskMultiply;Center Mask Multiply;24;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;115;25.90511,52.74559;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;41;-2248.858,-1125.48;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;-472.9491,1621.167;Float;False;Morph;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;197;-763.6547,2035.365;Float;False;5;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;1,1,1,1;False;3;FLOAT4;1,1,-1,-1;False;4;FLOAT4;-1,-1,1,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;205;440.1099,1470.168;Float;False;216;RotationInRadian;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;56.45676,575.2776;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;224;-1232.336,-923.7797;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-2040.929,-1116.846;Float;False;CenterVector;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;50;330.274,920.8004;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;125.9526,-48.14551;Float;False;Property;_VertexDistortionPower;Vertex Distortion Power;28;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;214;759.9273,1599.658;Float;False;186;Morph;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-558.2183,2031.605;Float;False;MorphNormals;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;119;215.9899,48.42035;Float;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-1,-1,-1;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;204;434.9919,2093.339;Float;False;216;RotationInRadian;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1078.105,-829.9976;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;15;0;Create;True;0;0;False;0;2;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;223;-1057.479,-1005.835;Float;False;Property;_FlipEmissionMask;Flip Emission Mask;1;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;51;302.2741,764.8003;Float;False;Constant;_Vector0;Vector 0;8;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;108;249.4375,451.1259;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;207;701.7459,1473.542;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RotateAboutAxisNode;208;1080.517,1622.996;Float;False;False;4;0;FLOAT3;0,0,-1;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;109;505.4623,524.6801;Float;False;Property;_CenterMaskEnabled;Center Mask Enabled;23;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;548.5768,645.7773;Float;False;44;CenterVector;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;121;512.0356,157.9077;Float;False;Constant;_Float2;Float 2;24;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;511.1227,42.56478;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;49;566.657,823.687;Float;False;Property;_OffsetYLock;Offset Y Lock;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;43;586.7905,730.4666;Float;False;Property;_OffsetPower;Offset Power;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-771.1036,-879.9979;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;215;735.9254,2223.337;Float;False;152;MorphNormals;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;206;696.6832,2099.552;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RotateAboutAxisNode;209;1096.626,2230.124;Float;False;False;4;0;FLOAT3;0,0,-1;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;120;744.2634,78.4812;Float;False;Property;_VertexDistortionEnabled;Vertex Distortion Enabled;26;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;916.3195,638.3792;Float;False;4;4;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;210;1087.143,1312.103;Float;False;False;4;0;FLOAT3;-1,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-621.119,-752.5731;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-614.2828,-883.5568;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;211;1096.92,1926.641;Float;False;False;4;0;FLOAT3;-1,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;116;1370.645,339.3983;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;213;1091.009,1459.852;Float;False;False;4;0;FLOAT3;0,-1,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;14;-697.9361,-1065.661;Float;False;Property;_FinalColorOne;Final Color One;12;0;Create;True;0;0;False;0;1,0,0,1;1,0.517647,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;83;-425.3648,-819.9307;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;36;-703.6391,-1252.178;Float;False;Property;_FinalColorTwo;Final Color Two;13;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;150;1752.162,919.6628;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;212;1096.626,2072.916;Float;False;False;4;0;FLOAT3;0,-1,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;37;-371.767,-1167.51;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;82;-264.7276,-843.2589;Float;True;Property;_Ramp;Ramp;17;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;90;663.0696,-445.9392;Float;True;Property;_MetallicSmoothness;MetallicSmoothness;7;0;Create;True;0;0;False;0;None;c96026a5450b02c4b90d63fd9238e59f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;98;835.4246,-234.8844;Float;False;Property;_Smoothness;Smoothness;9;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;1913.964,917.308;Float;False;OffsetFinal;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;1464.209,2073.557;Float;False;VertexNormalsFinal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;4;146.9107,-601.3729;Float;False;Property;_FinalPower;Final Power;14;0;Create;True;0;0;False;0;6;12;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;847.4246,-533.884;Float;False;Property;_Metallic;Metallic;8;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;89;1209.255,-1494.071;Float;True;Property;_Albedo;Albedo;5;0;Create;True;0;0;False;0;None;20d714081e9fac74e99ad3c851a18b66;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;100;1435.369,-1678.405;Float;False;Property;_ColorTint;Color Tint;6;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;173;134.2945,-512.4421;Float;True;Property;_Emission;Emission;11;0;Create;True;0;0;False;0;None;7c2971a298af5674ea309ad2022930e8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;52;233.7712,-787.0007;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;81;202.7726,-894.6599;Float;False;Property;_RampEnabled;Ramp Enabled;16;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;1188.15,-466.882;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;1738.369,-1584.404;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;1562.148,-504.5751;Float;False;222;VertexNormalsFinal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;1618.419,-601.6031;Float;False;154;OffsetFinal;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;91;1299.092,-1279.551;Float;True;Property;_Normal;Normal;10;0;Create;True;0;0;False;0;None;c1b2383bc664c7c46bfbac4fe51e810b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;1185.497,-294.6173;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;614.7059,-791.0023;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;15;1942.617,-985.7353;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SineVFX/LivingParticles/LivingParticleMaskedMorphPbr;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;174;4
WireConnection;17;1;175;1
WireConnection;17;2;175;2
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;22;0;19;0
WireConnection;45;0;22;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;24;0;47;0
WireConnection;24;1;26;0
WireConnection;31;0;25;0
WireConnection;28;0;24;0
WireConnection;28;2;31;0
WireConnection;28;4;227;0
WireConnection;23;0;28;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;53;0;33;0
WireConnection;203;0;200;0
WireConnection;202;1;200;0
WireConnection;202;0;203;0
WireConnection;187;0;202;0
WireConnection;176;0;189;2
WireConnection;176;1;187;0
WireConnection;177;0;189;1
WireConnection;177;1;176;0
WireConnection;132;1;177;0
WireConnection;230;0;132;0
WireConnection;229;1;132;0
WireConnection;229;0;230;0
WireConnection;179;0;229;0
WireConnection;133;1;177;0
WireConnection;226;0;55;0
WireConnection;180;0;179;1
WireConnection;181;0;179;2
WireConnection;182;0;179;3
WireConnection;183;0;179;0
WireConnection;218;0;219;3
WireConnection;218;1;219;4
WireConnection;218;2;220;1
WireConnection;191;0;133;0
WireConnection;225;1;55;0
WireConnection;225;0;226;0
WireConnection;194;0;191;1
WireConnection;192;0;191;0
WireConnection;217;0;218;0
WireConnection;184;0;183;0
WireConnection;184;1;180;0
WireConnection;184;2;181;0
WireConnection;184;3;182;0
WireConnection;111;0;113;0
WireConnection;111;3;122;0
WireConnection;193;0;191;3
WireConnection;101;0;225;0
WireConnection;101;1;103;0
WireConnection;195;0;191;2
WireConnection;216;0;217;0
WireConnection;39;0;17;0
WireConnection;39;1;20;0
WireConnection;185;0;184;0
WireConnection;185;1;199;3
WireConnection;196;0;192;0
WireConnection;196;1;194;0
WireConnection;196;2;195;0
WireConnection;196;3;193;0
WireConnection;105;0;101;0
WireConnection;114;0;111;0
WireConnection;115;0;114;0
WireConnection;115;1;114;1
WireConnection;115;2;114;2
WireConnection;41;0;39;0
WireConnection;186;0;185;0
WireConnection;197;0;196;0
WireConnection;106;0;105;0
WireConnection;106;1;107;0
WireConnection;224;0;54;0
WireConnection;44;0;41;0
WireConnection;152;0;197;0
WireConnection;119;0;115;0
WireConnection;223;1;54;0
WireConnection;223;0;224;0
WireConnection;108;0;225;0
WireConnection;108;1;106;0
WireConnection;207;0;205;0
WireConnection;208;1;207;2
WireConnection;208;3;214;0
WireConnection;109;1;225;0
WireConnection;109;0;108;0
WireConnection;117;0;118;0
WireConnection;117;1;119;0
WireConnection;49;1;50;0
WireConnection;49;0;51;0
WireConnection;85;0;223;0
WireConnection;85;1;86;0
WireConnection;206;0;204;0
WireConnection;209;1;206;2
WireConnection;209;3;215;0
WireConnection;120;1;121;0
WireConnection;120;0;117;0
WireConnection;42;0;109;0
WireConnection;42;1;46;0
WireConnection;42;2;43;0
WireConnection;42;3;49;0
WireConnection;210;1;207;0
WireConnection;210;3;208;0
WireConnection;88;0;85;0
WireConnection;211;1;206;0
WireConnection;211;3;209;0
WireConnection;116;0;120;0
WireConnection;116;1;42;0
WireConnection;213;1;207;1
WireConnection;213;3;210;0
WireConnection;83;0;88;0
WireConnection;83;1;84;0
WireConnection;150;0;116;0
WireConnection;150;1;213;0
WireConnection;212;1;206;1
WireConnection;212;3;211;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;88;0
WireConnection;82;1;83;0
WireConnection;154;0;150;0
WireConnection;222;0;212;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;95;0;96;0
WireConnection;95;1;90;1
WireConnection;99;0;100;0
WireConnection;99;1;89;0
WireConnection;97;0;90;4
WireConnection;97;1;98;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;173;1
WireConnection;3;4;52;4
WireConnection;15;0;99;0
WireConnection;15;1;91;0
WireConnection;15;2;3;0
WireConnection;15;3;95;0
WireConnection;15;4;97;0
WireConnection;15;11;155;0
WireConnection;15;12;153;0
ASEEND*/
//CHKSM=4FE4A08C0F6B9B6E55708F6108CB9A3FEB62F7BF