// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Mobile/Diffuse,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3382353,fgcg:0.203936,fgcb:0.203936,fgca:1,fgde:0.01,fgrn:0,fgrf:120,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4128,x:32926,y:32522,varname:node_4128,prsc:2|emission-7037-OUT,custl-7074-OUT,olwid-1232-OUT,olcol-1653-RGB;n:type:ShaderForge.SFN_Tex2d,id:4125,x:31432,y:32562,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_4125,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4811-UVOUT;n:type:ShaderForge.SFN_LightVector,id:7497,x:30961,y:33045,varname:node_7497,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3941,x:30961,y:33168,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:7859,x:31140,y:33092,varname:node_7859,prsc:2,dt:1|A-7497-OUT,B-3941-OUT;n:type:ShaderForge.SFN_Multiply,id:1143,x:32238,y:32994,varname:node_1143,prsc:2|A-9037-OUT,B-3536-OUT;n:type:ShaderForge.SFN_Color,id:1406,x:31995,y:32436,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_1406,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:7074,x:32601,y:32763,varname:node_7074,prsc:2|A-1406-RGB,B-1143-OUT,C-5906-RGB;n:type:ShaderForge.SFN_Tex2d,id:5973,x:31492,y:33194,ptovrint:False,ptlb:ToonRamp,ptin:_ToonRamp,varname:node_5973,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:207cd7d6bdf48884581528e5cefd1cd7,ntxv:0,isnm:False|UVIN-5309-OUT;n:type:ShaderForge.SFN_Append,id:5309,x:31328,y:33092,varname:node_5309,prsc:2|A-7859-OUT,B-7859-OUT;n:type:ShaderForge.SFN_Color,id:3857,x:31885,y:33413,ptovrint:False,ptlb:Highlights,ptin:_Highlights,varname:node_3857,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8602941,c2:0.8602941,c3:0.8602941,c4:1;n:type:ShaderForge.SFN_Color,id:9492,x:31885,y:33231,ptovrint:False,ptlb:Shadows,ptin:_Shadows,varname:node_9492,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.200692,c2:0.4264706,c3:0.3891004,c4:1;n:type:ShaderForge.SFN_Lerp,id:3536,x:32154,y:33356,varname:node_3536,prsc:2|A-9492-RGB,B-3857-RGB,T-857-OUT;n:type:ShaderForge.SFN_Desaturate,id:857,x:31885,y:33069,varname:node_857,prsc:2|COL-3409-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:1799,x:31492,y:33037,varname:node_1799,prsc:2;n:type:ShaderForge.SFN_Slider,id:5579,x:32238,y:33138,ptovrint:False,ptlb:OutlineWidth,ptin:_OutlineWidth,varname:node_5579,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.09236561,max:1;n:type:ShaderForge.SFN_RemapRange,id:1232,x:32601,y:32898,varname:node_1232,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.2|IN-5579-OUT;n:type:ShaderForge.SFN_AmbientLight,id:8550,x:31995,y:32294,varname:node_8550,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7037,x:32601,y:32634,varname:node_7037,prsc:2|A-8550-RGB,B-9037-OUT;n:type:ShaderForge.SFN_LightColor,id:5906,x:31995,y:32581,varname:node_5906,prsc:2;n:type:ShaderForge.SFN_Color,id:1653,x:32601,y:33091,ptovrint:False,ptlb:OutlineColor,ptin:_OutlineColor,varname:node_1653,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_TexCoord,id:4811,x:31039,y:32461,varname:node_4811,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3409,x:31695,y:33139,varname:node_3409,prsc:2|A-1799-OUT,B-5973-RGB;n:type:ShaderForge.SFN_Add,id:7331,x:28107,y:32862,varname:node_7331,prsc:2|A-9372-OUT,B-5957-OUT;n:type:ShaderForge.SFN_Multiply,id:9372,x:27827,y:32774,varname:node_9372,prsc:2|B-1766-OUT;n:type:ShaderForge.SFN_Multiply,id:5957,x:27841,y:32960,varname:node_5957,prsc:2|A-9766-OUT,B-6536-T;n:type:ShaderForge.SFN_Time,id:6536,x:27505,y:33006,varname:node_6536,prsc:2;n:type:ShaderForge.SFN_Append,id:9766,x:27505,y:32864,varname:node_9766,prsc:2|A-3945-OUT,B-9945-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3945,x:27260,y:32898,ptovrint:False,ptlb:NoiseXSpeed_copy,ptin:_NoiseXSpeed_copy,varname:_NoiseXSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9945,x:27263,y:32984,ptovrint:False,ptlb:NoiseYSpeed_copy,ptin:_NoiseYSpeed_copy,varname:_NoiseYSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:1766,x:27505,y:32714,varname:node_1766,prsc:2|A-3425-X,B-3425-Y;n:type:ShaderForge.SFN_Vector4Property,id:3425,x:27197,y:32675,ptovrint:False,ptlb:NoiseTiling_copy,ptin:_NoiseTiling_copy,varname:_NoiseTiling_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:1,v3:0,v4:0;n:type:ShaderForge.SFN_Lerp,id:9037,x:31946,y:32814,varname:node_9037,prsc:2|A-4125-RGB,B-5028-RGB,T-7369-R;n:type:ShaderForge.SFN_Tex2d,id:5028,x:31432,y:32755,ptovrint:False,ptlb:Diffuse2,ptin:_Diffuse2,varname:node_5028,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_VertexColor,id:7369,x:31636,y:32940,varname:node_7369,prsc:2;proporder:4125-5028-5973-1406-3857-9492-1653-5579;pass:END;sub:END;*/

