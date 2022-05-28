// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Mobile/Diffuse,iptp:0,cusa:True,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3382353,fgcg:0.203936,fgcb:0.203936,fgca:1,fgde:0.01,fgrn:0,fgrf:120,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4128,x:33193,y:32505,varname:node_4128,prsc:2|emission-7037-OUT,custl-7074-OUT,alpha-7005-OUT,clip-1492-VFACE;n:type:ShaderForge.SFN_Tex2d,id:4125,x:31995,y:32856,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_4125,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4811-UVOUT;n:type:ShaderForge.SFN_LightVector,id:7497,x:30961,y:33045,varname:node_7497,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3941,x:30961,y:33168,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:7859,x:31140,y:33092,varname:node_7859,prsc:2,dt:1|A-7497-OUT,B-3941-OUT;n:type:ShaderForge.SFN_Multiply,id:1143,x:32238,y:32994,varname:node_1143,prsc:2|A-4125-RGB,B-3536-OUT;n:type:ShaderForge.SFN_Color,id:1406,x:31995,y:32436,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_1406,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:7074,x:32601,y:32763,varname:node_7074,prsc:2|A-1406-RGB,B-1143-OUT,C-5906-RGB;n:type:ShaderForge.SFN_Tex2d,id:5973,x:31492,y:33194,ptovrint:False,ptlb:ToonRamp,ptin:_ToonRamp,varname:node_5973,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:207cd7d6bdf48884581528e5cefd1cd7,ntxv:0,isnm:False|UVIN-5309-OUT;n:type:ShaderForge.SFN_Append,id:5309,x:31328,y:33092,varname:node_5309,prsc:2|A-7859-OUT,B-7859-OUT;n:type:ShaderForge.SFN_Color,id:3857,x:31885,y:33413,ptovrint:False,ptlb:Highlights,ptin:_Highlights,varname:node_3857,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8602941,c2:0.8602941,c3:0.8602941,c4:1;n:type:ShaderForge.SFN_Color,id:9492,x:31885,y:33231,ptovrint:False,ptlb:Shadows,ptin:_Shadows,varname:node_9492,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.200692,c2:0.4264706,c3:0.3891004,c4:1;n:type:ShaderForge.SFN_Lerp,id:3536,x:32154,y:33356,varname:node_3536,prsc:2|A-9492-RGB,B-3857-RGB,T-857-OUT;n:type:ShaderForge.SFN_Desaturate,id:857,x:31885,y:33069,varname:node_857,prsc:2|COL-3409-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:1799,x:31492,y:33037,varname:node_1799,prsc:2;n:type:ShaderForge.SFN_AmbientLight,id:8550,x:31995,y:32294,varname:node_8550,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7037,x:32601,y:32634,varname:node_7037,prsc:2|A-8550-RGB,B-4125-RGB;n:type:ShaderForge.SFN_LightColor,id:5906,x:31995,y:32582,varname:node_5906,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:4811,x:31749,y:32856,varname:node_4811,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3409,x:31695,y:33139,varname:node_3409,prsc:2|A-1799-OUT,B-5973-RGB;n:type:ShaderForge.SFN_FaceSign,id:1492,x:32601,y:32889,varname:node_1492,prsc:2,fstp:0;n:type:ShaderForge.SFN_Add,id:6430,x:28043,y:32798,varname:node_6430,prsc:2|A-2814-OUT,B-888-OUT;n:type:ShaderForge.SFN_Multiply,id:2814,x:27763,y:32710,varname:node_2814,prsc:2|B-6002-OUT;n:type:ShaderForge.SFN_Multiply,id:888,x:27777,y:32896,varname:node_888,prsc:2|A-7861-OUT,B-8125-T;n:type:ShaderForge.SFN_Time,id:8125,x:27441,y:32942,varname:node_8125,prsc:2;n:type:ShaderForge.SFN_Append,id:7861,x:27441,y:32800,varname:node_7861,prsc:2|A-5779-OUT,B-400-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5779,x:27196,y:32834,ptovrint:False,ptlb:NoiseXSpeed_copy,ptin:_NoiseXSpeed_copy,varname:_NoiseXSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:400,x:27199,y:32920,ptovrint:False,ptlb:NoiseYSpeed_copy,ptin:_NoiseYSpeed_copy,varname:_NoiseYSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:6002,x:27441,y:32650,varname:node_6002,prsc:2|A-845-X,B-845-Y;n:type:ShaderForge.SFN_Vector4Property,id:845,x:27133,y:32611,ptovrint:False,ptlb:NoiseTiling_copy,ptin:_NoiseTiling_copy,varname:_NoiseTiling_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:1,v3:0,v4:0;n:type:ShaderForge.SFN_Slider,id:7005,x:32759,y:32927,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_7005,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;proporder:4125-5973-7005-1406-3857-9492;pass:END;sub:END;*/

Shader "VaxKun/Toon/Cristal" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _ToonRamp ("ToonRamp", 2D) = "white" {}
        _Opacity ("Opacity", Range(0, 1)) = 0.7
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _Highlights ("Highlights", Color) = (0.8602941,0.8602941,0.8602941,1)
        _Shadows ("Shadows", Color) = (0.200692,0.4264706,0.3891004,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "CanUseSpriteAtlas"="True"
        }
        LOD 100
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
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _MainColor;
            uniform sampler2D _ToonRamp; uniform float4 _ToonRamp_ST;
            uniform float4 _Highlights;
            uniform float4 _Shadows;
            uniform float _Opacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                clip(isFrontFace - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = 1;
////// Emissive:
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 emissive = (UNITY_LIGHTMODEL_AMBIENT.rgb*_Diffuse_var.rgb);
                float node_7859 = max(0,dot(lightDirection,i.normalDir));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = emissive + (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
                fixed4 finalRGBA = fixed4(finalColor,_Opacity);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _MainColor;
            uniform sampler2D _ToonRamp; uniform float4 _ToonRamp_ST;
            uniform float4 _Highlights;
            uniform float4 _Shadows;
            uniform float _Opacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                clip(isFrontFace - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float node_7859 = max(0,dot(lightDirection,i.normalDir));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
                fixed4 finalRGBA = fixed4(finalColor * _Opacity,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                clip(isFrontFace - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Mobile/Diffuse"
    //CustomEditor "ShaderForgeMaterialInspector"
	CustomEditor "ToonCrystalEditor"
}
