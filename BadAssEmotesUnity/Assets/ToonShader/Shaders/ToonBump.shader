// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Mobile/Diffuse,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3382353,fgcg:0.203936,fgcb:0.203936,fgca:1,fgde:0.01,fgrn:0,fgrf:120,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4128,x:32988,y:32548,varname:node_4128,prsc:2|normal-8694-RGB,emission-3362-OUT,custl-7074-OUT,olwid-5579-OUT,olcol-1653-RGB;n:type:ShaderForge.SFN_Tex2d,id:4125,x:31995,y:32856,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_4125,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:ed1073a945416b048afce7cd5c213a49,ntxv:0,isnm:False|UVIN-4811-UVOUT;n:type:ShaderForge.SFN_LightVector,id:7497,x:30961,y:33045,varname:node_7497,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3941,x:30961,y:33168,prsc:2,pt:True;n:type:ShaderForge.SFN_Dot,id:7859,x:31140,y:33092,varname:node_7859,prsc:2,dt:1|A-7497-OUT,B-3941-OUT;n:type:ShaderForge.SFN_Multiply,id:1143,x:32238,y:32994,varname:node_1143,prsc:2|A-4125-RGB,B-3536-OUT;n:type:ShaderForge.SFN_Color,id:1406,x:31995,y:32436,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_1406,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5849056,c2:0.5849056,c3:0.5849056,c4:1;n:type:ShaderForge.SFN_Multiply,id:7074,x:32601,y:32763,varname:node_7074,prsc:2|A-1406-RGB,B-1143-OUT,C-5906-RGB;n:type:ShaderForge.SFN_Tex2d,id:5973,x:31492,y:33195,ptovrint:False,ptlb:ToonRamp,ptin:_ToonRamp,varname:node_5973,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:4a056241e2722dc46a7262a8e7073fd9,ntxv:0,isnm:False|UVIN-5309-OUT;n:type:ShaderForge.SFN_Append,id:5309,x:31328,y:33092,varname:node_5309,prsc:2|A-7859-OUT,B-7859-OUT;n:type:ShaderForge.SFN_Color,id:3857,x:31885,y:33413,ptovrint:False,ptlb:Highlights,ptin:_Highlights,varname:node_3857,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8602941,c2:0.8602941,c3:0.8602941,c4:1;n:type:ShaderForge.SFN_Color,id:9492,x:31885,y:33231,ptovrint:False,ptlb:Shadows,ptin:_Shadows,varname:node_9492,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.200692,c2:0.4264706,c3:0.3891004,c4:1;n:type:ShaderForge.SFN_Lerp,id:3536,x:32154,y:33356,varname:node_3536,prsc:2|A-9492-RGB,B-3857-RGB,T-857-OUT;n:type:ShaderForge.SFN_Desaturate,id:857,x:31885,y:33069,varname:node_857,prsc:2|COL-3409-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:1799,x:31492,y:33037,varname:node_1799,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:8694,x:31995,y:32131,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_8694,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:1,isnm:True|UVIN-4811-UVOUT;n:type:ShaderForge.SFN_Slider,id:5579,x:32508,y:32951,ptovrint:False,ptlb:OutlineWidth,ptin:_OutlineWidth,varname:node_5579,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.03418804,max:1;n:type:ShaderForge.SFN_AmbientLight,id:8550,x:31995,y:32294,varname:node_8550,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7037,x:32376,y:32490,varname:node_7037,prsc:2|A-8550-RGB,B-4125-RGB;n:type:ShaderForge.SFN_LightColor,id:5906,x:31995,y:32581,varname:node_5906,prsc:2;n:type:ShaderForge.SFN_Color,id:1653,x:32639,y:33089,ptovrint:False,ptlb:OutlineColor,ptin:_OutlineColor,varname:node_1653,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_TexCoord,id:4811,x:31749,y:32856,varname:node_4811,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3409,x:31695,y:33139,varname:node_3409,prsc:2|A-1799-OUT,B-5973-RGB;n:type:ShaderForge.SFN_Fresnel,id:7570,x:31217,y:32616,varname:node_7570,prsc:2|NRM-7484-OUT,EXP-1959-OUT;n:type:ShaderForge.SFN_NormalVector,id:7484,x:30954,y:32550,prsc:2,pt:False;n:type:ShaderForge.SFN_Color,id:3271,x:31217,y:32455,ptovrint:False,ptlb:FresnelColor,ptin:_FresnelColor,varname:node_3271,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4858491,c2:0.8296524,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:3936,x:31405,y:32598,varname:node_3936,prsc:2|A-3271-RGB,B-7570-OUT;n:type:ShaderForge.SFN_Clamp01,id:8709,x:31580,y:32598,varname:node_8709,prsc:2|IN-3936-OUT;n:type:ShaderForge.SFN_Multiply,id:6636,x:31753,y:32598,varname:node_6636,prsc:2|A-8709-OUT,B-6575-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6575,x:31470,y:32770,ptovrint:False,ptlb:FresnelIntensity,ptin:_FresnelIntensity,varname:node_6575,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:7054,x:32556,y:32594,varname:node_7054,prsc:2|A-7037-OUT,B-4856-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1959,x:30964,y:32779,ptovrint:False,ptlb:FresnelExponent,ptin:_FresnelExponent,varname:node_1959,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_Add,id:3362,x:32723,y:32451,varname:node_3362,prsc:2|A-4876-OUT,B-7054-OUT;n:type:ShaderForge.SFN_Multiply,id:3849,x:32292,y:31915,varname:node_3849,prsc:2|A-3967-R,B-773-OUT,C-1013-RGB;n:type:ShaderForge.SFN_Tex2d,id:3967,x:32029,y:31648,ptovrint:False,ptlb:EmisiveMap,ptin:_EmisiveMap,varname:node_3967,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:773,x:32029,y:31828,ptovrint:False,ptlb:EmisiveMapIntensity,ptin:_EmisiveMapIntensity,varname:node_773,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_SwitchProperty,id:4876,x:32518,y:32164,ptovrint:False,ptlb:EmisiveMapOn,ptin:_EmisiveMapOn,varname:node_4876,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-7089-OUT,B-3849-OUT;n:type:ShaderForge.SFN_Vector1,id:7089,x:32316,y:32139,varname:node_7089,prsc:2,v1:0;n:type:ShaderForge.SFN_SwitchProperty,id:4856,x:32205,y:32676,ptovrint:False,ptlb:FresnelOn,ptin:_FresnelOn,varname:node_4856,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-924-OUT,B-6636-OUT;n:type:ShaderForge.SFN_Vector1,id:924,x:31973,y:32714,varname:node_924,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:1013,x:32036,y:31922,ptovrint:False,ptlb:EmisiveMapColor,ptin:_EmisiveMapColor,varname:node_1013,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.137475,c2:1,c3:0,c4:1;proporder:4125-8694-5973-1406-3857-9492-1653-5579-3271-6575-1959-3967-773-4876-4856-1013;pass:END;sub:END;*/

