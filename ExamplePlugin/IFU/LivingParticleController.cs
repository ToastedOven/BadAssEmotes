using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace ExamplePlugin
{

    public class LivingParticleController : MonoBehaviour
    {

        public Transform affector;

        private ParticleSystemRenderer psr;

        void Start()
        {
            psr = GetComponent<ParticleSystemRenderer>();
        }

        void Update()
        {
            psr.material.SetVector("_Affector", affector.position);
        }
    }
}
