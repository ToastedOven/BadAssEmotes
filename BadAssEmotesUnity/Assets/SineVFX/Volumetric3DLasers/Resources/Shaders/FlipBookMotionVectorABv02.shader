// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32920,y:32590,varname:node_4795,prsc:2|emission-2393-OUT,alpha-5649-OUT;n:type:ShaderForge.SFN_Multiply,id:2393,x:31742,y:32201,varname:node_2393,prsc:2|A-282-RGB,B-2903-OUT,C-9842-RGB,D-5667-OUT;n:type:ShaderForge.SFN_Multiply,id:798,x:31594,y:32708,varname:node_798,prsc:2|A-3854-OUT,B-6394-OUT;n:type:ShaderForge.SFN_Tex2d,id:282,x:31181,y:32067,ptovrint:False,ptlb:Ramp,ptin:_Ramp,varname:node_282,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3024-OUT;n:type:ShaderForge.SFN_Append,id:3024,x:30986,y:32067,varname:node_3024,prsc:2|A-562-OUT,B-5544-OUT;n:type:ShaderForge.SFN_Vector1,id:5544,x:30986,y:32195,varname:node_5544,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:2903,x:31024,y:32301,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_2903,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:10;n:type:ShaderForge.SFN_Slider,id:6394,x:31048,y:32813,ptovrint:False,ptlb:Opacity Boost,ptin:_OpacityBoost,varname:node_6394,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:4;n:type:ShaderForge.SFN_Clamp01,id:5649,x:31773,y:32708,varname:node_5649,prsc:2|IN-798-OUT;n:type:ShaderForge.SFN_Time,id:3003,x:25195,y:31671,varname:node_3003,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2677,x:25705,y:31764,varname:node_2677,prsc:2|A-5815-OUT,B-290-OUT;n:type:ShaderForge.SFN_Append,id:2130,x:25640,y:32225,varname:node_2130,prsc:2|A-1764-OUT,B-1764-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1764,x:25451,y:32239,ptovrint:False,ptlb:Row Count,ptin:_RowCount,varname:node_1764,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:8;n:type:ShaderForge.SFN_Frac,id:7996,x:26825,y:31354,varname:node_7996,prsc:2|IN-7777-OUT;n:type:ShaderForge.SFN_Subtract,id:1935,x:27038,y:31237,varname:node_1935,prsc:2|A-7777-OUT,B-7996-OUT;n:type:ShaderForge.SFN_Fmod,id:3888,x:27484,y:31226,varname:node_3888,prsc:2|A-1935-OUT,B-8592-OUT;n:type:ShaderForge.SFN_Multiply,id:4863,x:27247,y:31368,varname:node_4863,prsc:2|A-1935-OUT,B-8098-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8592,x:26844,y:31696,varname:node_8592,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-8727-OUT;n:type:ShaderForge.SFN_Set,id:3658,x:25867,y:31764,varname:FrameNumber,prsc:2|IN-2677-OUT;n:type:ShaderForge.SFN_Get,id:7777,x:26570,y:31215,varname:node_7777,prsc:2|IN-3658-OUT;n:type:ShaderForge.SFN_Set,id:7621,x:25807,y:32225,varname:SubUV,prsc:2|IN-2130-OUT;n:type:ShaderForge.SFN_Get,id:8727,x:26541,y:31624,varname:node_8727,prsc:2|IN-7621-OUT;n:type:ShaderForge.SFN_Append,id:5658,x:27692,y:31334,varname:node_5658,prsc:2|A-3888-OUT,B-8445-OUT;n:type:ShaderForge.SFN_Divide,id:5257,x:26825,y:31504,varname:node_5257,prsc:2|A-1690-OUT,B-8727-OUT;n:type:ShaderForge.SFN_Vector2,id:1690,x:26562,y:31501,varname:node_1690,prsc:2,v1:1,v2:1;n:type:ShaderForge.SFN_ComponentMask,id:8098,x:27038,y:31401,varname:node_8098,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-5257-OUT;n:type:ShaderForge.SFN_Floor,id:4414,x:27437,y:31368,varname:node_4414,prsc:2|IN-4863-OUT;n:type:ShaderForge.SFN_Add,id:8019,x:27912,y:31435,varname:node_8019,prsc:2|A-5658-OUT,B-4080-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2153,x:27151,y:31739,varname:node_2153,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:1596,x:28128,y:31529,varname:node_1596,prsc:2|A-8019-OUT,B-5257-OUT;n:type:ShaderForge.SFN_Frac,id:4316,x:26826,y:32262,varname:node_4316,prsc:2|IN-8156-OUT;n:type:ShaderForge.SFN_Subtract,id:9925,x:27039,y:32145,varname:node_9925,prsc:2|A-8156-OUT,B-4316-OUT;n:type:ShaderForge.SFN_Fmod,id:306,x:27485,y:32134,varname:node_306,prsc:2|A-9925-OUT,B-3010-OUT;n:type:ShaderForge.SFN_Multiply,id:7239,x:27248,y:32276,varname:node_7239,prsc:2|A-9925-OUT,B-9819-OUT;n:type:ShaderForge.SFN_ComponentMask,id:3010,x:26845,y:32604,varname:node_3010,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-8788-OUT;n:type:ShaderForge.SFN_Get,id:6090,x:26375,y:32096,varname:node_6090,prsc:2|IN-3658-OUT;n:type:ShaderForge.SFN_Get,id:8788,x:26542,y:32532,varname:node_8788,prsc:2|IN-7621-OUT;n:type:ShaderForge.SFN_Append,id:2446,x:27693,y:32242,varname:node_2446,prsc:2|A-306-OUT,B-3924-OUT;n:type:ShaderForge.SFN_Divide,id:9646,x:26826,y:32412,varname:node_9646,prsc:2|A-5766-OUT,B-8788-OUT;n:type:ShaderForge.SFN_Vector2,id:5766,x:26563,y:32409,varname:node_5766,prsc:2,v1:1,v2:1;n:type:ShaderForge.SFN_ComponentMask,id:9819,x:27039,y:32309,varname:node_9819,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-9646-OUT;n:type:ShaderForge.SFN_Floor,id:4778,x:27485,y:32269,varname:node_4778,prsc:2|IN-7239-OUT;n:type:ShaderForge.SFN_Add,id:2966,x:27913,y:32343,varname:node_2966,prsc:2|A-2446-OUT,B-4080-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2485,x:27693,y:32396,varname:node_2485,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:4644,x:28129,y:32437,varname:node_4644,prsc:2|A-2966-OUT,B-9646-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:4036,x:27886,y:31949,ptovrint:False,ptlb:MotionVectors,ptin:_MotionVectors,varname:node_4036,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:897,x:28338,y:31529,varname:node_897,prsc:2,ntxv:0,isnm:False|UVIN-1596-OUT,TEX-4036-TEX;n:type:ShaderForge.SFN_Tex2d,id:9594,x:28324,y:32437,varname:node_9594,prsc:2,ntxv:0,isnm:False|UVIN-4644-OUT,TEX-4036-TEX;n:type:ShaderForge.SFN_ComponentMask,id:5897,x:28512,y:31529,varname:node_5897,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-897-RGB;n:type:ShaderForge.SFN_ComponentMask,id:1681,x:28516,y:32437,varname:node_1681,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-9594-RGB;n:type:ShaderForge.SFN_Add,id:8156,x:26586,y:32122,varname:node_8156,prsc:2|A-6090-OUT,B-7733-OUT;n:type:ShaderForge.SFN_Vector1,id:7733,x:26396,y:32156,varname:node_7733,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:7386,x:28712,y:31569,varname:node_7386,prsc:2|A-5897-OUT,B-3111-OUT;n:type:ShaderForge.SFN_Vector1,id:3111,x:28512,y:31688,varname:node_3111,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:4695,x:28706,y:32471,varname:node_4695,prsc:2|A-1681-OUT,B-5248-OUT;n:type:ShaderForge.SFN_Vector1,id:5248,x:28516,y:32588,varname:node_5248,prsc:2,v1:2;n:type:ShaderForge.SFN_Subtract,id:9522,x:28898,y:31614,varname:node_9522,prsc:2|A-7386-OUT,B-2702-OUT;n:type:ShaderForge.SFN_Vector1,id:2702,x:28712,y:31704,varname:node_2702,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:4826,x:28897,y:32523,varname:node_4826,prsc:2|A-4695-OUT,B-7944-OUT;n:type:ShaderForge.SFN_Vector1,id:7944,x:28706,y:32605,varname:node_7944,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:4474,x:29078,y:31614,varname:node_4474,prsc:2|A-9522-OUT,B-2352-OUT;n:type:ShaderForge.SFN_Get,id:714,x:28381,y:31992,varname:node_714,prsc:2|IN-3658-OUT;n:type:ShaderForge.SFN_Frac,id:2352,x:28561,y:31992,varname:node_2352,prsc:2|IN-714-OUT;n:type:ShaderForge.SFN_Multiply,id:3204,x:29080,y:32523,varname:node_3204,prsc:2|A-4826-OUT,B-4850-OUT;n:type:ShaderForge.SFN_OneMinus,id:4850,x:28833,y:32229,varname:node_4850,prsc:2|IN-2352-OUT;n:type:ShaderForge.SFN_Slider,id:3226,x:29038,y:32067,ptovrint:False,ptlb:Distortion Power,ptin:_DistortionPower,varname:node_3226,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.02;n:type:ShaderForge.SFN_Multiply,id:9037,x:29250,y:31614,varname:node_9037,prsc:2|A-4474-OUT,B-3226-OUT;n:type:ShaderForge.SFN_Multiply,id:7734,x:29274,y:32523,varname:node_7734,prsc:2|A-3226-OUT,B-3204-OUT;n:type:ShaderForge.SFN_Subtract,id:3643,x:29547,y:31821,varname:node_3643,prsc:2|A-1596-OUT,B-9037-OUT;n:type:ShaderForge.SFN_Add,id:6063,x:29568,y:32685,varname:node_6063,prsc:2|A-7734-OUT,B-4644-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:7427,x:29668,y:32205,ptovrint:False,ptlb:FlipBookTex,ptin:_FlipBookTex,varname:node_7427,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:3629,x:29933,y:31906,varname:node_3629,prsc:2,ntxv:0,isnm:False|UVIN-3643-OUT,TEX-7427-TEX;n:type:ShaderForge.SFN_Tex2d,id:3460,x:29952,y:32497,varname:node_3460,prsc:2,ntxv:0,isnm:False|UVIN-6063-OUT,TEX-7427-TEX;n:type:ShaderForge.SFN_Lerp,id:2190,x:30269,y:32090,varname:node_2190,prsc:2|A-3629-A,B-3460-A,T-2352-OUT;n:type:ShaderForge.SFN_Lerp,id:4448,x:30264,y:32389,varname:node_4448,prsc:2|A-3629-A,B-3460-A,T-2352-OUT;n:type:ShaderForge.SFN_OneMinus,id:8445,x:27437,y:31499,varname:node_8445,prsc:2|IN-4414-OUT;n:type:ShaderForge.SFN_OneMinus,id:3924,x:27485,y:32420,varname:node_3924,prsc:2|IN-4778-OUT;n:type:ShaderForge.SFN_ValueProperty,id:290,x:25444,y:31855,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_290,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:10;n:type:ShaderForge.SFN_Subtract,id:9452,x:30479,y:32180,varname:node_9452,prsc:2|A-2190-OUT,B-493-Z;n:type:ShaderForge.SFN_TexCoord,id:493,x:30264,y:32231,varname:node_493,prsc:2,uv:0,uaff:True;n:type:ShaderForge.SFN_Clamp01,id:562,x:30642,y:32180,varname:node_562,prsc:2|IN-9452-OUT;n:type:ShaderForge.SFN_Subtract,id:8909,x:30479,y:32389,varname:node_8909,prsc:2|A-4448-OUT,B-493-W;n:type:ShaderForge.SFN_Clamp01,id:3854,x:30659,y:32389,varname:node_3854,prsc:2|IN-8909-OUT;n:type:ShaderForge.SFN_Color,id:9842,x:31181,y:32408,ptovrint:False,ptlb:Final Color,ptin:_FinalColor,varname:node_9842,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Add,id:5815,x:25444,y:31701,varname:node_5815,prsc:2|A-2122-OUT,B-3003-T,C-9760-U;n:type:ShaderForge.SFN_Vector1,id:2122,x:25195,y:31600,varname:node_2122,prsc:2,v1:500;n:type:ShaderForge.SFN_Rotator,id:4080,x:27574,y:31868,varname:node_4080,prsc:2|UVIN-5738-OUT,ANG-2588-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2588,x:27374,y:31980,ptovrint:False,ptlb:Rotator Ang,ptin:_RotatorAng,varname:node_2588,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_TexCoord,id:9760,x:25195,y:31801,varname:node_9760,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Add,id:5738,x:27374,y:31815,varname:node_5738,prsc:2|A-2153-UVOUT,B-7172-OUT;n:type:ShaderForge.SFN_Tex2d,id:5006,x:26574,y:31857,ptovrint:False,ptlb:Distortion,ptin:_Distortion,varname:node_5006,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7172,x:27161,y:31926,varname:node_7172,prsc:2|A-8355-OUT,B-3839-OUT;n:type:ShaderForge.SFN_Slider,id:3839,x:26783,y:32041,ptovrint:False,ptlb:Distortion Texture Power,ptin:_DistortionTexturePower,varname:node_3839,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:8355,x:26940,y:31857,varname:node_8355,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-7481-OUT;n:type:ShaderForge.SFN_Append,id:7481,x:26772,y:31857,varname:node_7481,prsc:2|A-5006-R,B-5006-G;n:type:ShaderForge.SFN_Slider,id:9055,x:31024,y:31963,ptovrint:False,ptlb:GammaLinear,ptin:_GammaLinear,varname:node_9055,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.2,cur:1,max:1;n:type:ShaderForge.SFN_If,id:4440,x:31519,y:31780,varname:node_4440,prsc:2|A-9055-OUT,B-7216-OUT,GT-1962-OUT,EQ-1962-OUT,LT-9283-OUT;n:type:ShaderForge.SFN_Vector1,id:1962,x:31181,y:31870,varname:node_1962,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7216,x:31181,y:31799,varname:node_7216,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:9283,x:31181,y:31727,varname:node_9283,prsc:2,v1:0.15;n:type:ShaderForge.SFN_Add,id:5667,x:31692,y:31951,varname:node_5667,prsc:2|A-4440-OUT,B-9055-OUT;proporder:9842-2903-6394-282-7427-4036-1764-3226-290-2588-5006-3839-9055;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/FlipBookMotionVectorABv02" {
    Properties {
        _FinalColor ("Final Color", Color) = (0.5,0.5,0.5,1)
        _FinalPower ("Final Power", Range(0, 10)) = 2
        _OpacityBoost ("Opacity Boost", Range(0, 4)) = 2
        _Ramp ("Ramp", 2D) = "white" {}
        _FlipBookTex ("FlipBookTex", 2D) = "white" {}
        _MotionVectors ("MotionVectors", 2D) = "white" {}
        _RowCount ("Row Count", Float ) = 8
        _DistortionPower ("Distortion Power", Range(0, 0.02)) = 0
        _Speed ("Speed", Float ) = 10
        _RotatorAng ("Rotator Ang", Float ) = 1
        _Distortion ("Distortion", 2D) = "white" {}
        _DistortionTexturePower ("Distortion Texture Power", Range(0, 1)) = 0
        _GammaLinear ("GammaLinear", Range(0.2, 1)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
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
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
            uniform float _FinalPower;
            uniform float _OpacityBoost;
            uniform float _RowCount;
            uniform sampler2D _MotionVectors; uniform float4 _MotionVectors_ST;
            uniform float _DistortionPower;
            uniform sampler2D _FlipBookTex; uniform float4 _FlipBookTex_ST;
            uniform float _Speed;
            uniform float4 _FinalColor;
            uniform float _RotatorAng;
            uniform sampler2D _Distortion; uniform float4 _Distortion_ST;
            uniform float _DistortionTexturePower;
            uniform float _GammaLinear;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_3003 = _Time;
                float FrameNumber = ((500.0+node_3003.g+i.uv1.r)*_Speed);
                float node_7777 = FrameNumber;
                float node_1935 = (node_7777-frac(node_7777));
                float2 SubUV = float2(_RowCount,_RowCount);
                float2 node_8727 = SubUV;
                float2 node_5257 = (float2(1,1)/node_8727);
                float node_4080_ang = _RotatorAng;
                float node_4080_spd = 1.0;
                float node_4080_cos = cos(node_4080_spd*node_4080_ang);
                float node_4080_sin = sin(node_4080_spd*node_4080_ang);
                float2 node_4080_piv = float2(0.5,0.5);
                float4 _Distortion_var = tex2D(_Distortion,TRANSFORM_TEX(i.uv0, _Distortion));
                float2 node_4080 = (mul((i.uv0+((float2(_Distortion_var.r,_Distortion_var.g)*2.0+-1.0)*_DistortionTexturePower))-node_4080_piv,float2x2( node_4080_cos, -node_4080_sin, node_4080_sin, node_4080_cos))+node_4080_piv);
                float2 node_1596 = ((float2(fmod(node_1935,node_8727.r),(1.0 - floor((node_1935*node_5257.r))))+node_4080)*node_5257);
                float4 node_897 = tex2D(_MotionVectors,TRANSFORM_TEX(node_1596, _MotionVectors));
                float node_2352 = frac(FrameNumber);
                float2 node_3643 = (node_1596-((((node_897.rgb.rg*2.0)-1.0)*node_2352)*_DistortionPower));
                float4 node_3629 = tex2D(_FlipBookTex,TRANSFORM_TEX(node_3643, _FlipBookTex));
                float node_8156 = (FrameNumber+1.0);
                float node_9925 = (node_8156-frac(node_8156));
                float2 node_8788 = SubUV;
                float2 node_9646 = (float2(1,1)/node_8788);
                float2 node_4644 = ((float2(fmod(node_9925,node_8788.r),(1.0 - floor((node_9925*node_9646.r))))+node_4080)*node_9646);
                float4 node_9594 = tex2D(_MotionVectors,TRANSFORM_TEX(node_4644, _MotionVectors));
                float2 node_6063 = ((_DistortionPower*(((node_9594.rgb.rg*2.0)-1.0)*(1.0 - node_2352)))+node_4644);
                float4 node_3460 = tex2D(_FlipBookTex,TRANSFORM_TEX(node_6063, _FlipBookTex));
                float2 node_3024 = float2(saturate((lerp(node_3629.a,node_3460.a,node_2352)-i.uv0.b)),0.0);
                float4 _Ramp_var = tex2D(_Ramp,TRANSFORM_TEX(node_3024, _Ramp));
                float node_4440_if_leA = step(_GammaLinear,1.0);
                float node_4440_if_leB = step(1.0,_GammaLinear);
                float node_1962 = 0.0;
                float3 emissive = (_Ramp_var.rgb*_FinalPower*_FinalColor.rgb*(lerp((node_4440_if_leA*0.15)+(node_4440_if_leB*node_1962),node_1962,node_4440_if_leA*node_4440_if_leB)+_GammaLinear));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,saturate((saturate((lerp(node_3629.a,node_3460.a,node_2352)-i.uv0.a))*_OpacityBoost)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
