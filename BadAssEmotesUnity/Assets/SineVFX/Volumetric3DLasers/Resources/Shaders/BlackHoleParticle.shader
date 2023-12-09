// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32703,y:32683,varname:node_4795,prsc:2|emission-9400-OUT,alpha-7346-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:31547,y:32624,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:3525,x:32015,y:32886,varname:node_3525,prsc:2|A-6074-R,B-6074-G;n:type:ShaderForge.SFN_Clamp01,id:9419,x:32172,y:32886,varname:node_9419,prsc:2|IN-3525-OUT;n:type:ShaderForge.SFN_Multiply,id:6572,x:32354,y:32946,varname:node_6572,prsc:2|A-9419-OUT,B-810-OUT;n:type:ShaderForge.SFN_Slider,id:810,x:32015,y:33045,ptovrint:False,ptlb:Opacity Boost,ptin:_OpacityBoost,varname:node_810,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:4,max:4;n:type:ShaderForge.SFN_Clamp01,id:7346,x:32523,y:32946,varname:node_7346,prsc:2|IN-6572-OUT;n:type:ShaderForge.SFN_Multiply,id:9400,x:32171,y:32560,varname:node_9400,prsc:2|A-6074-B,B-9973-OUT,C-5738-RGB,D-376-OUT;n:type:ShaderForge.SFN_Slider,id:9973,x:31798,y:32682,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_9973,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:10;n:type:ShaderForge.SFN_Color,id:5738,x:31955,y:32506,ptovrint:False,ptlb:Final Color,ptin:_FinalColor,varname:node_5738,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:376,x:31798,y:32397,ptovrint:False,ptlb:GammaLinear,ptin:_GammaLinear,varname:node_376,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.2,cur:1,max:1;proporder:6074-810-9973-5738-376;pass:END;sub:END;*/

Shader "Shader Forge/BlackHoleParticle" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _OpacityBoost ("Opacity Boost", Range(0, 4)) = 4
        _FinalPower ("Final Power", Range(0, 10)) = 2
        _FinalColor ("Final Color", Color) = (0.5,0.5,0.5,1)
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
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _OpacityBoost;
            uniform float _FinalPower;
            uniform float4 _FinalColor;
            uniform float _GammaLinear;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 emissive = (_MainTex_var.b*_FinalPower*_FinalColor.rgb*_GammaLinear);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,saturate((saturate((_MainTex_var.r+_MainTex_var.g))*_OpacityBoost)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
