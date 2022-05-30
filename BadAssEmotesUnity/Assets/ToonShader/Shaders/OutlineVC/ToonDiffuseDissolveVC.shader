// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Mobile/Diffuse,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:2,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3382353,fgcg:0.203936,fgcb:0.203936,fgca:1,fgde:0.01,fgrn:0,fgrf:120,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4128,x:34326,y:32666,varname:node_4128,prsc:2|emission-5131-OUT,custl-7074-OUT,clip-5123-OUT,olwid-1352-OUT,olcol-8854-RGB;n:type:ShaderForge.SFN_Tex2d,id:4125,x:31995,y:32856,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_4125,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4811-UVOUT;n:type:ShaderForge.SFN_LightVector,id:7497,x:30961,y:33045,varname:node_7497,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3941,x:30961,y:33168,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:7859,x:31140,y:33092,varname:node_7859,prsc:2,dt:1|A-7497-OUT,B-3941-OUT;n:type:ShaderForge.SFN_Multiply,id:1143,x:32238,y:32994,varname:node_1143,prsc:2|A-4125-RGB,B-3536-OUT;n:type:ShaderForge.SFN_Color,id:1406,x:31995,y:32436,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_1406,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:7074,x:32601,y:32763,varname:node_7074,prsc:2|A-1406-RGB,B-1143-OUT,C-5906-RGB;n:type:ShaderForge.SFN_Tex2d,id:5973,x:31492,y:33194,ptovrint:False,ptlb:ToonRamp,ptin:_ToonRamp,varname:node_5973,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:207cd7d6bdf48884581528e5cefd1cd7,ntxv:0,isnm:False|UVIN-5309-OUT;n:type:ShaderForge.SFN_Append,id:5309,x:31328,y:33092,varname:node_5309,prsc:2|A-7859-OUT,B-7859-OUT;n:type:ShaderForge.SFN_Color,id:3857,x:31885,y:33413,ptovrint:False,ptlb:Highlights,ptin:_Highlights,varname:node_3857,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8602941,c2:0.8602941,c3:0.8602941,c4:1;n:type:ShaderForge.SFN_Color,id:9492,x:31885,y:33231,ptovrint:False,ptlb:Shadows,ptin:_Shadows,varname:node_9492,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.200692,c2:0.4264706,c3:0.3891004,c4:1;n:type:ShaderForge.SFN_Lerp,id:3536,x:32154,y:33356,varname:node_3536,prsc:2|A-9492-RGB,B-3857-RGB,T-857-OUT;n:type:ShaderForge.SFN_Desaturate,id:857,x:31885,y:33069,varname:node_857,prsc:2|COL-3409-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:1799,x:31492,y:33037,varname:node_1799,prsc:2;n:type:ShaderForge.SFN_AmbientLight,id:8550,x:31995,y:32294,varname:node_8550,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7037,x:32601,y:32634,varname:node_7037,prsc:2|A-8550-RGB,B-4125-RGB;n:type:ShaderForge.SFN_LightColor,id:5906,x:31995,y:32581,varname:node_5906,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:4811,x:31685,y:32981,varname:node_4811,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3409,x:31695,y:33139,varname:node_3409,prsc:2|A-1799-OUT,B-5973-RGB;n:type:ShaderForge.SFN_Tex2d,id:7924,x:32456,y:33405,ptovrint:False,ptlb:DisolveNoise,ptin:_DisolveNoise,varname:node_7924,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:28c7aad1372ff114b90d330f8a2dd938,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:4941,x:32299,y:33816,ptovrint:False,ptlb:Disolve Ammount,ptin:_DisolveAmmount,varname:node_4941,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Add,id:5123,x:32655,y:33517,varname:node_5123,prsc:2|A-7924-R,B-2198-OUT;n:type:ShaderForge.SFN_RemapRange,id:2198,x:32456,y:33624,varname:node_2198,prsc:2,frmn:0,frmx:1,tomn:0.6,tomx:-0.6|IN-4941-OUT;n:type:ShaderForge.SFN_Tex2d,id:6778,x:33454,y:33308,ptovrint:False,ptlb:DissolveRamp,ptin:_DissolveRamp,varname:node_6778,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:207cd7d6bdf48884581528e5cefd1cd7,ntxv:0,isnm:False|UVIN-8260-OUT;n:type:ShaderForge.SFN_RemapRange,id:1485,x:32836,y:33612,varname:node_1485,prsc:2,frmn:0,frmx:1,tomn:-3.1,tomx:4|IN-5123-OUT;n:type:ShaderForge.SFN_RemapRange,id:5909,x:33130,y:33539,varname:node_5909,prsc:2,frmn:0,frmx:1,tomn:3,tomx:-3|IN-1485-OUT;n:type:ShaderForge.SFN_Append,id:8260,x:33220,y:33308,varname:node_8260,prsc:2|A-8918-OUT,B-1995-OUT;n:type:ShaderForge.SFN_Vector1,id:1995,x:33220,y:33433,varname:node_1995,prsc:2,v1:0;n:type:ShaderForge.SFN_RemapRange,id:6137,x:33130,y:33708,varname:node_6137,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-1485-OUT;n:type:ShaderForge.SFN_Blend,id:1324,x:33317,y:33611,varname:node_1324,prsc:2,blmd:6,clmp:True|SRC-5909-OUT,DST-6137-OUT;n:type:ShaderForge.SFN_RemapRange,id:2735,x:33493,y:33611,varname:node_2735,prsc:2,frmn:0,frmx:1,tomn:1,tomx:-1|IN-1324-OUT;n:type:ShaderForge.SFN_Add,id:5131,x:33787,y:32938,varname:node_5131,prsc:2|A-7037-OUT,B-6944-OUT,C-1629-OUT,D-3219-OUT;n:type:ShaderForge.SFN_Clamp01,id:8918,x:33690,y:33611,varname:node_8918,prsc:2|IN-2735-OUT;n:type:ShaderForge.SFN_Color,id:2530,x:33768,y:33329,ptovrint:False,ptlb:DissolveColor,ptin:_DissolveColor,varname:node_2530,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.4344827,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:6944,x:33787,y:33151,varname:node_6944,prsc:2|A-6778-RGB,B-2530-RGB;n:type:ShaderForge.SFN_Add,id:3514,x:28171,y:32926,varname:node_3514,prsc:2|A-1607-OUT,B-3099-OUT;n:type:ShaderForge.SFN_Multiply,id:1607,x:27891,y:32838,varname:node_1607,prsc:2|B-360-OUT;n:type:ShaderForge.SFN_Multiply,id:3099,x:27905,y:33024,varname:node_3099,prsc:2|A-3060-OUT,B-1816-T;n:type:ShaderForge.SFN_Time,id:1816,x:27569,y:33070,varname:node_1816,prsc:2;n:type:ShaderForge.SFN_Append,id:3060,x:27569,y:32928,varname:node_3060,prsc:2|A-6069-OUT,B-583-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6069,x:27324,y:32962,ptovrint:False,ptlb:NoiseXSpeed_copy,ptin:_NoiseXSpeed_copy,varname:_NoiseXSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:583,x:27327,y:33048,ptovrint:False,ptlb:NoiseYSpeed_copy,ptin:_NoiseYSpeed_copy,varname:_NoiseYSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:360,x:27569,y:32778,varname:node_360,prsc:2|A-343-X,B-343-Y;n:type:ShaderForge.SFN_Vector4Property,id:343,x:27261,y:32739,ptovrint:False,ptlb:NoiseTiling_copy,ptin:_NoiseTiling_copy,varname:_NoiseTiling_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:1,v3:0,v4:0;n:type:ShaderForge.SFN_Slider,id:1352,x:34063,y:33205,ptovrint:False,ptlb:OutlineWidth,ptin:_OutlineWidth,varname:node_1352,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Color,id:8854,x:34092,y:33345,ptovrint:False,ptlb:OutlineColor,ptin:_OutlineColor,varname:node_8854,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Fresnel,id:8618,x:32494,y:33125,varname:node_8618,prsc:2|NRM-3462-OUT,EXP-1609-OUT;n:type:ShaderForge.SFN_NormalVector,id:3462,x:32317,y:33125,prsc:2,pt:False;n:type:ShaderForge.SFN_ValueProperty,id:1609,x:32467,y:33291,ptovrint:False,ptlb:FresnelExponent,ptin:_FresnelExponent,varname:node_1609,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_Multiply,id:8394,x:32717,y:33089,varname:node_8394,prsc:2|A-9798-RGB,B-8618-OUT;n:type:ShaderForge.SFN_Color,id:9798,x:32520,y:32961,ptovrint:False,ptlb:FresnelColor,ptin:_FresnelColor,varname:node_9798,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4862745,c2:0.8313726,c3:1,c4:1;n:type:ShaderForge.SFN_Clamp01,id:4450,x:32905,y:33089,varname:node_4450,prsc:2|IN-8394-OUT;n:type:ShaderForge.SFN_Multiply,id:7774,x:33103,y:33087,varname:node_7774,prsc:2|A-4450-OUT,B-1114-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1114,x:32908,y:33258,ptovrint:False,ptlb:FresnelIntensity,ptin:_FresnelIntensity,varname:node_1114,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_SwitchProperty,id:1629,x:33358,y:33087,ptovrint:False,ptlb:FresnelOn,ptin:_FresnelOn,varname:node_1629,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-4186-OUT,B-7774-OUT;n:type:ShaderForge.SFN_Vector1,id:4186,x:33153,y:32984,varname:node_4186,prsc:2,v1:0;n:type:ShaderForge.SFN_Tex2d,id:8000,x:33273,y:32329,ptovrint:False,ptlb:EmisiveMap,ptin:_EmisiveMap,varname:node_8000,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:5604,x:33272,y:32515,ptovrint:False,ptlb:EmisiveMapIntensity,ptin:_EmisiveMapIntensity,varname:node_5604,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:2795,x:33515,y:32424,varname:node_2795,prsc:2|A-8000-R,B-5604-OUT,C-6842-RGB;n:type:ShaderForge.SFN_Color,id:6842,x:33272,y:32601,ptovrint:False,ptlb:EmisiveMapColor,ptin:_EmisiveMapColor,varname:node_6842,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.05291831,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_SwitchProperty,id:3219,x:33774,y:32592,ptovrint:False,ptlb:EmisiveMapOn,ptin:_EmisiveMapOn,varname:node_3219,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-9374-OUT,B-2795-OUT;n:type:ShaderForge.SFN_Vector1,id:9374,x:33676,y:32459,varname:node_9374,prsc:2,v1:0;proporder:4125-5973-1406-3857-9492-7924-4941-6778-2530-1352-8854-1609-9798-1114-1629-8000-5604-6842-3219;pass:END;sub:END;*/

