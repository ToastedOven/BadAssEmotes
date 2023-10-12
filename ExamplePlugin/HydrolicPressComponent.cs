using BadAssEmotes;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using static Rewired.Utils.Classes.Utility.ObjectInstanceTracker;

namespace ExamplePlugin
{
    internal class HydrolicPressComponent : MonoBehaviour
    {
        bool crushPlayer = false;
        Transform pressTransform;
        internal BoneMapper boneMapper;
        bool compressing = true;
        Vector3 currentScale;
        float doNotRevert;
        bool spawnedFeathers = false;
        void Start()
        {
            StartCoroutine(CrushAfterSeconds(3.5f));
            AkSoundEngine.PostEvent("Stop_Hydrolic", BadAssEmotesPlugin.pressMechanism);
            AkSoundEngine.PostEvent("Stop_hydraulicpressing", BadAssEmotesPlugin.pressMechanism);
            AkSoundEngine.PostEvent("Play_hydraulicpressing", BadAssEmotesPlugin.pressMechanism);
            AkSoundEngine.PostEvent(BadAssEmotesPlugin.pressMechanism.GetComponent<HydrolicPressMechanism>().lowes ? "Play_LowesCrush" : "Play_HomeDepotCrush", BadAssEmotesPlugin.pressMechanism);
            pressTransform = BadAssEmotesPlugin.pressMechanism.transform.Find("press");
            BadAssEmotesPlugin.pressMechanism.transform.localScale = new Vector3(boneMapper.scale, boneMapper.scale, boneMapper.scale);
        }
        void Update()
        {
            if (transform.localScale.y > .01f && compressing)
            {
                if (crushPlayer)
                    transform.localScale = new Vector3(transform.localScale.x + (.16f * Time.deltaTime), transform.localScale.y - (.16f * Time.deltaTime), transform.localScale.z + (.16f * Time.deltaTime));
                pressTransform.localScale = new Vector3(pressTransform.localScale.x, pressTransform.localScale.y, pressTransform.localScale.z + (.154f * Time.deltaTime));
                if (!spawnedFeathers && transform.localScale.y < .107f)
                {
                    int prop1 = boneMapper.props.Count;
                    GameObject sex = Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/explosion press.prefab");
                    boneMapper.props.Add(GameObject.Instantiate(sex));
                    boneMapper.props[prop1].transform.SetParent(boneMapper.transform.parent);
                    boneMapper.props[prop1].transform.localEulerAngles = new Vector3(270, 0, 0);
                    boneMapper.props[prop1].transform.localPosition = Vector3.zero;
                    boneMapper.props[prop1].transform.SetParent(null);
                    boneMapper.props[prop1].transform.localScale = new Vector3(boneMapper.scale, boneMapper.scale, boneMapper.scale);
                    BadAssEmotesPlugin.instance.StartCoroutine(BadAssEmotesPlugin.instance.WaitForSecondsThenDeleteGameObject(boneMapper.props[prop1], 10f));
                    boneMapper.props.RemoveAt(prop1);
                    spawnedFeathers = true;
                }
                if (transform.localScale.y < .01f)
                {
                    compressing = false;
                    transform.localScale = new Vector3(transform.localScale.x, .01f, transform.localScale.z);
                    currentScale = transform.localScale;
                    doNotRevert = 0;
                    transform.parent = null;
                    transform.localScale = currentScale;
                    pressTransform.localScale = new Vector3(0.8631962f, 0.8631962f, 0.8631962f);
                    AkSoundEngine.PostEvent("Stop_Hydrolic", BadAssEmotesPlugin.pressMechanism);
                    AkSoundEngine.PostEvent("Stop_hydraulicpressing", BadAssEmotesPlugin.pressMechanism);
                    AkSoundEngine.PostEvent(BadAssEmotesPlugin.pressMechanism.GetComponent<HydrolicPressMechanism>().lowes ? "Play_LowesIdle" : "Play_HomeDepotIdle", BadAssEmotesPlugin.pressMechanism);
                }
            }
        }
        void OnDestroy()
        {
            if (transform.parent == pressTransform.parent)
            {
                AkSoundEngine.PostEvent("Stop_hydraulicpressing", BadAssEmotesPlugin.pressMechanism);
                AkSoundEngine.PostEvent("Stop_Hydrolic", BadAssEmotesPlugin.pressMechanism);
                AkSoundEngine.PostEvent(BadAssEmotesPlugin.pressMechanism.GetComponent<HydrolicPressMechanism>().lowes ? "Play_LowesIdle" : "Play_HomeDepotIdle", BadAssEmotesPlugin.pressMechanism);
                pressTransform.localScale = new Vector3(0.8631962f, 0.8631962f, 0.8631962f);
            }
        }
        IEnumerator CrushAfterSeconds(float time)
        {
            yield return new WaitForSeconds(time);
            crushPlayer = true;
        }
    }
    internal class HydrolicPressMechanism : MonoBehaviour
    {
        public bool lowes = false;
        static Texture lowesTex = Assets.Load<Texture>($"assets/hydrolic/textures/lowes.jpg");
        static Texture homedepotTex = Assets.Load<Texture>($"assets/hydrolic/textures/Home-Depot-Logo.jpg");
        void Start()
        {
            BadAssEmotesPlugin.pressMechanism = this.gameObject;
            GetComponentInChildren<MeshRenderer>().sharedMaterials[0].mainTexture = lowes ? lowesTex : homedepotTex;
            GetComponentInChildren<MeshRenderer>().sharedMaterials[4].color = lowes ? new Color(9f / 255f, 52f / 255f, 93f / 255f) : new Color(193f / 255f, 79f / 255f, 0);
            AkSoundEngine.PostEvent(lowes ? "Play_LowesIdle" : "Play_HomeDepotIdle", this.gameObject);
        }
        void OnDestroy()
        {
            if (BadAssEmotesPlugin.pressMechanism == this.gameObject)
            {
                BadAssEmotesPlugin.pressMechanism = null;
            }
            AkSoundEngine.PostEvent("Stop_Hydrolic", this.gameObject);
            AkSoundEngine.PostEvent("Stop_hydraulicpressing", this.gameObject);

        }
    }
}
