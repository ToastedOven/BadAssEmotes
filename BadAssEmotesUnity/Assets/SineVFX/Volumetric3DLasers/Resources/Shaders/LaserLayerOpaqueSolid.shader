// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:33393,y:32589,varname:node_4795,prsc:2|emission-2603-OUT,clip-9465-OUT,voffset-7186-OUT;n:type:ShaderForge.SFN_Vector4Property,id:792,x:28236,y:32045,ptovrint:False,ptlb:_StartPosition,ptin:_StartPosition,varname:node_792,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Vector4Property,id:2626,x:28236,y:32284,ptovrint:False,ptlb:_EndPosition,ptin:_EndPosition,varname:node_2626,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_FragmentPosition,id:4411,x:28236,y:31859,varname:node_4411,prsc:2;n:type:ShaderForge.SFN_FragmentPosition,id:1578,x:28236,y:32448,varname:node_1578,prsc:2;n:type:ShaderForge.SFN_Distance,id:3971,x:28474,y:31959,varname:node_3971,prsc:2|A-4411-XYZ,B-792-XYZ;n:type:ShaderForge.SFN_OneMinus,id:5425,x:28637,y:31957,varname:node_5425,prsc:2|IN-3971-OUT;n:type:ShaderForge.SFN_Distance,id:5558,x:28477,y:32360,varname:node_5558,prsc:2|A-2626-XYZ,B-1578-XYZ;n:type:ShaderForge.SFN_OneMinus,id:4674,x:28640,y:32360,varname:node_4674,prsc:2|IN-5558-OUT;n:type:ShaderForge.SFN_Multiply,id:2603,x:32467,y:32307,varname:node_2603,prsc:2|A-1809-RGB,B-2951-OUT,C-9603-OUT,D-9186-OUT;n:type:ShaderForge.SFN_Color,id:1809,x:32182,y:32224,ptovrint:False,ptlb:Final Color,ptin:_FinalColor,varname:node_1809,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:2951,x:32025,y:32400,ptovrint:False,ptlb:Final Power,ptin:_FinalPower,varname:node_2951,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:10;n:type:ShaderForge.SFN_Multiply,id:7186,x:32518,y:32915,varname:node_7186,prsc:2|A-1036-OUT,B-7732-OUT,C-3884-OUT,D-1377-OUT;n:type:ShaderForge.SFN_NormalVector,id:7732,x:32263,y:32933,prsc:2,pt:False;n:type:ShaderForge.SFN_ValueProperty,id:3884,x:32263,y:33096,ptovrint:False,ptlb:Vertex Offset Power,ptin:_VertexOffsetPower,varname:node_3884,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:9766,x:28827,y:31957,varname:node_9766,prsc:2|A-5425-OUT,B-606-OUT;n:type:ShaderForge.SFN_Add,id:1789,x:28829,y:32358,varname:node_1789,prsc:2|A-4674-OUT,B-5873-OUT;n:type:ShaderForge.SFN_ValueProperty,id:606,x:28637,y:31896,ptovrint:False,ptlb:Shape Add Start Position,ptin:_ShapeAddStartPosition,varname:node_606,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_ValueProperty,id:5873,x:28640,y:32517,ptovrint:False,ptlb:Shape Add End Position,ptin:_ShapeAddEndPosition,varname:_StartPositionMaskAdd_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_Vector1,id:3731,x:28637,y:31814,varname:node_3731,prsc:2,v1:0.75;n:type:ShaderForge.SFN_Add,id:8102,x:28827,y:31814,varname:node_8102,prsc:2|A-8045-OUT,B-606-OUT;n:type:ShaderForge.SFN_Vector1,id:7098,x:28637,y:31741,varname:node_7098,prsc:2,v1:0;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:3003,x:29139,y:31730,varname:node_3003,prsc:2|IN-5892-OUT,IMIN-7098-OUT,IMAX-8102-OUT,OMIN-7098-OUT,OMAX-4749-OUT;n:type:ShaderForge.SFN_Vector1,id:4749,x:28637,y:31670,varname:node_4749,prsc:2,v1:1;n:type:ShaderForge.SFN_Add,id:1036,x:32263,y:32789,varname:node_1036,prsc:2|A-908-OUT,B-629-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1715,x:30637,y:33173,ptovrint:False,ptlb:Shape Size,ptin:_ShapeSize,varname:node_1715,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.25;n:type:ShaderForge.SFN_Add,id:281,x:28829,y:32483,varname:node_281,prsc:2|A-5873-OUT,B-8045-OUT;n:type:ShaderForge.SFN_Vector1,id:4286,x:28640,y:32588,varname:node_4286,prsc:2,v1:0.75;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:2178,x:29113,y:32545,varname:node_2178,prsc:2|IN-4456-OUT,IMIN-6106-OUT,IMAX-281-OUT,OMIN-6106-OUT,OMAX-2006-OUT;n:type:ShaderForge.SFN_Vector1,id:6106,x:28640,y:32661,varname:node_6106,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:2006,x:28640,y:32727,varname:node_2006,prsc:2,v1:1;n:type:ShaderForge.SFN_Clamp,id:5892,x:29044,y:31957,varname:node_5892,prsc:2|IN-9766-OUT,MIN-7098-OUT,MAX-8102-OUT;n:type:ShaderForge.SFN_Max,id:5465,x:29541,y:32120,varname:node_5465,prsc:2|A-2204-OUT,B-4289-OUT;n:type:ShaderForge.SFN_Clamp,id:4456,x:29113,y:32364,varname:node_4456,prsc:2|IN-1789-OUT,MIN-6106-OUT,MAX-281-OUT;n:type:ShaderForge.SFN_Distance,id:6174,x:31701,y:33505,varname:node_6174,prsc:2|A-1970-OUT,B-1178-XYZ;n:type:ShaderForge.SFN_FragmentPosition,id:1178,x:31480,y:33545,varname:node_1178,prsc:2;n:type:ShaderForge.SFN_If,id:4345,x:31978,y:33560,varname:node_4345,prsc:2|A-6174-OUT,B-5958-OUT,GT-9078-OUT,EQ-9078-OUT,LT-9450-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5958,x:31701,y:33649,ptovrint:False,ptlb:_Distance,ptin:_Distance,varname:node_5958,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Vector1,id:9078,x:31701,y:33710,varname:node_9078,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:9450,x:31701,y:33764,varname:node_9450,prsc:2,v1:1;n:type:ShaderForge.SFN_Slider,id:6115,x:28956,y:32695,ptovrint:False,ptlb:Shape End Round,ptin:_ShapeEndRound,varname:node_6115,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:6,max:10;n:type:ShaderForge.SFN_Multiply,id:629,x:31931,y:33015,varname:node_629,prsc:2|A-8524-OUT,B-4109-OUT;n:type:ShaderForge.SFN_OneMinus,id:8524,x:31694,y:32960,varname:node_8524,prsc:2|IN-5145-OUT;n:type:ShaderForge.SFN_Set,id:2805,x:30395,y:32202,varname:OffsetMask,prsc:2|IN-1953-OUT;n:type:ShaderForge.SFN_Get,id:5145,x:31521,y:32960,varname:node_5145,prsc:2|IN-2805-OUT;n:type:ShaderForge.SFN_Get,id:908,x:32085,y:32789,varname:node_908,prsc:2|IN-2805-OUT;n:type:ShaderForge.SFN_Set,id:6752,x:28474,y:32091,varname:StartPos,prsc:2|IN-792-XYZ;n:type:ShaderForge.SFN_Get,id:1970,x:31459,y:33484,varname:node_1970,prsc:2|IN-6752-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4518,x:31266,y:33901,ptovrint:False,ptlb:_Progress,ptin:_Progress,varname:node_4518,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:616,x:31709,y:33990,varname:node_616,prsc:2|IN-8135-OUT;n:type:ShaderForge.SFN_Tex2d,id:4168,x:31441,y:34075,ptovrint:False,ptlb:Opacity Cutoff,ptin:_OpacityCutoff,varname:node_6065,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3688-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:5028,x:31709,y:34142,varname:node_5028,prsc:2|IN-4168-R,IMIN-2660-OUT,IMAX-8246-OUT,OMIN-2930-OUT,OMAX-2003-OUT;n:type:ShaderForge.SFN_Vector1,id:2660,x:31441,y:34243,varname:node_2660,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:8246,x:31441,y:34483,varname:node_8246,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:2930,x:31441,y:34327,ptovrint:False,ptlb:Opacity Remap 1,ptin:_OpacityRemap1,varname:node_714,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:2003,x:31441,y:34418,ptovrint:False,ptlb:Opacity Remap 2,ptin:_OpacityRemap2,varname:_OpacityRemap2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Clamp01,id:8135,x:31441,y:33901,varname:node_8135,prsc:2|IN-4518-OUT;n:type:ShaderForge.SFN_Subtract,id:8881,x:31988,y:33963,varname:node_8881,prsc:2|A-5028-OUT,B-616-OUT;n:type:ShaderForge.SFN_Multiply,id:7003,x:32431,y:33756,varname:node_7003,prsc:2|A-4345-OUT,B-8881-OUT;n:type:ShaderForge.SFN_TexCoord,id:426,x:28495,y:32167,varname:node_426,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Append,id:7918,x:28714,y:32143,varname:node_7918,prsc:2|A-927-OUT,B-426-V;n:type:ShaderForge.SFN_Set,id:5549,x:28866,y:32143,varname:UV,prsc:2|IN-7918-OUT;n:type:ShaderForge.SFN_Get,id:3688,x:31266,y:34075,varname:node_3688,prsc:2|IN-5549-OUT;n:type:ShaderForge.SFN_Tex2d,id:5597,x:31287,y:31221,ptovrint:False,ptlb:Noise 01,ptin:_Noise01,varname:node_5597,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9464-OUT;n:type:ShaderForge.SFN_Get,id:261,x:30625,y:31180,varname:node_261,prsc:2|IN-5549-OUT;n:type:ShaderForge.SFN_Panner,id:9095,x:30808,y:31180,varname:node_9095,prsc:2,spu:1,spv:0|UVIN-261-OUT,DIST-1805-OUT;n:type:ShaderForge.SFN_Time,id:1299,x:30451,y:31188,varname:node_1299,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1805,x:30646,y:31242,varname:node_1805,prsc:2|A-1299-T,B-3210-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3210,x:30451,y:31322,ptovrint:False,ptlb:Noise 01 Scroll Speed,ptin:_Noise01ScrollSpeed,varname:node_3210,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-2;n:type:ShaderForge.SFN_Clamp01,id:8608,x:32598,y:33756,varname:node_8608,prsc:2|IN-7003-OUT;n:type:ShaderForge.SFN_Set,id:990,x:31871,y:31278,varname:Noise01,prsc:2|IN-619-OUT;n:type:ShaderForge.SFN_Get,id:6000,x:29792,y:32409,varname:node_6000,prsc:2|IN-990-OUT;n:type:ShaderForge.SFN_Multiply,id:2557,x:29999,y:32385,varname:node_2557,prsc:2|A-6760-OUT,B-6000-OUT,C-4041-OUT;n:type:ShaderForge.SFN_Slider,id:4041,x:29656,y:32481,ptovrint:False,ptlb:Noise 01 Offset Power,ptin:_Noise01OffsetPower,varname:node_4041,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0.1,max:1;n:type:ShaderForge.SFN_Add,id:1953,x:30225,y:32202,varname:node_1953,prsc:2|A-5465-OUT,B-2557-OUT;n:type:ShaderForge.SFN_OneMinus,id:6760,x:29813,y:32287,varname:node_6760,prsc:2|IN-5465-OUT;n:type:ShaderForge.SFN_OneMinus,id:3842,x:31049,y:33318,varname:node_3842,prsc:2|IN-1854-OUT;n:type:ShaderForge.SFN_Add,id:4109,x:31480,y:33318,varname:node_4109,prsc:2|A-1854-OUT,B-8242-OUT,C-860-OUT;n:type:ShaderForge.SFN_Multiply,id:8242,x:31229,y:33318,varname:node_8242,prsc:2|A-3842-OUT,B-616-OUT;n:type:ShaderForge.SFN_Set,id:5189,x:32759,y:33756,varname:HackedOpacity,prsc:2|IN-8608-OUT;n:type:ShaderForge.SFN_Get,id:9465,x:32848,y:33080,varname:node_9465,prsc:2|IN-5189-OUT;n:type:ShaderForge.SFN_Tex2d,id:553,x:30657,y:31438,ptovrint:False,ptlb:Noise 01 Distortion,ptin:_Noise01Distortion,varname:node_553,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6098-UVOUT;n:type:ShaderForge.SFN_RemapRange,id:2157,x:30819,y:31438,varname:node_2157,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-553-R;n:type:ShaderForge.SFN_Add,id:9464,x:31096,y:31221,varname:node_9464,prsc:2|A-9095-UVOUT,B-9435-OUT;n:type:ShaderForge.SFN_Multiply,id:9435,x:31023,y:31475,varname:node_9435,prsc:2|A-2157-OUT,B-2589-OUT;n:type:ShaderForge.SFN_Slider,id:2589,x:30632,y:31655,ptovrint:False,ptlb:Noise 01 Distortion Power,ptin:_Noise01DistortionPower,varname:node_2589,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1,max:1;n:type:ShaderForge.SFN_Get,id:8862,x:30303,y:31445,varname:node_8862,prsc:2|IN-5549-OUT;n:type:ShaderForge.SFN_Panner,id:6098,x:30493,y:31445,varname:node_6098,prsc:2,spu:1,spv:0|UVIN-8862-OUT,DIST-3481-OUT;n:type:ShaderForge.SFN_Time,id:7398,x:30140,y:31460,varname:node_7398,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3481,x:30324,y:31508,varname:node_3481,prsc:2|A-7398-T,B-1235-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1235,x:30140,y:31595,ptovrint:False,ptlb:Noise 01 Distortion Scroll Speed,ptin:_Noise01DistortionScrollSpeed,varname:node_1235,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-6;n:type:ShaderForge.SFN_Power,id:2204,x:29315,y:31730,varname:node_2204,prsc:2|VAL-3003-OUT,EXP-4736-OUT;n:type:ShaderForge.SFN_Power,id:4289,x:29283,y:32545,varname:node_4289,prsc:2|VAL-2178-OUT,EXP-6115-OUT;n:type:ShaderForge.SFN_Slider,id:4736,x:28982,y:31653,ptovrint:False,ptlb:Shape Start Round,ptin:_ShapeStartRound,varname:_EndShape_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:6,max:10;n:type:ShaderForge.SFN_ValueProperty,id:9685,x:28656,y:33114,ptovrint:False,ptlb:_MaxDist,ptin:_MaxDist,varname:node_9685,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Get,id:5629,x:28408,y:33258,varname:node_5629,prsc:2|IN-6752-OUT;n:type:ShaderForge.SFN_Distance,id:8423,x:28656,y:33180,varname:node_8423,prsc:2|A-7744-XYZ,B-5629-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:7744,x:28418,y:33126,varname:node_7744,prsc:2;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:376,x:28903,y:33180,varname:node_376,prsc:2|IN-8423-OUT,IMIN-3582-OUT,IMAX-9685-OUT,OMIN-6590-OUT,OMAX-3275-OUT;n:type:ShaderForge.SFN_Vector1,id:3582,x:28656,y:33020,varname:node_3582,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Vector1,id:6590,x:28656,y:33308,varname:node_6590,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:3275,x:28656,y:33372,varname:node_3275,prsc:2,v1:1;n:type:ShaderForge.SFN_OneMinus,id:1034,x:29066,y:33180,varname:node_1034,prsc:2|IN-376-OUT;n:type:ShaderForge.SFN_Set,id:1076,x:29257,y:33180,varname:MaxDistMask,prsc:2|IN-1034-OUT;n:type:ShaderForge.SFN_Get,id:6864,x:30906,y:32984,varname:node_6864,prsc:2|IN-1076-OUT;n:type:ShaderForge.SFN_OneMinus,id:3299,x:31083,y:32984,varname:node_3299,prsc:2|IN-6864-OUT;n:type:ShaderForge.SFN_Multiply,id:860,x:31307,y:32997,varname:node_860,prsc:2|A-3299-OUT,B-3985-OUT;n:type:ShaderForge.SFN_Slider,id:3985,x:30926,y:32894,ptovrint:False,ptlb:Shape Cone Form,ptin:_ShapeConeForm,varname:node_3985,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Get,id:9603,x:32161,y:32479,varname:node_9603,prsc:2|IN-990-OUT;n:type:ShaderForge.SFN_Add,id:2666,x:31533,y:31278,varname:node_2666,prsc:2|A-5597-R,B-2895-OUT;n:type:ShaderForge.SFN_Slider,id:2895,x:31130,y:31407,ptovrint:False,ptlb:Noise 01 Add,ptin:_Noise01Add,varname:node_2895,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.25,max:1;n:type:ShaderForge.SFN_Clamp01,id:619,x:31701,y:31278,varname:node_619,prsc:2|IN-2666-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1377,x:29123,y:32258,ptovrint:False,ptlb:_FinalSize,ptin:_FinalSize,varname:node_1377,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Divide,id:927,x:29123,y:32114,varname:node_927,prsc:2|A-3971-OUT,B-1377-OUT;n:type:ShaderForge.SFN_Vector1,id:5003,x:27839,y:31571,varname:node_5003,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:8045,x:28055,y:31571,varname:node_8045,prsc:2|A-5003-OUT,B-2764-OUT;n:type:ShaderForge.SFN_Vector1,id:3073,x:27679,y:31669,varname:node_3073,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Multiply,id:2764,x:27862,y:31669,varname:node_2764,prsc:2|A-3073-OUT,B-1377-OUT;n:type:ShaderForge.SFN_Subtract,id:1854,x:30841,y:33173,varname:node_1854,prsc:2|A-1715-OUT,B-2579-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2579,x:30637,y:33254,ptovrint:False,ptlb:_ImpactProgress,ptin:_ImpactProgress,varname:node_2579,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Slider,id:9186,x:32025,y:32555,ptovrint:False,ptlb:GammaLinear,ptin:_GammaLinear,varname:node_9186,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.2,cur:1,max:1;proporder:3884-1809-2951-1715-4736-6115-606-5873-3985-4168-2930-2003-5597-3210-4041-553-1235-2589-2895-9186;pass:END;sub:END;*/

