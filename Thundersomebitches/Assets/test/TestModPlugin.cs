using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using BepInEx;
using R2API;
using R2API.Utils;
using EmotesAPI;
namespace testMod
{

    [BepInDependency(R2API.R2API.PluginGUID)]

    [BepInPlugin(PluginGUID,PluginName,PluginVersion)]

    [R2APISubmoduleDependency(nameof(SoundAPI))]
    public class TestModPlugin : BaseUnityPlugin
    {
        // Start is called before the first frame update
        public const string PluginGUID = PluginAuthor + "." + PluginName;
        public const string PluginAuthor = "dgosling";
        public const string PluginName = "TestMod";
        public const string PluginVersion = "1.0.0";

        public void Awake()
        {
            Log.Init(Logger);
            Assets.Init();
            TC.Internal.TCParticleGlobalManager.Init();
            CustomEmotesAPI.AddCustomAnimation(Assets.smugDance, true, "PlayPeace", "StopPeace", stopWhenMove: true, stopWhenAttack: true, syncAnim: true, syncAudio: true);


            CustomEmotesAPI.animChanged += CustomEmotesAPI_animChanged;
        }
        int prop1;
        private void CustomEmotesAPI_animChanged(string newAnimation, BoneMapper mapper)
        {
            if(newAnimation == "SmugDance")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.TrailSetup));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
            }
        }
    }
}
