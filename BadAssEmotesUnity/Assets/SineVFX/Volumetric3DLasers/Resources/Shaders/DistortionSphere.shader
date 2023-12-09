// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:33234,y:32710,varname:node_4795,prsc:2|emission-2339-RGB,alpha-1574-OUT;n:type:ShaderForge.SFN_Tex2d,id:2139,x:31101,y:32620,ptovrint:False,ptlb:Noise 01,ptin:_Noise01,varname:node_2139,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:1210,x:31853,y:32777,varname:node_1210,prsc:2|A-2908-OUT,B-4055-OUT,C-4469-OUT,D-4987-A,E-5155-OUT;n:type:ShaderForge.SFN_Vector1,id:1574,x:32657,y:33206,varname:node_1574,prsc:2,v1:1;n:type:ShaderForge.SFN_Fresnel,id:8963,x:31128,y:32866,varname:node_8963,prsc:2|EXP-2961-OUT;n:type:ShaderForge.SFN_Slider,id:2961,x:30711,y:32925,ptovrint:False,ptlb:Fresnel Exp 1,ptin:_FresnelExp1,varname:node_2961,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:4;n:type:ShaderForge.SFN_OneMinus,id:3157,x:31298,y:32866,varname:node_3157,prsc:2|IN-8963-OUT;n:type:ShaderForge.SFN_Multiply,id:4055,x:31523,y:32931,varname:node_4055,prsc:2|A-3157-OUT,B-8963-OUT,C-3790-OUT;n:type:ShaderForge.SFN_SceneColor,id:2339,x:32263,y:32639,varname:node_2339,prsc:2|UVIN-9029-OUT;n:type:ShaderForge.SFN_ScreenPos,id:3443,x:31853,y:32549,varname:node_3443,prsc:2,sctp:2;n:type:ShaderForge.SFN_Add,id:9029,x:32095,y:32639,varname:node_9029,prsc:2|A-3443-UVOUT,B-1210-OUT;n:type:ShaderForge.SFN_Add,id:9193,x:31333,y:32599,varname:node_9193,prsc:2|A-4102-OUT,B-2139-R;n:type:ShaderForge.SFN_ValueProperty,id:4102,x:31101,y:32529,ptovrint:False,ptlb:Noise 01 Add,ptin:_Noise01Add,varname:node_4102,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Clamp01,id:2908,x:31490,y:32599,varname:node_2908,prsc:2|IN-9193-OUT;n:type:ShaderForge.SFN_Slider,id:4469,x:31366,y:33080,ptovrint:False,ptlb:Distortion Amount,ptin:_DistortionAmount,varname:node_4469,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0.1,max:1;n:type:ShaderForge.SFN_VertexColor,id:4987,x:31523,y:33164,varname:node_4987,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:5111,x:30785,y:33318,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:9415,x:31327,y:33387,varname:node_9415,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3139-OUT;n:type:ShaderForge.SFN_Transform,id:2547,x:30968,y:33318,varname:node_2547,prsc:2,tffrom:0,tfto:3|IN-5111-OUT;n:type:ShaderForge.SFN_Normalize,id:5155,x:31488,y:33387,varname:node_5155,prsc:2|IN-9415-OUT;n:type:ShaderForge.SFN_ViewVector,id:5005,x:30785,y:33499,varname:node_5005,prsc:2;n:type:ShaderForge.SFN_Transform,id:1044,x:30968,y:33499,varname:node_1044,prsc:2,tffrom:0,tfto:3|IN-5005-OUT;n:type:ShaderForge.SFN_Subtract,id:3139,x:31165,y:33387,varname:node_3139,prsc:2|A-2547-XYZ,B-1044-XYZ;n:type:ShaderForge.SFN_DepthBlend,id:3047,x:30693,y:33094,varname:node_3047,prsc:2|DIST-410-OUT;n:type:ShaderForge.SFN_ValueProperty,id:410,x:30520,y:33094,ptovrint:False,ptlb:Depth Blend,ptin:_DepthBlend,varname:node_410,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.25;n:type:ShaderForge.SFN_SwitchProperty,id:3790,x:30868,y:33053,ptovrint:False,ptlb:Depth Blend On,ptin:_DepthBlendOn,varname:node_3790,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7883-OUT,B-3047-OUT;n:type:ShaderForge.SFN_Vector1,id:7883,x:30520,y:33004,varname:node_7883,prsc:2,v1:1;proporder:2139-2961-4102-4469-3790-410;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/DistortionSphere" {
    Properties {
        _Noise01 ("Noise 01", 2D) = "white" {}
        _FresnelExp1 ("Fresnel Exp 1", Range(0, 4)) = 1
        _Noise01Add ("Noise 01 Add", Float ) = 0.5
        _DistortionAmount ("Distortion Amount", Range(-1, 1)) = 0.1
        [MaterialToggle] _DepthBlendOn ("Depth Blend On", Float ) = 1
        _DepthBlend ("Depth Blend", Float ) = 0.25
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _Noise01; uniform float4 _Noise01_ST;
            uniform float _FresnelExp1;
            uniform float _Noise01Add;
            uniform float _DistortionAmount;
            uniform float _DepthBlend;
            uniform fixed _DepthBlendOn;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                float4 _Noise01_var = tex2D(_Noise01,TRANSFORM_TEX(i.uv0, _Noise01));
                float node_8963 = pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelExp1);
                float3 emissive = tex2D( _GrabTexture, (sceneUVs.rg+(saturate((_Noise01Add+_Noise01_var.r))*((1.0 - node_8963)*node_8963*lerp( 1.0, saturate((sceneZ-partZ)/_DepthBlend), _DepthBlendOn ))*_DistortionAmount*i.vertexColor.a*normalize((mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb-mul( UNITY_MATRIX_V, float4(viewDirection,0) ).xyz.rgb).rg)))).rgb;
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1.0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
