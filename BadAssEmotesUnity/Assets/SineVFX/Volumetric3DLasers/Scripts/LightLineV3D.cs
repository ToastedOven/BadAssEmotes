using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightLineV3D : MonoBehaviour
{
    public float maxLength = 32.0f;

    public AnimationCurve shaderProgressCurve;
    public AnimationCurve shaderImpactCurve;
    public float moveHitToSource = 0.5f;
    public int distanceBetweenLights = 1;
    public bool scalingWithSize = true;
    public float finalSize = 1f;
    public Light lightPrefab;
    public float lightRange = 5f;
    public float lightIntensity = 1f;
    public Color finalColor;
    public bool scaleDensityWithSize = false;

    private Color currentColor;
    private Vector3[] pointLightSpawnPositions;
    private float globalProgress;
    private float globalimpactProgress;
    private int positionArrayLenght;
    private Light[] lights;
    private int roundedMaxLength;

    private float progress;
    private float impactProgress;
    private float resultProgress;    

    // Updating and Fading
    void LaserControl()
    {
        progress = shaderProgressCurve.Evaluate(globalProgress);
        impactProgress = shaderImpactCurve.Evaluate(globalimpactProgress);
        resultProgress = progress + impactProgress;
    }

    // Function for recieving color value from Progress Control script
    public void SetFinalColor(Color col)
    {
        finalColor = col;
    }

    // Initialize Laser Line
    void LaserCastRay()
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position, transform.forward, out hit, maxLength))
        {
            positionArrayLenght = Mathf.RoundToInt(hit.distance / distanceBetweenLights);
            pointLightSpawnPositions = new Vector3[positionArrayLenght];
        }
        else
        {
            positionArrayLenght = Mathf.RoundToInt(maxLength / distanceBetweenLights);
            pointLightSpawnPositions = new Vector3[positionArrayLenght];
        }
    }

    // Instantiating Light Prefabs
    private void CreateLights()
    {
        lights = new Light[roundedMaxLength];

        for (int i = 0; i < roundedMaxLength; i++)
        {
            lights[i] = (Light)Instantiate(lightPrefab);
            lights[i].transform.parent = transform;
            lights[i].gameObject.SetActive(false);
            lights[i].color = finalColor;
        }
    }

    // Turn Lights On and Off depending on distance
    private void ActivateLights()
    {
        for (int i = 0; i < roundedMaxLength; i++)
        {
            lights[i].gameObject.SetActive(false);
        }

        for (int i = 0; i < positionArrayLenght; i++)
        {
            lights[i].color = finalColor;
            lights[i].gameObject.SetActive(true);
        }
    }

    void Start()
    {
        roundedMaxLength = Mathf.RoundToInt(maxLength);
        CreateLights();
        LaserCastRay();
        ActivateLights();
        LaserControl();
        UpdateLaserParts();
    }

    // Updating Lights Intensity and Range
    void UpdateLaserParts()
    {
        for (int i = 0; i < positionArrayLenght; i++)
        {
            pointLightSpawnPositions[i] = new Vector3(0f, 0f, 0f) + new Vector3(0f, 0f, i * distanceBetweenLights * (1 / finalSize));
            lights[i].transform.localPosition = pointLightSpawnPositions[i];
            lights[i].intensity = resultProgress * lightIntensity;
            lights[i].range = lightRange * finalSize;
        }
    }

    // Function for recieving progress value from Progress Control script
    public void SetGlobalProgress(float gp)
    {
        globalProgress = gp;
    }

    // Function for recieving impact progress value from Progress Control script
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

        if (positionArrayLenght != lights.Length || currentColor != finalColor)
        {
            ActivateLights();
        }

        UpdateLaserParts();
        currentColor = finalColor;
    }
}
