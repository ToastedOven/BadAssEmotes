// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32889,y:32717,varname:node_3138,prsc:2|emission-4415-OUT,alpha-3344-OUT;n:type:ShaderForge.SFN_Multiply,id:3739,x:32054,y:33005,varname:node_3739,prsc:2|A-3667-R,B-9643-OUT,C-3154-A;n:type:ShaderForge.SFN_Slider,id:9643,x:31554,y:33078,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_9643,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;n:type:ShaderForge.SFN_VertexColor,id:3154,x:31711,y:33155,varname:node_3154,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:3667,x:31711,y:32894,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_3667,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_SceneColor,id:506,x:31797,y:32454,varname:node_506,prsc:2|UVIN-4786-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:4786,x:30750,y:32420,varname:node_4786,prsc:2,sctp:2;n:type:ShaderForge.SFN_Lerp,id:4415,x:32646,y:32815,varname:node_4415,prsc:2|A-506-RGB,B-4755-RGB,T-3344-OUT;n:type:ShaderForge.SFN_SceneColor,id:4755,x:31811,y:32678,varname:node_4755,prsc:2|UVIN-5803-OUT;n:type:ShaderForge.SFN_Slider,id:8882,x:31038,y:32915,ptovrint:False,ptlb:Distortion Amount,ptin:_DistortionAmount,varname:node_8882,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.0075,max:0.05;n:type:ShaderForge.SFN_Tex2d,id:6189,x:30761,y:32665,ptovrint:False,ptlb:Distortion,ptin:_Distortion,varname:node_5692,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Lerp,id:5803,x:31643,y:32678,varname:node_5803,prsc:2|A-4786-UVOUT,B-7743-OUT,T-8882-OUT;n:type:ShaderForge.SFN_Clamp01,id:3344,x:32220,y:33005,varname:node_3344,prsc:2|IN-3739-OUT;n:type:ShaderForge.SFN_Add,id:3404,x:31014,y:32580,varname:node_3404,prsc:2|A-4786-U,B-6189-R;n:type:ShaderForge.SFN_Add,id:3287,x:31014,y:32715,varname:node_3287,prsc:2|A-4786-V,B-6189-G;n:type:ShaderForge.SFN_Append,id:7743,x:31215,y:32671,varname:node_7743,prsc:2|A-3404-OUT,B-3287-OUT;proporder:9643-3667-8882-6189;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/DistortionParticle" {
    Properties {
        _FinalPower ("Final Power", Range(0, 10)) = 0
        _Mask ("Mask", 2D) = "white" {}
        _DistortionAmount ("Distortion Amount", Range(0, 0.05)) = 0.0075
        _Distortion ("Distortion", 2D) = "bump" {}
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
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform float _FinalPower;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float _DistortionAmount;
            uniform sampler2D _Distortion; uniform float4 _Distortion_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                float3 _Distortion_var = UnpackNormal(tex2D(_Distortion,TRANSFORM_TEX(i.uv0, _Distortion)));
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                float node_3344 = saturate((_Mask_var.r*_FinalPower*i.vertexColor.a));
                float3 emissive = lerp(tex2D( _GrabTexture, sceneUVs.rg).rgb,tex2D( _GrabTexture, lerp(sceneUVs.rg,float2((sceneUVs.r+_Distortion_var.r),(sceneUVs.g+_Distortion_var.g)),_DistortionAmount)).rgb,node_3344);
                float3 finalColor = emissive;
                return fixed4(finalColor,node_3344);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