Shader "VaxKun/Toon/MultiTexture/Diffuse" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _Diffuse2 ("Diffuse2", 2D) = "white" {}
        _ToonRamp ("ToonRamp", 2D) = "white" {}
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _Highlights ("Highlights", Color) = (0.8602941,0.8602941,0.8602941,1)
        _Shadows ("Shadows", Color) = (0.200692,0.4264706,0.3891004,1)
        _OutlineColor ("OutlineColor", Color) = (0,0,0,1)
        _OutlineWidth ("OutlineWidth", Range(0, 1)) = 0.09236561
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float _OutlineWidth;
            uniform float4 _OutlineColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_FOG_COORDS(0)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*(_OutlineWidth*0.2+0.0),1) );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                return fixed4(_OutlineColor.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _MainColor;
            uniform sampler2D _ToonRamp; uniform float4 _ToonRamp_ST;
            uniform float4 _Highlights;
            uniform float4 _Shadows;
            uniform sampler2D _Diffuse2; uniform float4 _Diffuse2_ST;
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
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
////// Emissive:
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float4 _Diffuse2_var = tex2D(_Diffuse2,TRANSFORM_TEX(i.uv0, _Diffuse2));
                float3 node_9037 = lerp(_Diffuse_var.rgb,_Diffuse2_var.rgb,i.vertexColor.r);
                float3 emissive = (UNITY_LIGHTMODEL_AMBIENT.rgb*node_9037);
                float node_7859 = max(0,dot(lightDirection,i.normalDir));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = emissive + (_MainColor.rgb*(node_9037*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
                fixed4 finalRGBA = fixed4(finalColor,1);
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _MainColor;
            uniform sampler2D _ToonRamp; uniform float4 _ToonRamp_ST;
            uniform float4 _Highlights;
            uniform float4 _Shadows;
            uniform sampler2D _Diffuse2; uniform float4 _Diffuse2_ST;
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
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float4 _Diffuse2_var = tex2D(_Diffuse2,TRANSFORM_TEX(i.uv0, _Diffuse2));
                float3 node_9037 = lerp(_Diffuse_var.rgb,_Diffuse2_var.rgb,i.vertexColor.r);
                float node_7859 = max(0,dot(lightDirection,i.normalDir));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = (_MainColor.rgb*(node_9037*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Mobile/Diffuse"
    //CustomEditor "ShaderForgeMaterialInspector"
	CustomEditor "ToonDiffuseMultiTextureEditor"
}
