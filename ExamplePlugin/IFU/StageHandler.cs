using EmotesAPI;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.Animations;

namespace ExamplePlugin
{
    internal class StageHandler : MonoBehaviour
    {
        GameObject[] emoteSpots = new GameObject[3];
        bool started = false;
        bool shouldRun = false;
        bool twopart = false;
        void Start()
        {
            BadAssEmotesPlugin.stage = this.gameObject;
            BadAssEmotesPlugin.LPAC = BadAssEmotesPlugin.stage.transform.Find("ifuStage").Find("GameObject").Find("LivingParticlesFloor11_Audio").gameObject.GetComponent<LivingParticleArrayController>();
            List<Transform> YEAHFEET = new List<Transform>();
            foreach (var item in CustomEmotesAPI.GetAllBoneMappers())
            {
                foreach (var bone in item.smr2.bones)
                {
                    if (bone.GetComponent<ParentConstraint>() && (bone.GetComponent<ParentConstraint>().GetSource(0).sourceTransform == item.a2.GetBoneTransform(HumanBodyBones.LeftFoot) || bone.GetComponent<ParentConstraint>().GetSource(0).sourceTransform == item.a2.GetBoneTransform(HumanBodyBones.RightFoot)))
                    {
                        YEAHFEET.Add(bone);
                    }
                }
            }
            BadAssEmotesPlugin.LPAC.affectors = YEAHFEET.ToArray();
        }
        void Update()
        {
            if (!started)
            {
                if (BadAssEmotesPlugin.stage.GetComponentInChildren<BoneMapper>().emoteLocations.Count != 0)
                {
                    for (int i = 0; i < BadAssEmotesPlugin.stage.GetComponentInChildren<BoneMapper>().emoteLocations.Count; i++)
                    {
                        emoteSpots[i] = BadAssEmotesPlugin.stage.GetComponentInChildren<BoneMapper>().emoteLocations[i].gameObject;
                    }
                    started = true;
                }
            }
            else
            {
                shouldRun = emoteSpots[0].transform.position.x < -2000 || emoteSpots[1].transform.position.x < -2000 || emoteSpots[2].transform.position.x < -2000;
            }
            if (!shouldRun)
            {
                if (twopart)
                {
                    twopart = false;
                    GetComponentsInChildren<Animator>()[1].ResetTrigger("Start");
                    GetComponentsInChildren<Animator>()[1].Play("idlestage");
                }
            }
            else
            {
                twopart = true;
            }
        }
    }
}
