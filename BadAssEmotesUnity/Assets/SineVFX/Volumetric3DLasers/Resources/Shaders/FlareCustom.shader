// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32892,y:32699,varname:node_4795,prsc:2|emission-2393-OUT,voffset-9587-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:32235,y:32601,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:2393,x:32495,y:32793,varname:node_2393,prsc:2|A-6074-RGB,B-5602-RGB,C-1037-OUT,D-8025-OUT;n:type:ShaderForge.SFN_Slider,id:1037,x:32078,y:32950,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_1037,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_TexCoord,id:8047,x:32084,y:33032,varname:node_8047,prsc:2,uv:0,uaff:True;n:type:ShaderForge.SFN_TexCoord,id:9428,x:32084,y:33173,varname:node_9428,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Append,id:7410,x:32289,y:33117,varname:node_7410,prsc:2|A-8047-Z,B-8047-W,C-9428-U;n:type:ShaderForge.SFN_Multiply,id:9587,x:32570,y:33222,varname:node_9587,prsc:2|A-7410-OUT,B-3459-OUT;n:type:ShaderForge.SFN_Slider,id:3459,x:31927,y:33340,ptovrint:False,ptlb:Velocity Offset,ptin:_VelocityOffset,varname:node_3459,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:1,max:1;n:type:ShaderForge.SFN_Color,id:5602,x:32235,y:32780,ptovrint:False,ptlb:Final Color,ptin:_FinalColor,varname:node_5602,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:8025,x:32078,y:32493,ptovrint:False,ptlb:GammaLinear,ptin:_GammaLinear,varname:node_8025,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.2,cur:1,max:1;proporder:6074-1037-3459-5602-8025;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/FlareCustom" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _FinalPower ("Final Power", Range(0, 10)) = 1
        _VelocityOffset ("Velocity Offset", Range(-1, 1)) = 1
        _FinalColor ("Final Color", Color) = (0.5,0.5,0.5,1)
        _GammaLinear ("GammaLinear", Range(0.2, 1)) = 1
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
            uniform float _FinalPower;
            uniform float _VelocityOffset;
            uniform float4 _FinalColor;
            uniform float _GammaLinear;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                v.vertex.xyz += (float3(o.uv0.b,o.uv0.a,o.uv1.r)*_VelocityOffset);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 emissive = (_MainTex_var.rgb*_FinalColor.rgb*_FinalPower*_GammaLinear);
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
