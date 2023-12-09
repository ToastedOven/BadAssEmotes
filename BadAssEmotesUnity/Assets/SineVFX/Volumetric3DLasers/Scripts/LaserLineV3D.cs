using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LaserLineV3D : MonoBehaviour
{
    public float maxLength = 1.0f;

    public AnimationCurve shaderProgressCurve;
    public AnimationCurve shaderImpactCurve;
    public float moveHitToSource = 0.5f;
    public int particleMeshLength = 1;
    public bool scalingWithSize = true;
    public float finalSize = 1f;

    private float preSize;
    private float HitLength;
    private ParticleSystem ps;
    private ParticleSystemRenderer psr;
    private Vector3 positionForExplosion;
    private Vector3[] particleSpawnPositions;
    private Vector3 endPoint;
    private float globalProgress;
    private float globalimpactProgress;
    private ParticleSystem.Particle[] particles;
    private int positionArrayLength;
    private bool tempFix = false;

    // Updating and Fading
    void LaserControl() 
    {
        float progress = shaderProgressCurve.Evaluate(globalProgress);
        psr.material.SetFloat("_Progress", progress);
        float impactProgress = shaderImpactCurve.Evaluate(globalimpactProgress);
        psr.material.SetFloat("_ImpactProgress", impactProgress);
        psr.material.SetVector("_StartPosition", transform.position);
        psr.material.SetVector("_EndPosition", endPoint);
        psr.material.SetFloat("_Distance", HitLength);
        psr.material.SetFloat("_MaxDist", HitLength);
        psr.material.SetFloat("_FinalSize", finalSize);
    }

    // Initialize Laser Line
    void LaserCastRay()
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position, transform.forward, out hit, maxLength))
        {
            HitLength = hit.distance;
            positionForExplosion = Vector3.MoveTowards(hit.point, transform.position, moveHitToSource);
            positionArrayLength = Mathf.RoundToInt(hit.distance / (particleMeshLength * finalSize));
            if (positionArrayLength < hit.distance)
            {
                positionArrayLength += 1;
            }
            particleSpawnPositions = new Vector3[positionArrayLength];
            endPoint = hit.point;
        }
        else
        {
            HitLength = maxLength;
            positionArrayLength = Mathf.RoundToInt(maxLength / (particleMeshLength * finalSize));
            if (positionArrayLength < maxLength)
            {
                positionArrayLength += 1;
            }
            particleSpawnPositions = new Vector3[positionArrayLength];
            endPoint = Vector3.MoveTowards(transform.position, transform.forward * 1000f, maxLength);
            positionForExplosion = endPoint;
        }
    }

    void Start()
    {
        ps = GetComponent<ParticleSystem>();
        psr = GetComponent<ParticleSystemRenderer>();
        HitLength = 0;
        LaserCastRay();
        LaserControl();
        UpdateLaserParts();
        tempFix = true;
    }

    void OnEnable()
    {
        if (tempFix == true)
        {
            UpdateLaserParts();
        }        
    }

    // Updating Laser parts positions and length
    void UpdateLaserParts()
    {
        particles = new ParticleSystem.Particle[positionArrayLength];

        for (int i = 0; i < positionArrayLength; i++)
        {
            particleSpawnPositions[i] = new Vector3(0f, 0f, 0f) + new Vector3(0f, 0f, i*particleMeshLength * finalSize);
            particles[i].position = particleSpawnPositions[i];
            particles[i].startSize = finalSize;
            particles[i].startColor = new Color(1f, 1f, 1f);
        }

        ps.SetParticles(particles, particles.Length);

    }

    // Recieving global progress from control script
    public void SetGlobalProgress(float gp)
    {
        globalProgress = gp;
    }

    // Recieving end position from control script
    public Vector3 GetEndPointPosition()
    {
        return positionForExplosion;
    }

    // Recieving global impact progress from control script
    public void SetGlobalImpactProgress(float gp)
    {
        globalimpactProgress = gp;
    }

    void Update()
    {
        if (scalingWithSize == true)
        {
            finalSize = gameObject.transform.lossyScale.x;
        }
        LaserCastRay();
        LaserControl();
        if (positionArrayLength != particles.Length || preSize != finalSize)
        {
            UpdateLaserParts();
        }
        preSize = finalSize;
    }
}
