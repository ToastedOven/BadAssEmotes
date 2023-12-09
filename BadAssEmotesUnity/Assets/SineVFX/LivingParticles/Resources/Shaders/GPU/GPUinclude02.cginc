struct MyParticleInstanceData
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles
           {
                float3x4 transform;
                uint color;
				float size;
				float3 center;
				float3 rotation3d;
           };