Shader "VaxKun/Toon/DiffuseDisolveVC" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _ToonRamp ("ToonRamp", 2D) = "white" {}
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _Highlights ("Highlights", Color) = (0.8602941,0.8602941,0.8602941,1)
        _Shadows ("Shadows", Color) = (0.200692,0.4264706,0.3891004,1)
        _DisolveNoise ("DisolveNoise", 2D) = "white" {}
        _DisolveAmmount ("Disolve Ammount", Range(0, 1)) = 0
        _DissolveRamp ("DissolveRamp", 2D) = "white" {}
        _DissolveColor ("DissolveColor", Color) = (1,0.4344827,0,1)
        _OutlineWidth ("OutlineWidth", Range(0, 1)) = 0
        _OutlineColor ("OutlineColor", Color) = (0,0,0,1)
        _FresnelExponent ("FresnelExponent", Float ) = 5
        _FresnelColor ("FresnelColor", Color) = (0.4862745,0.8313726,1,1)
        _FresnelIntensity ("FresnelIntensity", Float ) = 1
        [MaterialToggle] _FresnelOn ("FresnelOn", Float ) = 0
        _EmisiveMap ("EmisiveMap", 2D) = "white" {}
        _EmisiveMapIntensity ("EmisiveMapIntensity", Float ) = 1
        _EmisiveMapColor ("EmisiveMapColor", Color) = (0.05291831,1,0,1)
        [MaterialToggle] _EmisiveMapOn ("EmisiveMapOn", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            uniform sampler2D _DisolveNoise; uniform float4 _DisolveNoise_ST;
            uniform float _DisolveAmmount;
            uniform float _OutlineWidth;
            uniform float4 _OutlineColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.vertexColor*_OutlineWidth,1) );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _DisolveNoise_var = tex2D(_DisolveNoise,TRANSFORM_TEX(i.uv0, _DisolveNoise));
                float node_5123 = (_DisolveNoise_var.r+(_DisolveAmmount*-1.2+0.6));
                clip(node_5123 - 0.5);
                return fixed4(_OutlineColor.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
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
            uniform sampler2D _DisolveNoise; uniform float4 _DisolveNoise_ST;
            uniform float _DisolveAmmount;
            uniform sampler2D _DissolveRamp; uniform float4 _DissolveRamp_ST;
            uniform float4 _DissolveColor;
            uniform float _FresnelExponent;
            uniform float4 _FresnelColor;
            uniform float _FresnelIntensity;
            uniform fixed _FresnelOn;
            uniform sampler2D _EmisiveMap; uniform float4 _EmisiveMap_ST;
            uniform float _EmisiveMapIntensity;
            uniform float4 _EmisiveMapColor;
            uniform fixed _EmisiveMapOn;
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
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 _DisolveNoise_var = tex2D(_DisolveNoise,TRANSFORM_TEX(i.uv0, _DisolveNoise));
                float node_5123 = (_DisolveNoise_var.r+(_DisolveAmmount*-1.2+0.6));
                clip(node_5123 - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
////// Emissive:
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float node_1485 = (node_5123*7.1+-3.1);
                float2 node_8260 = float2(saturate((saturate((1.0-(1.0-(node_1485*-6.0+3.0))*(1.0-(node_1485*2.0+-1.0))))*-2.0+1.0)),0.0);
                float4 _DissolveRamp_var = tex2D(_DissolveRamp,TRANSFORM_TEX(node_8260, _DissolveRamp));
                float4 _EmisiveMap_var = tex2D(_EmisiveMap,TRANSFORM_TEX(i.uv0, _EmisiveMap));
                float3 emissive = ((UNITY_LIGHTMODEL_AMBIENT.rgb*_Diffuse_var.rgb)+(_DissolveRamp_var.rgb*_DissolveColor.rgb)+lerp( 0.0, (saturate((_FresnelColor.rgb*pow(1.0-max(0,dot(i.normalDir, viewDirection)),_FresnelExponent)))*_FresnelIntensity), _FresnelOn )+lerp( 0.0, (_EmisiveMap_var.r*_EmisiveMapIntensity*_EmisiveMapColor.rgb), _EmisiveMapOn ));
                float node_7859 = max(0,dot(lightDirection,i.normalDir));
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
            Cull Off
            
            
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
            uniform sampler2D _DisolveNoise; uniform float4 _DisolveNoise_ST;
            uniform float _DisolveAmmount;
            uniform sampler2D _DissolveRamp; uniform float4 _DissolveRamp_ST;
            uniform float4 _DissolveColor;
            uniform float _FresnelExponent;
            uniform float4 _FresnelColor;
            uniform float _FresnelIntensity;
            uniform fixed _FresnelOn;
            uniform sampler2D _EmisiveMap; uniform float4 _EmisiveMap_ST;
            uniform float _EmisiveMapIntensity;
            uniform float4 _EmisiveMapColor;
            uniform fixed _EmisiveMapOn;
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
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 _DisolveNoise_var = tex2D(_DisolveNoise,TRANSFORM_TEX(i.uv0, _DisolveNoise));
                float node_5123 = (_DisolveNoise_var.r+(_DisolveAmmount*-1.2+0.6));
                clip(node_5123 - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float node_7859 = max(0,dot(lightDirection,i.normalDir));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.rgb);
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
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
            uniform sampler2D _DisolveNoise; uniform float4 _DisolveNoise_ST;
            uniform float _DisolveAmmount;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _DisolveNoise_var = tex2D(_DisolveNoise,TRANSFORM_TEX(i.uv0, _DisolveNoise));
                float node_5123 = (_DisolveNoise_var.r+(_DisolveAmmount*-1.2+0.6));
                clip(node_5123 - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Mobile/Diffuse"
    //CustomEditor "ShaderForgeMaterialInspector"
	CustomEditor "ToonDiffuseDissolveEditor"
}
