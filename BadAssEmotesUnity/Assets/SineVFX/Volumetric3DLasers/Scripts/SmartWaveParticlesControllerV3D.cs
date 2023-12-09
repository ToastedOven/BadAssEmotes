using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SmartWaveParticlesControllerV3D : MonoBehaviour
{

    public Transform startLaserPoint;
    public ParticleSystem controlPS;
    public ParticleSystem distortionSpherePS;
    public AnimationCurve ac;

    private float globalProgress;
    private Renderer[] renderers;
    private ParticleSystem.Particle[] controlParticles;
    private Vector4[] controlParticlesPositions;
    private float[] controlParticlesSizes;

    void Start()
    {
        controlParticlesPositions = new Vector4[5];
        controlParticlesSizes = new float[5];
        renderers = GetComponentsInChildren<Renderer>();
    }

    public void SetGlobalProgress(float gp)
    {
        globalProgress = gp;
    }

    // Spawn control particle and distortion sphere particle
    public void SpawnWave()
    {
        controlParticles = new ParticleSystem.Particle[5];

        if (Input.GetMouseButtonDown(0))
        {
            distortionSpherePS.Emit(1);
            controlPS.Emit(1);
        }
    }

    void Update()
    {
        SpawnWave();
        controlPS.GetParticles(controlParticles);
        for (int i = 0; i < 5; i++)
        {
            controlParticlesPositions[i] = controlParticles[i].position;
            controlParticlesSizes[i] = controlParticles[i].GetCurrentSize(controlPS) * controlPS.transform.lossyScale.x;
        }

        // Sending position and scale to visual particle shader
        foreach (Renderer rend in renderers)
        {
            for (int i = 0; i < 5; i++)
            {
                rend.material.SetVector("_ControlParticlePosition" + i, controlParticlesPositions[i]);
                rend.material.SetFloat("_ControlParticleSize" + i, controlParticlesSizes[i]);
            }

            rend.material.SetVector("_StartLaserPosition", startLaserPoint.position);
            rend.material.SetFloat("_StartLaserProgress", ac.Evaluate(globalProgress));
            rend.material.SetFloat("_PSLossyScale", controlPS.transform.lossyScale.x);
        }

    }
}
