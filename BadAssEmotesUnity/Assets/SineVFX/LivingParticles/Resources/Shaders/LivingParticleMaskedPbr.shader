// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/LivingParticles/LivingParticleMaskedPbr"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
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
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _VERTEXDISTORTIONENABLED_ON
		#pragma shader_feature _CENTERMASKENABLED_ON
		#pragma shader_feature _OFFSETYLOCK_ON
		#pragma shader_feature _RAMPENABLED_ON
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nolightmap  vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 uv_tex4coord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float _VertexDistortionPower;
		uniform sampler2D _VertexOffsetTexture;
		uniform float _VertexDistortionTiling;
		uniform float4 _Affector;
		uniform float _Distance;
		uniform float _DistancePower;
		uniform float _CenterMaskSubtract;
		uniform float _CenterMaskMultiply;
		uniform float _OffsetPower;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float4 _ColorTint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _FinalColor2;
		uniform float4 _FinalColor;
		uniform float _FinalMaskMultiply;
		uniform sampler2D _Ramp;
		uniform float _FinalPower;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _Metallic;
		uniform sampler2D _MetallicSmoothness;
		uniform float4 _MetallicSmoothness_ST;
		uniform float _Smoothness;
		uniform float _Cutoff = 0.5;


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
			float4 appendResult17 = (float4(v.texcoord.z , v.texcoord.w , v.texcoord1.x , 0.0));
			float DistanceMask45 = ( 1.0 - distance( appendResult17 , _Affector ) );
			float clampResult23 = clamp( (0.0 + (( DistanceMask45 + ( _Distance - 1.0 ) ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0)) , 0.0 , 1.0 );
			float ResultMask53 = pow( clampResult23 , _DistancePower );
			float clampResult105 = clamp( ( ResultMask53 - _CenterMaskSubtract ) , 0.0 , 1.0 );
			#ifdef _CENTERMASKENABLED_ON
				float staticSwitch109 = ( ResultMask53 - ( clampResult105 * _CenterMaskMultiply ) );
			#else
				float staticSwitch109 = ResultMask53;
			#endif
			float4 normalizeResult41 = normalize( ( appendResult17 - _Affector ) );
			float4 CenterVector44 = normalizeResult41;
			float3 temp_cast_2 = (1.0).xxx;
			#ifdef _OFFSETYLOCK_ON
				float3 staticSwitch49 = float3(1,0,1);
			#else
				float3 staticSwitch49 = temp_cast_2;
			#endif
			v.vertex.xyz += ( float4( staticSwitch120 , 0.0 ) + ( staticSwitch109 * CenterVector44 * _OffsetPower * float4( staticSwitch49 , 0.0 ) ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode91 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float3 switchResult125 = (((i.ASEVFace>0)?(( float3(1,1,1) * tex2DNode91 )):(( tex2DNode91 * float3(-1,-1,-1) ))));
			o.Normal = switchResult125;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode89 = tex2D( _Albedo, uv_Albedo );
			o.Albedo = ( _ColorTint * tex2DNode89 ).rgb;
			float4 appendResult17 = (float4(i.uv_tex4coord.z , i.uv_tex4coord.w , i.uv2_tex4coord2.x , 0.0));
			float DistanceMask45 = ( 1.0 - distance( appendResult17 , _Affector ) );
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
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( staticSwitch81 * i.vertexColor * _FinalPower * i.vertexColor.a * tex2D( _Emission, uv_Emission ).r ).rgb;
			float2 uv_MetallicSmoothness = i.uv_texcoord * _MetallicSmoothness_ST.xy + _MetallicSmoothness_ST.zw;
			float4 tex2DNode90 = tex2D( _MetallicSmoothness, uv_MetallicSmoothness );
			o.Metallic = ( _Metallic * tex2DNode90.r );
			o.Smoothness = ( tex2DNode90.a * _Smoothness );
			o.Alpha = 1;
			clip( tex2DNode89.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16807
7;29;1906;1004;3247.996;1463.043;1;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;138;-2614.015,-1061.491;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;137;-2615.015,-1255.491;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2254.112,-1138.477;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;20;-2298.061,-983.8236;Float;False;Global;_Affector;_Affector;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;19;-2000.652,-984.1365;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-1825.528,-983.4454;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-1618.031,-990.2184;Float;False;DistanceMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2935.004,-317.4798;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2935.559,-420.2718;Float;False;Property;_Distance;Distance;14;0;Create;True;0;0;False;0;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-2998.05,-515.4072;Float;False;45;DistanceMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-2744.894,-377.8731;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2496.794,-445.7886;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;31;-2517.094,-496.4949;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-2237.74,-531.2965;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;23;-2053.557,-530.7089;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2255.449,-360.2385;Float;False;Property;_DistancePower;Distance Power;15;0;Create;True;0;0;False;0;1;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-1818.45,-450.2388;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1577.542,-444.0035;Float;False;ResultMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-535.1007,624.9363;Float;False;Property;_CenterMaskSubtract;Center Mask Subtract;20;0;Create;True;0;0;False;0;0.75;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-948.1693,174.6511;Float;False;Property;_VertexDistortionTiling;Vertex Distortion Tiling;24;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-508.0141,426.6689;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;113;-927.8683,-18.3929;Float;True;Property;_VertexOffsetTexture;Vertex Offset Texture;22;0;Create;True;0;0;False;0;None;f5b6873a85b11e24b9f21dcd42486c09;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1005.157,-912.1749;Float;False;53;ResultMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;101;-284.7973,531.0767;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1078.105,-829.9976;Float;False;Property;_FinalMaskMultiply;Final Mask Multiply;11;0;Create;True;0;0;False;0;2;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;111;-637.6868,55.03267;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-1994.338,-1137.254;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-771.1036,-879.9979;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;105;-139.673,529.8535;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-230.0661,656.0699;Float;False;Property;_CenterMaskMultiply;Center Mask Multiply;19;0;Create;True;0;0;False;0;4;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;114;-277.9813,55.32092;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;115;25.90511,52.74559;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;41;-1828.442,-1136.26;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-621.119,-752.5731;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;56.45676,575.2776;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;88;-614.2828,-883.5568;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-425.3648,-819.9307;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;119;215.9899,48.42035;Float;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-1,-1,-1;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;36;-703.6391,-1252.178;Float;False;Property;_FinalColor2;Final Color 2;9;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;51;302.2741,764.8003;Float;False;Constant;_Vector0;Vector 0;8;0;Create;True;0;0;False;0;1,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;50;330.274,920.8004;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;125.9526,-48.14551;Float;False;Property;_VertexDistortionPower;Vertex Distortion Power;23;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-697.9361,-1065.661;Float;False;Property;_FinalColor;Final Color;8;0;Create;True;0;0;False;0;1,0,0,1;1,0.755071,0.4926471,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1620.513,-1127.626;Float;False;CenterVector;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;108;249.4375,451.1259;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;124;454.8826,-1062.489;Float;False;Constant;_Vector2;Vector 2;4;0;Create;True;0;0;False;0;-1,-1,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;91;341.8755,-1274.156;Float;True;Property;_Normal;Normal;6;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;586.7905,730.4666;Float;False;Property;_OffsetPower;Offset Power;17;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;512.0356,157.9077;Float;False;Constant;_Float2;Float 2;24;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-264.7276,-843.2589;Float;True;Property;_Ramp;Ramp;13;0;Create;True;0;0;False;0;None;7150651ef88cabe44a1406ee9f810786;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;37;-371.767,-1167.51;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;511.1227,42.56478;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;49;566.657,823.687;Float;False;Property;_OffsetYLock;Offset Y Lock;16;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;109;505.4623,524.6801;Float;False;Property;_CenterMaskEnabled;Center Mask Enabled;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;123;465.2533,-1443.465;Float;False;Constant;_Vector1;Vector 1;4;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;46;548.5768,645.7773;Float;False;44;CenterVector;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;100;751.09,-2012.021;Float;False;Property;_ColorTint;Color Tint;2;0;Create;True;0;0;False;0;1,1,1,1;0.5588235,0.5588235,0.5588235,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;765.0136,-1355.958;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;96;730.9246,-539.3663;Float;False;Property;_Metallic;Metallic;4;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;120;744.2634,78.4812;Float;False;Property;_VertexDistortionEnabled;Vertex Distortion Enabled;21;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;89;668.6508,-1830.123;Float;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;False;0;None;ded6b7fe70d527240a8209f20848b4ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;146.9107,-601.3729;Float;False;Property;_FinalPower;Final Power;10;0;Create;True;0;0;False;0;6;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;775.331,-1159.43;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexColorNode;52;233.7712,-787.0007;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;90;631.5461,-455.5333;Float;True;Property;_MetallicSmoothness;MetallicSmoothness;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;81;202.7726,-894.6599;Float;False;Property;_RampEnabled;Ramp Enabled;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;916.3195,638.3792;Float;False;4;4;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;98;718.9246,-240.3667;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;0.5;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;139.5155,-511.5363;Float;True;Property;_Emission;Emission;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;125;1039.126,-1270.09;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;1071.65,-472.3644;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;1054.089,-1918.02;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;116;1370.645,339.3983;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;614.7059,-791.0023;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;1068.997,-300.0997;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;163;2694.549,-1081.377;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SineVFX/LivingParticles/LivingParticleMaskedPbr;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;137;3
WireConnection;17;1;137;4
WireConnection;17;2;138;1
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
WireConnection;23;0;28;0
WireConnection;33;0;23;0
WireConnection;33;1;34;0
WireConnection;53;0;33;0
WireConnection;101;0;55;0
WireConnection;101;1;103;0
WireConnection;111;0;113;0
WireConnection;111;3;122;0
WireConnection;39;0;17;0
WireConnection;39;1;20;0
WireConnection;85;0;54;0
WireConnection;85;1;86;0
WireConnection;105;0;101;0
WireConnection;114;0;111;0
WireConnection;115;0;114;0
WireConnection;115;1;114;1
WireConnection;115;2;114;2
WireConnection;41;0;39;0
WireConnection;106;0;105;0
WireConnection;106;1;107;0
WireConnection;88;0;85;0
WireConnection;83;0;88;0
WireConnection;83;1;84;0
WireConnection;119;0;115;0
WireConnection;44;0;41;0
WireConnection;108;0;55;0
WireConnection;108;1;106;0
WireConnection;82;1;83;0
WireConnection;37;0;36;0
WireConnection;37;1;14;0
WireConnection;37;2;88;0
WireConnection;117;0;118;0
WireConnection;117;1;119;0
WireConnection;49;1;50;0
WireConnection;49;0;51;0
WireConnection;109;1;55;0
WireConnection;109;0;108;0
WireConnection;126;0;123;0
WireConnection;126;1;91;0
WireConnection;120;1;121;0
WireConnection;120;0;117;0
WireConnection;127;0;91;0
WireConnection;127;1;124;0
WireConnection;81;1;37;0
WireConnection;81;0;82;0
WireConnection;42;0;109;0
WireConnection;42;1;46;0
WireConnection;42;2;43;0
WireConnection;42;3;49;0
WireConnection;125;0;126;0
WireConnection;125;1;127;0
WireConnection;95;0;96;0
WireConnection;95;1;90;1
WireConnection;99;0;100;0
WireConnection;99;1;89;0
WireConnection;116;0;120;0
WireConnection;116;1;42;0
WireConnection;3;0;81;0
WireConnection;3;1;52;0
WireConnection;3;2;4;0
WireConnection;3;3;52;4
WireConnection;3;4;128;1
WireConnection;97;0;90;4
WireConnection;97;1;98;0
WireConnection;163;0;99;0
WireConnection;163;1;125;0
WireConnection;163;2;3;0
WireConnection;163;3;95;0
WireConnection;163;4;97;0
WireConnection;163;10;89;4
WireConnection;163;11;116;0
ASEEND*/
//CHKSM=BD197CEEBD3C2C070C6710E311770ABFE50C0A29