Shader "VaxKun/Toon/Bump" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _NormalMap ("NormalMap", 2D) = "gray" {}
        _ToonRamp ("ToonRamp", 2D) = "white" {}
        _MainColor ("MainColor", Color) = (0.5849056,0.5849056,0.5849056,1)
        _Highlights ("Highlights", Color) = (0.8602941,0.8602941,0.8602941,1)
        _Shadows ("Shadows", Color) = (0.200692,0.4264706,0.3891004,1)
        _OutlineColor ("OutlineColor", Color) = (0,0,0,1)
        _OutlineWidth ("OutlineWidth", Range(0, 1)) = 0.03418804
        _FresnelColor ("FresnelColor", Color) = (0.4858491,0.8296524,1,1)
        _FresnelIntensity ("FresnelIntensity", Float ) = 1
        _FresnelExponent ("FresnelExponent", Float ) = 5
        _EmisiveMap ("EmisiveMap", 2D) = "white" {}
        _EmisiveMapIntensity ("EmisiveMapIntensity", Float ) = 1
        [MaterialToggle] _EmisiveMapOn ("EmisiveMapOn", Float ) = 0
        [MaterialToggle] _FresnelOn ("FresnelOn", Float ) = 0
        _EmisiveMapColor ("EmisiveMapColor", Color) = (0.137475,1,0,1)
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
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutlineWidth,1) );
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
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float4 _FresnelColor;
            uniform float _FresnelIntensity;
            uniform float _FresnelExponent;
            uniform sampler2D _EmisiveMap; uniform float4 _EmisiveMap_ST;
            uniform float _EmisiveMapIntensity;
            uniform fixed _EmisiveMapOn;
            uniform fixed _FresnelOn;
            uniform float4 _EmisiveMapColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
////// Emissive:
                float4 _EmisiveMap_var = tex2D(_EmisiveMap,TRANSFORM_TEX(i.uv0, _EmisiveMap));
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 emissive = (lerp( 0.0, (_EmisiveMap_var.r*_EmisiveMapIntensity*_EmisiveMapColor.rgb), _EmisiveMapOn )+((UNITY_LIGHTMODEL_AMBIENT.rgb*_Diffuse_var.rgb)+lerp( 0.0, (saturate((_FresnelColor.rgb*pow(1.0-max(0,dot(i.normalDir, viewDirection)),_FresnelExponent)))*_FresnelIntensity), _FresnelOn )));
                float node_7859 = max(0,dot(lightDirection,normalDirection));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = emissive + (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
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
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float4 _FresnelColor;
            uniform float _FresnelIntensity;
            uniform float _FresnelExponent;
            uniform sampler2D _EmisiveMap; uniform float4 _EmisiveMap_ST;
            uniform float _EmisiveMapIntensity;
            uniform fixed _EmisiveMapOn;
            uniform fixed _FresnelOn;
            uniform float4 _EmisiveMapColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float node_7859 = max(0,dot(lightDirection,normalDirection));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Mobile/Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
	CustomEditor "ToonBumpEditor"
}
