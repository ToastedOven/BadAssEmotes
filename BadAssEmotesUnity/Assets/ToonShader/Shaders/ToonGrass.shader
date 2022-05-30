// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Mobile/Diffuse,iptp:0,cusa:False,bamd:1,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:False,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3382353,fgcg:0.203936,fgcb:0.203936,fgca:1,fgde:0.01,fgrn:0,fgrf:120,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4128,x:33751,y:32511,varname:node_4128,prsc:2|emission-7037-OUT,custl-7074-OUT,clip-4125-A,voffset-2730-OUT;n:type:ShaderForge.SFN_Tex2d,id:4125,x:32279,y:32427,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_4125,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:302bfd209f74d1c40974843d01cfaf8a,ntxv:2,isnm:False|UVIN-4811-UVOUT;n:type:ShaderForge.SFN_LightVector,id:7497,x:31199,y:32872,varname:node_7497,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3941,x:31199,y:32995,prsc:2,pt:True;n:type:ShaderForge.SFN_Dot,id:7859,x:31378,y:32919,varname:node_7859,prsc:2,dt:1|A-7497-OUT,B-3941-OUT;n:type:ShaderForge.SFN_Multiply,id:1143,x:32663,y:32582,varname:node_1143,prsc:2|A-4125-RGB,B-3536-OUT;n:type:ShaderForge.SFN_Color,id:1406,x:32996,y:32616,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_1406,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:7074,x:32996,y:32767,varname:node_7074,prsc:2|A-1406-RGB,B-1143-OUT,C-5906-R;n:type:ShaderForge.SFN_Tex2d,id:5973,x:31808,y:32905,ptovrint:False,ptlb:ToonRamp,ptin:_ToonRamp,varname:node_5973,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-5309-OUT;n:type:ShaderForge.SFN_Append,id:5309,x:31582,y:32905,varname:node_5309,prsc:2|A-7859-OUT,B-7859-OUT;n:type:ShaderForge.SFN_Color,id:3857,x:32013,y:32577,ptovrint:False,ptlb:Highlights,ptin:_Highlights,varname:node_3857,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8602941,c2:0.8602941,c3:0.8602941,c4:1;n:type:ShaderForge.SFN_Color,id:9492,x:32013,y:32407,ptovrint:False,ptlb:Shadows,ptin:_Shadows,varname:node_9492,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.200692,c2:0.4264706,c3:0.3891004,c4:1;n:type:ShaderForge.SFN_Lerp,id:3536,x:32279,y:32675,varname:node_3536,prsc:2|A-9492-RGB,B-3857-RGB,T-857-OUT;n:type:ShaderForge.SFN_Desaturate,id:857,x:32013,y:32731,varname:node_857,prsc:2|COL-1319-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:1799,x:31808,y:32754,varname:node_1799,prsc:2;n:type:ShaderForge.SFN_AmbientLight,id:8550,x:32656,y:32281,varname:node_8550,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7037,x:32656,y:32424,varname:node_7037,prsc:2|A-8550-RGB,B-4125-RGB;n:type:ShaderForge.SFN_LightColor,id:5906,x:32663,y:32717,varname:node_5906,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:4811,x:32279,y:32250,varname:node_4811,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:5639,x:32262,y:33377,varname:node_5639,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_OneMinus,id:5132,x:32461,y:33316,varname:node_5132,prsc:2|IN-5639-V;n:type:ShaderForge.SFN_Time,id:3241,x:32262,y:33149,cmnt:Vetrex Animation,varname:node_3241,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3114,x:32262,y:33300,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_3114,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.2;n:type:ShaderForge.SFN_Sin,id:6146,x:32660,y:33044,varname:node_6146,prsc:2|IN-9191-OUT;n:type:ShaderForge.SFN_Cos,id:1724,x:32660,y:32912,varname:node_1724,prsc:2|IN-9191-OUT;n:type:ShaderForge.SFN_Multiply,id:9191,x:32461,y:33132,varname:node_9191,prsc:2|A-3241-T,B-3114-OUT;n:type:ShaderForge.SFN_Append,id:2870,x:32969,y:32962,varname:node_2870,prsc:2|A-1724-OUT,B-4115-OUT,C-6146-OUT;n:type:ShaderForge.SFN_Multiply,id:1319,x:32013,y:32868,varname:node_1319,prsc:2|A-1799-OUT,B-5973-RGB;n:type:ShaderForge.SFN_Slider,id:8478,x:32890,y:33654,ptovrint:False,ptlb:Waving,ptin:_Waving,varname:node_8478,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_RemapRange,id:3411,x:32660,y:33316,varname:node_3411,prsc:2,frmn:0,frmx:1.1,tomn:1,tomx:0|IN-5132-OUT;n:type:ShaderForge.SFN_Vector1,id:4115,x:32660,y:33166,varname:node_4115,prsc:2,v1:0;n:type:ShaderForge.SFN_ToggleProperty,id:2461,x:32660,y:33241,ptovrint:False,ptlb:BlendVetrexColors,ptin:_BlendVetrexColors,varname:node_2461,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_If,id:5464,x:32969,y:33169,varname:node_5464,prsc:2|A-2461-OUT,B-4115-OUT,GT-7925-OUT,EQ-3411-OUT,LT-3411-OUT;n:type:ShaderForge.SFN_VertexColor,id:1998,x:32461,y:33475,varname:node_1998,prsc:2;n:type:ShaderForge.SFN_OneMinus,id:5131,x:32660,y:33475,varname:node_5131,prsc:2|IN-1998-G;n:type:ShaderForge.SFN_Blend,id:7925,x:32969,y:33308,varname:node_7925,prsc:2,blmd:6,clmp:False|SRC-3411-OUT,DST-5131-OUT;n:type:ShaderForge.SFN_Lerp,id:5305,x:33217,y:33199,varname:node_5305,prsc:2|A-6482-OUT,B-2636-OUT,T-5464-OUT;n:type:ShaderForge.SFN_Vector3,id:6482,x:32969,y:33082,varname:node_6482,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_Vector3,id:2095,x:32660,y:33604,varname:node_2095,prsc:2,v1:1,v2:0,v3:1;n:type:ShaderForge.SFN_Multiply,id:2636,x:32969,y:33480,varname:node_2636,prsc:2|A-2095-OUT,B-8478-OUT;n:type:ShaderForge.SFN_Multiply,id:2730,x:33429,y:33106,varname:node_2730,prsc:2|A-2870-OUT,B-5305-OUT,C-5464-OUT;n:type:ShaderForge.SFN_Add,id:4423,x:28235,y:32990,varname:node_4423,prsc:2|A-2871-OUT,B-2729-OUT;n:type:ShaderForge.SFN_Multiply,id:2871,x:27955,y:32902,varname:node_2871,prsc:2|B-3357-OUT;n:type:ShaderForge.SFN_Multiply,id:2729,x:27969,y:33088,varname:node_2729,prsc:2|A-7195-OUT,B-7645-T;n:type:ShaderForge.SFN_Time,id:7645,x:27633,y:33134,varname:node_7645,prsc:2;n:type:ShaderForge.SFN_Append,id:7195,x:27633,y:32992,varname:node_7195,prsc:2|A-2315-OUT,B-7237-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2315,x:27388,y:33026,ptovrint:False,ptlb:NoiseXSpeed_copy,ptin:_NoiseXSpeed_copy,varname:_NoiseXSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7237,x:27391,y:33112,ptovrint:False,ptlb:NoiseYSpeed_copy,ptin:_NoiseYSpeed_copy,varname:_NoiseYSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:3357,x:27633,y:32842,varname:node_3357,prsc:2|A-3420-X,B-3420-Y;n:type:ShaderForge.SFN_Vector4Property,id:3420,x:27325,y:32803,ptovrint:False,ptlb:NoiseTiling_copy,ptin:_NoiseTiling_copy,varname:_NoiseTiling_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:1,v3:0,v4:0;proporder:4125-5973-1406-3857-9492-3114-8478-2461;pass:END;sub:END;*/

