// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Collapse"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.3333
		_FadePow("FadePow", Float) = 6
		[HideInInspector]_Fade("Fade", Float) = 0
		_StartInvisibility("StartInvisibility", Float) = 0.25
		[Toggle(_VIEWBLOCKING_ON)] _ViewBlocking("ViewBlocking", Float) = 1
		_CameraOffsetVal("CameraOffsetVal", Float) = 5
		[Toggle]_CameraOffset("CameraOffset", Float) = 1
		_Hue("Hue", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _VIEWBLOCKING_ON
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
		};

		uniform float _CameraOffset;
		uniform float _Fade;
		uniform float _CameraOffsetVal;
		uniform float _Hue;
		uniform float _StartInvisibility;
		uniform float _FadePow;
		uniform float _Cutoff = 0.3333;


		inline float3 ASESafeNormalize(float3 inVec)
		{
			float dp3 = max( 0.001f , dot( inVec , inVec ) );
			return inVec* rsqrt( dp3);
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 temp_output_50_0 = ( ( ase_worldNormal * -3.0 ) * ( 1.0 - _Fade ) );
			float3 objToWorld45 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float3 normalizeResult47 = ASESafeNormalize( ( objToWorld45 - _WorldSpaceCameraPos ) );
			float4 transform64 = mul(unity_WorldToObject,float4( (( _CameraOffset )?( ( temp_output_50_0 + ( normalizeResult47 * _CameraOffsetVal ) ) ):( temp_output_50_0 )) , 0.0 ));
			v.vertex.xyz += transform64.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 hsvTorgb2_g10 = RGBToHSV( float3(1,0,0) );
			float3 appendResult8_g10 = (float3(frac( ( (hsvTorgb2_g10).x + ( _Hue == 0.0 ? ( _Time.y * 0.4 ) : _Hue ) ) ) , (hsvTorgb2_g10).yz));
			float3 break11_g10 = appendResult8_g10;
			float3 hsvTorgb10_g10 = HSVToRGB( float3(break11_g10.x,break11_g10.y,break11_g10.z) );
			o.Albedo = hsvTorgb10_g10;
			o.Smoothness = 0.0;
			o.Alpha = 1;
			int clampResult2_g11 = clamp( 0 , 0 , 1 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float cos13_g11 = cos( 3.14 * _Time.y );
			float sin13_g11 = sin( 3.14 * _Time.y );
			float2 rotator13_g11 = mul( ( (ase_screenPosNorm).xy * float2( 1.6,1 ) ) - float2( 0.5,0.5 ) , float2x2( cos13_g11 , -sin13_g11 , sin13_g11 , cos13_g11 )) + float2( 0.5,0.5 );
			float2 temp_output_140_0_g11 = sin( ( 200.0 * rotator13_g11 ) );
			float temp_output_26_0_g11 = (temp_output_140_0_g11).x;
			float clampResult70_g11 = clamp( ( (float)clampResult2_g11 == 0.0 ? min( temp_output_26_0_g11 , (temp_output_140_0_g11).y ) : temp_output_26_0_g11 ) , 0.0 , 1.0 );
			int clampResult10_g11 = clamp( 1 , 0 , 1 );
			float lerpResult34 = lerp( _StartInvisibility , 1.0 , pow( _Fade , _FadePow ));
			float3 objToWorld22 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float clampResult27 = clamp( ( ( distance( objToWorld22 , _WorldSpaceCameraPos ) - 200.0 ) / 200.0 ) , 0.0 , 1.0 );
			float lerpResult29 = lerp( lerpResult34 , 1.0 , ( 1.0 - clampResult27 ));
			#ifdef _VIEWBLOCKING_ON
				float staticSwitch37 = lerpResult29;
			#else
				float staticSwitch37 = lerpResult34;
			#endif
			float clampResult12_g11 = clamp( staticSwitch37 , 0.0 , 1.0 );
			float lerpResult86_g11 = lerp( 0.0 , ( (float)clampResult10_g11 == 1.0 ? 1.0 : 0.4 ) , clampResult12_g11);
			clip( (( clampResult70_g11 >= lerpResult86_g11 && clampResult70_g11 <= 1.0 ) ? clampResult70_g11 :  0.0 ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
697;25;1040;1004;539.7676;2971.418;1.61682;True;True
Node;AmplifyShaderEditor.TransformPositionNode;22;-555,-516;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;23;-526,-205;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;25;-152,-155;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;200;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;5;-167,-451;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;107,-316;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;45;916.5746,609.5574;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;44;945.5746,920.5574;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;1321.497,644.9605;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;53;1498.696,-219.8721;Inherit;False;Constant;_Float5;Float 5;5;0;Create;True;0;0;0;False;0;False;-3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-25.58105,-2065.899;Float;False;Property;_Fade;Fade;2;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;26;380,-266;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-30.59926,-1649.387;Float;False;Property;_FadePow;FadePow;1;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;52;1402.2,-493.5958;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;49;1646.121,-670.9149;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;27;686,-262;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;47;1586.362,625.8888;Inherit;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;1744.5,-307.8548;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;42;1328.108,257.0672;Float;False;Property;_CameraOffsetVal;CameraOffsetVal;5;0;Create;True;0;0;0;False;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;232.8244,-2488.069;Float;False;Property;_StartInvisibility;StartInvisibility;3;0;Create;True;0;0;0;False;0;False;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;303.1121,-1857.643;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;403.7043,-2101.809;Inherit;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;87;2253.54,-2632.757;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;28;1001.275,-185.8475;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;2007.619,-314.6453;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;1704.039,111.431;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;88;2313.54,-2419.757;Inherit;False;Constant;_Float2;Float 2;7;0;Create;True;0;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;34;661.804,-2037.729;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;2037.75,-2541.443;Inherit;False;Property;_Hue;Hue;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;2520.54,-2519.757;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;1305.084,-1363.239;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;2461.696,-303.8721;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;37;1630.07,-1619.01;Inherit;False;Property;_ViewBlocking;ViewBlocking;4;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;60;2780.772,-519.76;Inherit;False;Property;_CameraOffset;CameraOffset;6;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;66;2230.018,-2025.848;Inherit;False;Constant;_Vector1;Vector 1;7;0;Create;True;0;0;0;False;0;False;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Compare;89;2489.54,-2859.757;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;67;2591.331,-2058.555;Inherit;False;hueOffset;-1;;10;f31c0f1cfdc98c1488711765d5636fc3;0;2;1;FLOAT3;1,0,0;False;6;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;64;2734.298,-988.8776;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;2452.489,-1121.847;Inherit;False;Constant;_Float4;Float 4;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;101;2156.998,-1330.873;Inherit;False;DotOccSub;-1;;11;1f43a3638865caa499aba96880d5a919;0;4;1;INT;0;False;3;FLOAT2;0,0;False;9;INT;1;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2999.761,-1370.032;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Collapse;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.3333;True;False;0;False;TransparentCutout;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;1;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;22;0
WireConnection;5;1;23;0
WireConnection;24;0;5;0
WireConnection;24;1;25;0
WireConnection;46;0;45;0
WireConnection;46;1;44;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;49;0;30;0
WireConnection;27;0;26;0
WireConnection;47;0;46;0
WireConnection;51;0;52;0
WireConnection;51;1;53;0
WireConnection;32;0;30;0
WireConnection;32;1;31;0
WireConnection;28;0;27;0
WireConnection;50;0;51;0
WireConnection;50;1;49;0
WireConnection;43;0;47;0
WireConnection;43;1;42;0
WireConnection;34;0;33;0
WireConnection;34;1;35;0
WireConnection;34;2;32;0
WireConnection;86;0;87;2
WireConnection;86;1;88;0
WireConnection;29;0;34;0
WireConnection;29;1;35;0
WireConnection;29;2;28;0
WireConnection;58;0;50;0
WireConnection;58;1;43;0
WireConnection;37;1;34;0
WireConnection;37;0;29;0
WireConnection;60;0;50;0
WireConnection;60;1;58;0
WireConnection;89;0;65;0
WireConnection;89;2;86;0
WireConnection;89;3;65;0
WireConnection;67;1;66;0
WireConnection;67;6;89;0
WireConnection;64;0;60;0
WireConnection;101;11;37;0
WireConnection;0;0;67;0
WireConnection;0;4;41;0
WireConnection;0;10;101;0
WireConnection;0;11;64;0
ASEEND*/
//CHKSM=6D1FD8A427CEFB6E93A086231303248503853E6D