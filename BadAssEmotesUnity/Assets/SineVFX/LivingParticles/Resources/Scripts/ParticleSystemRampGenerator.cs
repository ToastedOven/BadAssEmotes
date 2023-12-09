using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

public class ParticleSystemRampGenerator : MonoBehaviour {

    public Gradient[] activeProcedrualGradientRamp;
    //public Gradient procedrualGradientRamp1;
    //public Gradient procedrualGradientRamp2;
    //public Gradient procedrualGradientRamp3;
    //public Gradient procedrualGradientRamp4;
    //public Gradient activeProcedrualGradientRamp;
    [Range(0,1)]
    public float RampSpeed;
    public bool useRampSpeed;
    public int activeRamp;
    public bool turnOnProceduralRamp;
    public bool procedrualGradientEnabled = false;
    public bool updateEveryFrame = false;

    private ParticleSystemRenderer psr;
    private Texture2D rampTexture;
    private Texture2D tempTexture;
    private float width = 256;
    private float height = 1;
    private float timer = 0;

    void Start () {
        psr = GetComponent<ParticleSystemRenderer>();

        if (procedrualGradientEnabled == true)
        {
            UpdateRampTexture();
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < activeProcedrualGradientRamp.Length; i++)
        {
            sb.Append($"ramp.activeProcedrualGradientRamp[{i}].alphaKeys = new GradientAlphaKey[] {{");
            foreach (var item in activeProcedrualGradientRamp[i].alphaKeys)
            {
                sb.Append($"new GradientAlphaKey({item.alpha}f, {item.time}f)");
                if (item.time != activeProcedrualGradientRamp[i].alphaKeys[activeProcedrualGradientRamp[i].alphaKeys.Length - 1].time)
                {
                    sb.Append(',');
                }
            }
            sb.Append("};\n");


            sb.Append($"ramp.activeProcedrualGradientRamp[{i}].colorKeys = new GradientColorKey[] {{");
            foreach (var item in activeProcedrualGradientRamp[i].colorKeys)
            {
                sb.Append($"new GradientColorKey(new Color({item.color.r}f, {item.color.g}f, {item.color.b}f, {item.color.a}f), {item.time}f)");
                if (item.time != activeProcedrualGradientRamp[i].colorKeys[activeProcedrualGradientRamp[i].colorKeys.Length - 1].time)
                {
                    sb.Append(',');
                }
            }
            sb.Append("};\n\n");
        }
        File.WriteAllText("Pain.txt", sb.ToString());
    }

    void SetActiveRamp(Gradient grad)
    {
        activeProcedrualGradientRamp[activeRamp] = grad;
    }

    void Update () {
        if (procedrualGradientEnabled == true)
        {
            if (updateEveryFrame == true)
            {
                UpdateRampTexture();
            }

        }
        timer += Time.deltaTime;
        if (useRampSpeed)
        {
            timer = 0;
            for (int i = 0; i < activeProcedrualGradientRamp[activeRamp].colorKeys.Length; i++)
            {
                GradientColorKey[] keys = activeProcedrualGradientRamp[activeRamp].colorKeys;
                for (int x = 0; x < keys.Length; x++)
                {
                    keys[x].time += Time.deltaTime * RampSpeed;
                    if (keys[x].time > 1.0f)
                    {
                        keys[x].time -= 1.0f;
                    }
                }
                activeProcedrualGradientRamp[activeRamp].SetKeys(keys, activeProcedrualGradientRamp[activeRamp].alphaKeys);
            }
        }
    }

    // Generating a texture from gradient variable
    Texture2D GenerateTextureFromGradient(Gradient grad)
    {        
        if (tempTexture == null)
        {
            tempTexture = new Texture2D((int)width, (int)height);
        }        
        for (int x = 0; x < width; x++)
        {
            for (int y = 0; y < height; y++)
            {
                Color col = grad.Evaluate(0 + (x / width));
                tempTexture.SetPixel(x, y, col);
            }
        }
        tempTexture.wrapMode = TextureWrapMode.Clamp;
        tempTexture.Apply();
        return tempTexture;
    }

    // Update procedural ramp textures and applying them to the shaders
    public void UpdateRampTexture()
    {
        //procedrualGradientRamp.colorKeys[1].color.g += Time.deltaTime;
        //procedrualGradientRamp.colorKeys[1].color.g =
        //procedrualGradientRamp.colorKeys[1].color.g % 1f;
        //procedrualGradientRamp.colorKeys[1].color = Color.blue;
        //Debug.Log(procedrualGradientRamp.colorKeys[1].color);
        rampTexture = GenerateTextureFromGradient(activeProcedrualGradientRamp[activeRamp]);
        psr.material.SetTexture("_Ramp", rampTexture);
    }
}
