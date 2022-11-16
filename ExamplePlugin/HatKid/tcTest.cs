using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TC;
using System.Threading.Tasks;
namespace testMod
{


    public class tcTest : MonoBehaviour
    {
        // Start is called before the first frame update
        public TCParticleSystem tcParticleSystem;

        [SerializeField]
        int emitPerFrame;
        Mesh mesh;
        public SkinnedMeshRenderer referencedMesh;


        float timer;
        ColorHSV color;

        public bool refMeshSet = false;
        void Start()
        {
            TryGetComponent<TCParticleSystem>(out tcParticleSystem);
            if (!tcParticleSystem)
            {
                tcParticleSystem = new TCParticleSystem();

                tcParticleSystem.Looping = true;
                tcParticleSystem.Duration = 2.9f;
                tcParticleSystem.MaxParticles = 100000;

                tcParticleSystem.Emitter.EmissionRate = 0;
                tcParticleSystem.Emitter.Shape = EmitShapes.Mesh;
                MinMaxRandom minMaxRandom = new MinMaxRandom();
                minMaxRandom.Mode = MinMaxRandom.MinMaxMode.Constant;
                minMaxRandom.Value = 0.5f;
                tcParticleSystem.Manager.SimulationSpace = TC.Space.World;
                tcParticleSystem.Emitter.Lifetime = minMaxRandom;
                tcParticleSystem.Emitter.StartDirectionType = StartDirection.Normal;
                tcParticleSystem.Emitter.VelocityOverLifetime = Vector3Curve.Zero();
                minMaxRandom.Value = 0.02f;
                tcParticleSystem.Emitter.Size = minMaxRandom;
                tcParticleSystem.Emitter.SizeOverLifetime = AnimationCurve.Linear(0, 1, 1, 0);
                tcParticleSystem.ForceManager.MaxForces = 0;
                tcParticleSystem.ColliderManager.MaxColliders = 0;
                //tcParticleSystem.ParticleRenderer.Material = Assets.particleMat;
                tcParticleSystem.ParticleRenderer.glow = 1;
            }


            if (!referencedMesh)
            {
                referencedMesh = gameObject.transform.parent.GetComponent<SkinnedMeshRenderer>();
                SetupSkinnedMesh(referencedMesh);
            }




            //tcParticleSystem.Stop();


            //if (!referencedMesh)
            //    referencedMesh = transform.parent.GetComponent<SkinnedMeshRenderer>();



            // Debug.Log(referencedMesh.sharedMesh.name + " has " + referencedMesh.sharedMesh.subMeshCount + " submesh(es).");
        }
        private void Update()
        {
            if (refMeshSet)
            {
                timer -= Time.deltaTime;
                if (color.H < 360)
                    color.H += 1;
                else
                {
                    color.H = 0;
                }
                tcParticleSystem.ParticleRenderer.Material.color = color.ToColor();
            }




        }
        // Update is called once per frame
        void FixedUpdate()
        {




            if (refMeshSet)
            {
                if (timer <= 0f)
                {
                    mesh = new Mesh();
                    referencedMesh.BakeMesh(mesh);
                    timer = 0.1f;

                    tcParticleSystem.Emitter.EmitMesh = mesh;


                }
            }



        }

        void SetupSkinnedMesh(SkinnedMeshRenderer skinnedMeshRenderer)
        {
            if (tcParticleSystem.IsPlaying)
                tcParticleSystem.Manager.Stop();
            tcParticleSystem.Manager.MaxParticles = 1000000;



            float surfaceArea = CalculateSurfaceArea(referencedMesh.sharedMesh);
            surfaceArea = referencedMesh.bounds.size.magnitude * surfaceArea;
            MinMaxRandom minMax = new MinMaxRandom();
            minMax.Mode = MinMaxRandom.MinMaxMode.Constant;
            minMax.Value = 0.025f;
            tcParticleSystem.Emitter.Size = minMax;

            tcParticleSystem.Emitter.VelocityOverLifetime = Vector3Curve.Zero();

            if (!tcParticleSystem.IsWorldSpace)
            {
                tcParticleSystem.Manager.SimulationSpace = TC.Space.World;
            }
            if (tcParticleSystem.Emitter.Shape != EmitShapes.Mesh)
            {
                tcParticleSystem.Emitter.Shape = EmitShapes.Mesh;
            }
            //Debug.Log("area of " + referencedMesh.sharedMesh.name + ": " + surfaceArea);
            emitPerFrame = Mathf.CeilToInt(surfaceArea * referencedMesh.sharedMesh.triangles.Length * 0.025f);

            int a = emitPerFrame * 30;
            if (a > tcParticleSystem.MaxParticles)
            {
                tcParticleSystem.MaxParticles = a;
            }



            timer = 0.1f;
            color = new ColorHSV(Color.red);
            float temp = 0f;
            BurstEmission[] burts = new BurstEmission[30];
            for (int i = 0; i < burts.Length; i++)
            {
                burts[i].Time = temp;
                burts[i].Amount = emitPerFrame;
                temp += 0.1f;
            }
            MinMaxRandom minMax1 = new MinMaxRandom();
            minMax1.Mode = MinMaxRandom.MinMaxMode.Constant;
            minMax1.Value = 0.5f;
            tcParticleSystem.Emitter.Lifetime = minMax1;

            tcParticleSystem.Emitter.SetBursts(burts);
            tcParticleSystem.Manager.Play();
            refMeshSet = true;
        }
        float CalculateSurfaceArea(Mesh mesh)
        {
            var triangles = mesh.triangles;
            var vertices = mesh.vertices;

            double sum = 0.0;

            for (int i = 0; i < triangles.Length; i += 3)
            {
                Vector3 corner = vertices[triangles[i]];
                Vector3 a = vertices[triangles[i + 1]] - corner;
                Vector3 b = vertices[triangles[i + 2]] - corner;

                sum += Vector3.Cross(a, b).magnitude;
            }

            return (float)(sum / 2.0);
        }



    }
}