Shader "VaxKun/Toon/Grass" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "black" {}
        _ToonRamp ("ToonRamp", 2D) = "white" {}
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _Highlights ("Highlights", Color) = (0.8602941,0.8602941,0.8602941,1)
        _Shadows ("Shadows", Color) = (0.200692,0.4264706,0.3891004,1)
        _Speed ("Speed", Float ) = 1.2
        _Waving ("Waving", Range(0, 1)) = 1
        [MaterialToggle] _BlendVetrexColors ("BlendVetrexColors", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
            "DisableBatching"="True"
        }
        LOD 100
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
            uniform float _Speed;
            uniform float _Waving;
            uniform fixed _BlendVetrexColors;
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
                float4 node_3241 = _Time; // Vetrex Animation
                float node_9191 = (node_3241.g*_Speed);
                float node_4115 = 0.0;
                float node_5464_if_leA = step(_BlendVetrexColors,node_4115);
                float node_5464_if_leB = step(node_4115,_BlendVetrexColors);
                float node_3411 = ((1.0 - o.uv0.g)*-0.9090909+1.0);
                float node_5464 = lerp((node_5464_if_leA*node_3411)+(node_5464_if_leB*(1.0-(1.0-node_3411)*(1.0-(1.0 - o.vertexColor.g)))),node_3411,node_5464_if_leA*node_5464_if_leB);
                v.vertex.xyz += (float3(cos(node_9191),node_4115,sin(node_9191))*lerp(float3(0,0,0),(float3(1,0,1)*_Waving),node_5464)*node_5464);
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
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                clip(_Diffuse_var.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
////// Emissive:
                float3 emissive = (UNITY_LIGHTMODEL_AMBIENT.rgb*_Diffuse_var.rgb);
                float node_7859 = max(0,dot(lightDirection,normalDirection));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = emissive + (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.r);
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
            uniform float _Speed;
            uniform float _Waving;
            uniform fixed _BlendVetrexColors;
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
                float4 node_3241 = _Time; // Vetrex Animation
                float node_9191 = (node_3241.g*_Speed);
                float node_4115 = 0.0;
                float node_5464_if_leA = step(_BlendVetrexColors,node_4115);
                float node_5464_if_leB = step(node_4115,_BlendVetrexColors);
                float node_3411 = ((1.0 - o.uv0.g)*-0.9090909+1.0);
                float node_5464 = lerp((node_5464_if_leA*node_3411)+(node_5464_if_leB*(1.0-(1.0-node_3411)*(1.0-(1.0 - o.vertexColor.g)))),node_3411,node_5464_if_leA*node_5464_if_leB);
                v.vertex.xyz += (float3(cos(node_9191),node_4115,sin(node_9191))*lerp(float3(0,0,0),(float3(1,0,1)*_Waving),node_5464)*node_5464);
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
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                clip(_Diffuse_var.a - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float node_7859 = max(0,dot(lightDirection,normalDirection));
                float2 node_5309 = float2(node_7859,node_7859);
                float4 _ToonRamp_var = tex2D(_ToonRamp,TRANSFORM_TEX(node_5309, _ToonRamp));
                float3 finalColor = (_MainColor.rgb*(_Diffuse_var.rgb*lerp(_Shadows.rgb,_Highlights.rgb,dot((attenuation*_ToonRamp_var.rgb),float3(0.3,0.59,0.11))))*_LightColor0.r);
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
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float _Speed;
            uniform float _Waving;
            uniform fixed _BlendVetrexColors;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                float4 node_3241 = _Time; // Vetrex Animation
                float node_9191 = (node_3241.g*_Speed);
                float node_4115 = 0.0;
                float node_5464_if_leA = step(_BlendVetrexColors,node_4115);
                float node_5464_if_leB = step(node_4115,_BlendVetrexColors);
                float node_3411 = ((1.0 - o.uv0.g)*-0.9090909+1.0);
                float node_5464 = lerp((node_5464_if_leA*node_3411)+(node_5464_if_leB*(1.0-(1.0-node_3411)*(1.0-(1.0 - o.vertexColor.g)))),node_3411,node_5464_if_leA*node_5464_if_leB);
                v.vertex.xyz += (float3(cos(node_9191),node_4115,sin(node_9191))*lerp(float3(0,0,0),(float3(1,0,1)*_Waving),node_5464)*node_5464);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                clip(_Diffuse_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Mobile/Diffuse"
    //CustomEditor "ShaderForgeMaterialInspector"
	CustomEditor "ToonGrassEditor"
}
