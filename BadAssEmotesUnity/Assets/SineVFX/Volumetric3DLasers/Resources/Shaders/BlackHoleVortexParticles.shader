// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:33760,y:32685,varname:node_4795,prsc:2|emission-1516-OUT,alpha-9767-OUT;n:type:ShaderForge.SFN_Tex2d,id:2701,x:31093,y:32716,ptovrint:False,ptlb:Mask 01,ptin:_Mask01,varname:node_2701,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-5408-OUT;n:type:ShaderForge.SFN_TexCoord,id:2677,x:30480,y:32593,varname:node_2677,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:2717,x:30705,y:32745,varname:node_2717,prsc:2|A-2677-V,B-961-OUT;n:type:ShaderForge.SFN_Append,id:5408,x:30912,y:32716,varname:node_5408,prsc:2|A-2677-U,B-2717-OUT;n:type:ShaderForge.SFN_VertexColor,id:6748,x:30325,y:32803,varname:node_6748,prsc:2;n:type:ShaderForge.SFN_RemapRange,id:961,x:30497,y:32803,varname:node_961,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-6748-A;n:type:ShaderForge.SFN_Tex2d,id:99,x:31483,y:32802,ptovrint:False,ptlb:Mask 02,ptin:_Mask02,varname:node_99,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Fresnel,id:7745,x:31316,y:32991,varname:node_7745,prsc:2;n:type:ShaderForge.SFN_OneMinus,id:2839,x:31483,y:32991,varname:node_2839,prsc:2|IN-7745-OUT;n:type:ShaderForge.SFN_Multiply,id:1516,x:33174,y:32983,varname:node_1516,prsc:2|A-9384-OUT,B-8496-OUT,C-7529-RGB,D-6127-OUT;n:type:ShaderForge.SFN_Slider,id:8496,x:32789,y:33117,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_8496,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Set,id:8298,x:32548,y:32730,varname:Opacity,prsc:2|IN-5885-OUT;n:type:ShaderForge.SFN_Get,id:9767,x:33488,y:33078,varname:node_9767,prsc:2|IN-8298-OUT;n:type:ShaderForge.SFN_Multiply,id:9384,x:31809,y:32874,varname:node_9384,prsc:2|A-4616-OUT,B-99-R,C-2839-OUT,D-2761-R,E-2061-OUT;n:type:ShaderForge.SFN_Tex2d,id:5357,x:31093,y:32532,ptovrint:False,ptlb:Noise 01,ptin:_Noise01,varname:node_5357,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7138-UVOUT;n:type:ShaderForge.SFN_Multiply,id:5058,x:31318,y:32631,varname:node_5058,prsc:2|A-5357-R,B-2701-R;n:type:ShaderForge.SFN_Clamp01,id:4616,x:31483,y:32631,varname:node_4616,prsc:2|IN-5058-OUT;n:type:ShaderForge.SFN_Panner,id:7138,x:30912,y:32532,varname:node_7138,prsc:2,spu:0,spv:0.05|UVIN-9982-OUT;n:type:ShaderForge.SFN_Color,id:7529,x:32946,y:33218,ptovrint:False,ptlb:Final Color,ptin:_FinalColor,varname:node_7529,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2761,x:31483,y:33173,ptovrint:False,ptlb:Noise 02,ptin:_Noise02,varname:node_2761,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-536-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2776,x:30891,y:33173,varname:node_2776,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:536,x:31301,y:33173,varname:node_536,prsc:2,spu:0,spv:1|UVIN-1506-OUT;n:type:ShaderForge.SFN_Slider,id:2061,x:31326,y:33368,ptovrint:False,ptlb:Mask Power,ptin:_MaskPower,varname:node_2061,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:4;n:type:ShaderForge.SFN_TexCoord,id:5871,x:30283,y:33147,varname:node_5871,prsc:2,uv:0,uaff:True;n:type:ShaderForge.SFN_Add,id:9982,x:30733,y:32532,varname:node_9982,prsc:2|A-2677-UVOUT,B-5871-Z;n:type:ShaderForge.SFN_Add,id:1506,x:31110,y:33173,varname:node_1506,prsc:2|A-2776-UVOUT,B-5871-Z;n:type:ShaderForge.SFN_Clamp01,id:5885,x:32389,y:32730,varname:node_5885,prsc:2|IN-9384-OUT;n:type:ShaderForge.SFN_Slider,id:6127,x:32789,y:33381,ptovrint:False,ptlb:GammaLinear,ptin:_GammaLinear,varname:node_6127,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.2,cur:1,max:1;proporder:7529-8496-2701-99-5357-2761-2061-6127;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/BlackHoleVortexParticles" {
    Properties {
        _FinalColor ("Final Color", Color) = (0.5,0.5,0.5,1)
        _FinalPower ("Final Power", Range(0, 10)) = 1
        _Mask01 ("Mask 01", 2D) = "white" {}
        _Mask02 ("Mask 02", 2D) = "white" {}
        _Noise01 ("Noise 01", 2D) = "white" {}
        _Noise02 ("Noise 02", 2D) = "white" {}
        _MaskPower ("Mask Power", Range(0, 4)) = 0
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
            Cull Off
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
            uniform sampler2D _Mask01; uniform float4 _Mask01_ST;
            uniform sampler2D _Mask02; uniform float4 _Mask02_ST;
            uniform float _FinalPower;
            uniform sampler2D _Noise01; uniform float4 _Noise01_ST;
            uniform float4 _FinalColor;
            uniform sampler2D _Noise02; uniform float4 _Noise02_ST;
            uniform float _MaskPower;
            uniform float _GammaLinear;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 node_2007 = _Time;
                float2 node_7138 = ((i.uv0+i.uv0.b)+node_2007.g*float2(0,0.05));
                float4 _Noise01_var = tex2D(_Noise01,TRANSFORM_TEX(node_7138, _Noise01));
                float2 node_5408 = float2(i.uv0.r,(i.uv0.g+(i.vertexColor.a*2.0+-1.0)));
                float4 _Mask01_var = tex2D(_Mask01,TRANSFORM_TEX(node_5408, _Mask01));
                float4 _Mask02_var = tex2D(_Mask02,TRANSFORM_TEX(i.uv0, _Mask02));
                float2 node_536 = ((i.uv0+i.uv0.b)+node_2007.g*float2(0,1));
                float4 _Noise02_var = tex2D(_Noise02,TRANSFORM_TEX(node_536, _Noise02));
                float node_9384 = (saturate((_Noise01_var.r*_Mask01_var.r))*_Mask02_var.r*(1.0 - (1.0-max(0,dot(normalDirection, viewDirection))))*_Noise02_var.r*_MaskPower);
                float3 emissive = (node_9384*_FinalPower*_FinalColor.rgb*_GammaLinear);
                float3 finalColor = emissive;
                float Opacity = saturate(node_9384);
                fixed4 finalRGBA = fixed4(finalColor,Opacity);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0,0,0,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
