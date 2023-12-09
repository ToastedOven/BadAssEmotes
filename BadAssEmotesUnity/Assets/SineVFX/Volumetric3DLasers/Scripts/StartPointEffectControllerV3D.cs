using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartPointEffectControllerV3D : MonoBehaviour
{

    public Light pointLight;
    public float pointLightRange = 10f;
    public float pointLightIntensity = 1f;
    public ParticleSystem[] scalingParticleSystems;
    public ParticleSystem[] emittingParticleSystems;
    public bool emit = false;
    public AnimationCurve progressCurve;
    public AnimationCurve impactCurve;
    public Color finalColor;

    private float globalProgress;
    private float globalResultProgress;
    private float globalImpactProgress;
    private float globalImpactResultProgress;
    private float resultProgress;
    private Vector3[] initialLocalScale;

    private void Start()
    {
        initialLocalScale = new Vector3[scalingParticleSystems.Length];
        for (int i = 0; i < scalingParticleSystems.Length; i++)
        {
            initialLocalScale[i] = scalingParticleSystems[i].transform.localScale;
        }
    }

    public void SetGlobalProgress(float gp)
    {
        globalProgress = gp;
    }

    public void SetFinalColor(Color col)
    {
        finalColor = col;
    }

    public void SetGlobalImpactProgress(float gp)
    {
        globalImpactProgress = gp;
    }

    void Update()
    {

        // Emir when progress is near 1f
        if (resultProgress > 0.9f)
        {
            emit = true;
        }
        else
        {
            emit = false;
        }

        // Result Control
        globalImpactResultProgress = impactCurve.Evaluate(globalImpactProgress);
        if (globalImpactResultProgress == 0f)
        {
            globalImpactResultProgress = 0.001f;
        }

        globalResultProgress = progressCurve.Evaluate(globalProgress);
        resultProgress = globalImpactResultProgress + globalResultProgress;


        // Scaling Particle Systems Control
        for (int i = 0; i < scalingParticleSystems.Length; i++)
        {
            scalingParticleSystems[i].transform.localScale = initialLocalScale[i] * resultProgress;
            if (resultProgress < 0.01f)
            {
                scalingParticleSystems[i].gameObject.SetActive(false);
            }
            else
            {
                scalingParticleSystems[i].gameObject.SetActive(true);
            }
        }

        // Emitting Particle Systems Control
        if (emit == true)
        {
            foreach (ParticleSystem ps in emittingParticleSystems)
            {
                var em = ps.emission;
                em.enabled = true;
            }
        }
        else
        {
            foreach (ParticleSystem ps in emittingParticleSystems)
            {
                var em = ps.emission;
                em.enabled = false;
            }
        }

        // Start Point Light Control
        pointLight.color = finalColor;
        pointLight.range = transform.lossyScale.x * pointLightRange;
        pointLight.intensity = resultProgress * pointLightIntensity;

    }
}
