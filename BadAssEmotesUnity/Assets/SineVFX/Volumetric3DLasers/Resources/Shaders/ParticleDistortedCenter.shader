// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32724,y:32693,varname:node_4795,prsc:2|emission-2393-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:32235,y:32601,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3358-OUT;n:type:ShaderForge.SFN_Multiply,id:2393,x:32495,y:32793,varname:node_2393,prsc:2|A-6074-RGB,B-2053-RGB,C-9223-RGB,D-5024-OUT,E-2053-A;n:type:ShaderForge.SFN_VertexColor,id:2053,x:32235,y:32772,varname:node_2053,prsc:2;n:type:ShaderForge.SFN_Color,id:9223,x:32235,y:32924,ptovrint:False,ptlb:Final Color,ptin:_FinalColor,varname:node_9223,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:5024,x:32078,y:33087,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_5024,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:10;n:type:ShaderForge.SFN_TexCoord,id:929,x:30714,y:32745,varname:node_929,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:456,x:30874,y:32745,varname:node_456,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-929-UVOUT;n:type:ShaderForge.SFN_Multiply,id:7722,x:31298,y:32888,varname:node_7722,prsc:2|A-7338-OUT,B-7534-OUT,C-7421-OUT;n:type:ShaderForge.SFN_Tex2d,id:6045,x:30873,y:32932,ptovrint:False,ptlb:Distortion,ptin:_Distortion,varname:node_6045,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8276-OUT;n:type:ShaderForge.SFN_Slider,id:7421,x:30891,y:33113,ptovrint:False,ptlb:Distortion Power,ptin:_DistortionPower,varname:node_7421,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Normalize,id:7338,x:31030,y:32745,varname:node_7338,prsc:2|IN-456-OUT;n:type:ShaderForge.SFN_Add,id:3358,x:31647,y:32586,varname:node_3358,prsc:2|A-8244-OUT,B-7722-OUT;n:type:ShaderForge.SFN_RemapRange,id:7534,x:31048,y:32931,varname:node_7534,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-6045-R;n:type:ShaderForge.SFN_TexCoord,id:4290,x:29910,y:32431,varname:node_4290,prsc:2,uv:0,uaff:True;n:type:ShaderForge.SFN_TexCoord,id:2892,x:30494,y:32932,varname:node_2892,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:8276,x:30695,y:32932,varname:node_8276,prsc:2|A-2892-UVOUT,B-8376-OUT;n:type:ShaderForge.SFN_Multiply,id:8376,x:30494,y:33095,varname:node_8376,prsc:2|A-4290-W,B-2118-OUT;n:type:ShaderForge.SFN_Vector1,id:2118,x:30254,y:33143,varname:node_2118,prsc:2,v1:20;n:type:ShaderForge.SFN_TexCoord,id:7903,x:30710,y:32376,varname:node_7903,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:197,x:30870,y:32376,varname:node_197,prsc:2,frmn:0,frmx:1,tomn:-0.5,tomx:0.5|IN-7903-UVOUT;n:type:ShaderForge.SFN_Multiply,id:3327,x:31055,y:32312,varname:node_3327,prsc:2|A-9440-OUT,B-197-OUT;n:type:ShaderForge.SFN_Exp,id:9440,x:30870,y:32223,varname:node_9440,prsc:2,et:1|IN-4290-Z;n:type:ShaderForge.SFN_Add,id:8244,x:31267,y:32251,varname:node_8244,prsc:2|A-3309-OUT,B-3327-OUT;n:type:ShaderForge.SFN_Vector2,id:3309,x:31055,y:32223,varname:node_3309,prsc:2,v1:0.5,v2:0.5;proporder:6074-9223-5024-6045-7421;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/ParticleDistortedCenter" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _FinalColor ("Final Color", Color) = (0.5,0.5,0.5,1)
        _FinalPower ("Final Power", Range(0, 10)) = 2
        _Distortion ("Distortion", 2D) = "white" {}
        _DistortionPower ("Distortion Power", Range(0, 1)) = 0
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
            Blend One One
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
            uniform float4 _FinalColor;
            uniform float _FinalPower;
            uniform sampler2D _Distortion; uniform float4 _Distortion_ST;
            uniform float _DistortionPower;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float2 node_8276 = (i.uv0+(i.uv0.a*20.0));
                float4 _Distortion_var = tex2D(_Distortion,TRANSFORM_TEX(node_8276, _Distortion));
                float2 node_3358 = ((float2(0.5,0.5)+(exp2(i.uv0.b)*(i.uv0*1.0+-0.5)))+(normalize((i.uv0*2.0+-1.0))*(_Distortion_var.r*2.0+-1.0)*_DistortionPower));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_3358, _MainTex));
                float3 emissive = (_MainTex_var.rgb*i.vertexColor.rgb*_FinalColor.rgb*_FinalPower*i.vertexColor.a);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0,0,0,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