Shader "Sine VFX/V3DLasers/LaserLayerOpaqueSolid" {
    Properties {
        _VertexOffsetPower ("Vertex Offset Power", Float ) = 0
        _FinalColor ("Final Color", Color) = (0.5,0.5,0.5,1)
        _FinalPower ("Final Power", Range(0, 10)) = 2
        _ShapeSize ("Shape Size", Float ) = 0.25
        _ShapeStartRound ("Shape Start Round", Range(1, 10)) = 6
        _ShapeEndRound ("Shape End Round", Range(1, 10)) = 6
        _ShapeAddStartPosition ("Shape Add Start Position", Float ) = 4
        _ShapeAddEndPosition ("Shape Add End Position", Float ) = 4
        _ShapeConeForm ("Shape Cone Form", Range(0, 1)) = 1
        _OpacityCutoff ("Opacity Cutoff", 2D) = "white" {}
        _OpacityRemap1 ("Opacity Remap 1", Float ) = 0
        _OpacityRemap2 ("Opacity Remap 2", Float ) = 0
        _Noise01 ("Noise 01", 2D) = "white" {}
        _Noise01ScrollSpeed ("Noise 01 Scroll Speed", Float ) = -2
        _Noise01OffsetPower ("Noise 01 Offset Power", Range(-1, 1)) = 0.1
        _Noise01Distortion ("Noise 01 Distortion", 2D) = "white" {}
        _Noise01DistortionScrollSpeed ("Noise 01 Distortion Scroll Speed", Float ) = -6
        _Noise01DistortionPower ("Noise 01 Distortion Power", Range(0, 1)) = 0.1
        _Noise01Add ("Noise 01 Add", Range(0, 1)) = 0.25
        _GammaLinear ("GammaLinear", Range(0.2, 1)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float4 _StartPosition;
            uniform float4 _EndPosition;
            uniform float4 _FinalColor;
            uniform float _FinalPower;
            uniform float _VertexOffsetPower;
            uniform float _ShapeAddStartPosition;
            uniform float _ShapeAddEndPosition;
            uniform float _ShapeSize;
            uniform float _Distance;
            uniform float _ShapeEndRound;
            uniform float _Progress;
            uniform sampler2D _OpacityCutoff; uniform float4 _OpacityCutoff_ST;
            uniform float _OpacityRemap1;
            uniform float _OpacityRemap2;
            uniform sampler2D _Noise01; uniform float4 _Noise01_ST;
            uniform float _Noise01ScrollSpeed;
            uniform float _Noise01OffsetPower;
            uniform sampler2D _Noise01Distortion; uniform float4 _Noise01Distortion_ST;
            uniform float _Noise01DistortionPower;
            uniform float _Noise01DistortionScrollSpeed;
            uniform float _ShapeStartRound;
            uniform float _MaxDist;
            uniform float _ShapeConeForm;
            uniform float _Noise01Add;
            uniform float _FinalSize;
            uniform float _ImpactProgress;
            uniform float _GammaLinear;
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
                float node_3971 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_StartPosition.rgb);
                float node_7098 = 0.0;
                float node_8045 = (1.0-(0.25*_FinalSize));
                float node_8102 = (node_8045+_ShapeAddStartPosition);
                float node_6106 = 0.0;
                float node_281 = (_ShapeAddEndPosition+node_8045);
                float node_5465 = max(pow((node_7098 + ( (clamp(((1.0 - node_3971)+_ShapeAddStartPosition),node_7098,node_8102) - node_7098) * (1.0 - node_7098) ) / (node_8102 - node_7098)),_ShapeStartRound),pow((node_6106 + ( (clamp(((1.0 - distance(_EndPosition.rgb,mul(unity_ObjectToWorld, v.vertex).rgb))+_ShapeAddEndPosition),node_6106,node_281) - node_6106) * (1.0 - node_6106) ) / (node_281 - node_6106)),_ShapeEndRound));
                float4 node_1299 = _Time;
                float2 UV = float2((node_3971/_FinalSize),o.uv0.g);
                float4 node_7398 = _Time;
                float2 node_6098 = (UV+(node_7398.g*_Noise01DistortionScrollSpeed)*float2(1,0));
                float4 _Noise01Distortion_var = tex2Dlod(_Noise01Distortion,float4(TRANSFORM_TEX(node_6098, _Noise01Distortion),0.0,0));
                float2 node_9464 = ((UV+(node_1299.g*_Noise01ScrollSpeed)*float2(1,0))+((_Noise01Distortion_var.r*2.0+-1.0)*_Noise01DistortionPower));
                float4 _Noise01_var = tex2Dlod(_Noise01,float4(TRANSFORM_TEX(node_9464, _Noise01),0.0,0));
                float Noise01 = saturate((_Noise01_var.r+_Noise01Add));
                float OffsetMask = (node_5465+((1.0 - node_5465)*Noise01*_Noise01OffsetPower));
                float node_1854 = (_ShapeSize-_ImpactProgress);
                float node_616 = (1.0 - saturate(_Progress));
                float3 StartPos = _StartPosition.rgb;
                float node_3582 = 0.25;
                float node_6590 = 0.0;
                float MaxDistMask = (1.0 - (node_6590 + ( (distance(mul(unity_ObjectToWorld, v.vertex).rgb,StartPos) - node_3582) * (1.0 - node_6590) ) / (_MaxDist - node_3582)));
                v.vertex.xyz += ((OffsetMask+((1.0 - OffsetMask)*(node_1854+((1.0 - node_1854)*node_616)+((1.0 - MaxDistMask)*_ShapeConeForm))))*v.normal*_VertexOffsetPower*_FinalSize);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 StartPos = _StartPosition.rgb;
                float node_4345_if_leA = step(distance(StartPos,i.posWorld.rgb),_Distance);
                float node_4345_if_leB = step(_Distance,distance(StartPos,i.posWorld.rgb));
                float node_9078 = 0.0;
                float node_3971 = distance(i.posWorld.rgb,_StartPosition.rgb);
                float2 UV = float2((node_3971/_FinalSize),i.uv0.g);
                float2 node_3688 = UV;
                float4 _OpacityCutoff_var = tex2D(_OpacityCutoff,TRANSFORM_TEX(node_3688, _OpacityCutoff));
                float node_2660 = 0.0;
                float node_616 = (1.0 - saturate(_Progress));
                float HackedOpacity = saturate((lerp((node_4345_if_leA*1.0)+(node_4345_if_leB*node_9078),node_9078,node_4345_if_leA*node_4345_if_leB)*((_OpacityRemap1 + ( (_OpacityCutoff_var.r - node_2660) * (_OpacityRemap2 - _OpacityRemap1) ) / (1.0 - node_2660))-node_616)));
                clip(HackedOpacity - 0.5);
////// Lighting:
////// Emissive:
                float4 node_1299 = _Time;
                float4 node_7398 = _Time;
                float2 node_6098 = (UV+(node_7398.g*_Noise01DistortionScrollSpeed)*float2(1,0));
                float4 _Noise01Distortion_var = tex2D(_Noise01Distortion,TRANSFORM_TEX(node_6098, _Noise01Distortion));
                float2 node_9464 = ((UV+(node_1299.g*_Noise01ScrollSpeed)*float2(1,0))+((_Noise01Distortion_var.r*2.0+-1.0)*_Noise01DistortionPower));
                float4 _Noise01_var = tex2D(_Noise01,TRANSFORM_TEX(node_9464, _Noise01));
                float Noise01 = saturate((_Noise01_var.r+_Noise01Add));
                float3 emissive = (_FinalColor.rgb*_FinalPower*Noise01*_GammaLinear);
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
