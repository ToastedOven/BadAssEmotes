// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32941,y:32675,varname:node_4795,prsc:2|alpha-7421-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7942,x:32043,y:32752,ptovrint:False,ptlb:Fresnel Exp,ptin:_FresnelExp,varname:node_7942,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Dot,id:798,x:32043,y:32576,varname:node_798,prsc:2,dt:0|A-6131-OUT,B-2634-OUT;n:type:ShaderForge.SFN_ViewVector,id:6131,x:31773,y:32526,varname:node_6131,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:2634,x:31773,y:32656,prsc:2,pt:False;n:type:ShaderForge.SFN_Clamp01,id:7421,x:32758,y:32931,varname:node_7421,prsc:2|IN-1652-OUT;n:type:ShaderForge.SFN_Power,id:9429,x:32269,y:32576,varname:node_9429,prsc:2|VAL-798-OUT,EXP-7942-OUT;n:type:ShaderForge.SFN_DepthBlend,id:9894,x:32227,y:33056,varname:node_9894,prsc:2|DIST-5929-OUT;n:type:ShaderForge.SFN_Multiply,id:1652,x:32589,y:32931,varname:node_1652,prsc:2|A-9429-OUT,B-9894-OUT,C-8209-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5929,x:32057,y:33056,ptovrint:False,ptlb:Depth Blend,ptin:_DepthBlend,varname:node_5929,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.25;n:type:ShaderForge.SFN_ValueProperty,id:8209,x:32227,y:33198,ptovrint:False,ptlb:Power,ptin:_Power,varname:node_8209,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;proporder:7942-5929-8209;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/BlackHoleCore" {
    Properties {
        _FresnelExp ("Fresnel Exp", Float ) = 1
        _DepthBlend ("Depth Blend", Float ) = 0.25
        _Power ("Power", Float ) = 2
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
			ZTest Always
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float _FresnelExp;
            uniform float _DepthBlend;
            uniform float _Power;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 projPos : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
////// Lighting:
                float3 finalColor = 0;
                fixed4 finalRGBA = fixed4(finalColor,saturate((pow(dot(viewDirection,i.normalDir),_FresnelExp)*saturate((sceneZ-partZ)/_DepthBlend)*_Power)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
