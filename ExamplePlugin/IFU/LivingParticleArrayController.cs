using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ExamplePlugin
{

    public class LivingParticleArrayController : MonoBehaviour
    {

        public Transform[] affectors;

        private Vector4[] positions;
        private ParticleSystemRenderer psr;

        void Start()
        {
            //error here?
            psr = GetComponent<ParticleSystemRenderer>(); //prob this
            Vector4[] maxArray = new Vector4[20];
            psr.material.SetVectorArray("_Affectors", maxArray);
        }

        // Sending an array of positions to particle shader
        void Update()
        {
            positions = new Vector4[affectors.Length];
            for (int i = 0; i < positions.Length; i++)
            {
                positions[i] = affectors[i].position;
            }
            psr.material.SetVectorArray("_Affectors", positions);
            psr.material.SetInt("_AffectorCount", affectors.Length);
        }
    }
}
