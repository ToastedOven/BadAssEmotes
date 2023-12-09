using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndPointEffectControllerV3D : MonoBehaviour {

    public Light pointLight;
    public float pointLightRange = 10f;
    public float pointLightIntensity = 1f;
    public Color finalColor;
    public AnimationCurve progressCurve;
    public AnimationCurve impactCurve;
    public LaserLineV3D getEndPointPositionFrom;
    public ParticleSystem[] emittingParticleSystems;
    public GameObject[] scalingComponents;
    public bool emit = false;

    private bool currentEmit = false;
    private Vector3 endPointPosition;
    private float globalProgress;
    private float globalResultProgress;
    private float globalImpactProgress;
    private float globalImpactResultProgress;
    private float resultProgress;
    private Vector3[] initialLocalScale;

    void Start () {
        SetEmission();
        endPointPosition = getEndPointPositionFrom.GetEndPointPosition();

        initialLocalScale = new Vector3[scalingComponents.Length];
        for (int i = 0; i < scalingComponents.Length; i++)
        {
            initialLocalScale[i] = scalingComponents[i].transform.localScale;        }

    }

    // Recieving color from control script
    public void SetFinalColor(Color col)
    {
        finalColor = col;
    }

    // Recieving emission from control script
    void SetEmission()
    {
        foreach (ParticleSystem ps in emittingParticleSystems)
        {
            var em = ps.emission;
            em.enabled = emit;
        }
    }

    // Recieving global progress from control script
    public void SetGlobalProgress(float gp)
    {
        globalProgress = gp;
    }

    // Recieving global impact progress from control script
    public void SetGlobalImpactProgress(float gp)
    {
        globalImpactProgress = gp;
    }

    void Update () {

        // Positioning End Point effect
        endPointPosition = getEndPointPositionFrom.GetEndPointPosition();
        gameObject.transform.position = endPointPosition;

        if (currentEmit != emit)
        {
            SetEmission();
        }

        currentEmit = emit;

        // Result Control
        globalImpactResultProgress = impactCurve.Evaluate(globalImpactProgress);
        if (globalImpactResultProgress == 0f)
        {
            globalImpactResultProgress = 0.001f;
        }

        globalResultProgress = progressCurve.Evaluate(globalProgress);
        resultProgress = globalImpactResultProgress + globalResultProgress;

        // Scaling Particle Systems Control
        for (int i = 0; i < scalingComponents.Length; i++)
        {
            scalingComponents[i].transform.localScale = initialLocalScale[i] * resultProgress;
            if (resultProgress < 0.01f)
            {
                scalingComponents[i].gameObject.SetActive(false);
            }
            else
            {
                scalingComponents[i].gameObject.SetActive(true);
            }
        }

        // End Point Light Control
        if (pointLight != null)
        {
            pointLight.color = finalColor;
            pointLight.range = transform.lossyScale.x * pointLightRange;
            pointLight.intensity = resultProgress * pointLightIntensity;
        }

    }

}
