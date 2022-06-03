using BepInEx;
using BepInEx.Configuration;
using EmotesAPI;
using Generics.Dynamics;
using R2API;
using R2API.Utils;
using RiskOfOptions;
using RiskOfOptions.Options;
using RoR2;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.Animations;
using UnityEngine.Networking;

namespace ExamplePlugin
{
    [BepInDependency("com.weliveinasociety.CustomEmotesAPI")]
    [BepInPlugin(PluginGUID, PluginName, PluginVersion)]
    [NetworkCompatibility(CompatibilityLevel.EveryoneMustHaveMod, VersionStrictness.EveryoneNeedSameModVersion)]
    [R2APISubmoduleDependency("SoundAPI", "PrefabAPI", "CommandHelper", "ResourcesAPI", "NetworkingAPI")]
    public class BadAssEmotesPlugin : BaseUnityPlugin
    {
        public const string PluginGUID = "com.weliveinasociety.badassemotes";
        public const string PluginAuthor = "Nunchuk";
        public const string PluginName = "BadAssEmotes";
        public const string PluginVersion = "1.5.1";
        int stageInt = -1;
        internal static GameObject stage;
        internal static LivingParticleArrayController LPAC;
        static List<string> HatKidDances = new List<string>();
        public void Awake()
        {
            Assets.PopulateAssets();
            Assets.AddSoundBank("Test.bnk");
            //Assets.AddSoundBank("nunchukemotes.bnk");
            Assets.AddSoundBank("Init.bnk");
            //Assets.AddSoundBank("Init2.bnk");
            Assets.AddSoundBank("BadAssEmotes.bnk");
            Assets.AddSoundBank("BadAssEmotes2.bnk");
            Assets.AddSoundBank("BadAssEmotes3.bnk");
            Assets.LoadSoundBanks();
            AddAnimation("Breakin", "Breakin_", false, true, true);
            AddAnimation("Breakneck", "Breakneck", true, true, true);
            AddAnimation("Crabby", "Crabby", true, true, true);
            AddAnimation("Dabstand", "Dabstand", false, false, false);
            AddAnimation("DanceMoves", "DanceMoves", false, true, false);
            AddAnimation("DanceTherapyIntro", "DanceTherapy", "DanceTherapyLoop", true, true);
            AddAnimation("DeepDab", "Dabstand", false, false, false);
            AddAnimation("Droop", "Droop", true, true, true);
            AddAnimation("ElectroSwing", "ElectroSwing", true, true, true);
            AddAnimation("Extraterrestial", "Extraterestrial", true, true, true);
            AddAnimation("FancyFeet", "FancyFeet", true, true, true);
            AddAnimation("FlamencoIntro", "Flamenco", "FlamencoLoop", true, true);
            AddAnimation("Floss", "Floss", true, true, false);
            AddAnimation("Fresh", "Fresh", true, true, true);
            AddAnimation("Hype", "Hype", true, true, true);
            AddAnimation("Infectious", "Infectious", true, true, true);
            AddAnimation("InfinidabIntro", "Infinidab", "InfinidabLoop", true, false);
            AddAnimation("IntensityIntro", "Intensity", "IntensityLoop", true, true);
            AddAnimation("NeverGonna", "Never_Gonna_Give_you_Up", true, true, true);
            AddAnimation("NinjaStyle", "NinjaStyle", true, true, true);
            AddAnimation("OldSchool", "OldSchool", true, true, true);
            AddAnimation("OrangeJustice", "OrangeJustice", true, true, true);
            AddAnimation("Overdrive", "Overdrive", true, true, true);
            AddAnimation("PawsAndClaws", "Paws_Claws", true, true, true);
            AddAnimation("PhoneItIn", "PhoneItIn", true, true, true);
            AddAnimation("PopLock", "PopLock", true, true, true);
            AddAnimation("Scenario", "Scenario", true, true, true);
            AddAnimation("SpringLoaded", "SpringLoaded", true, false, false);
            AddAnimation("Springy", "Springy", true, true, true);
            AddAnimation("SquatKickIntro", "SquatKick", "SquatKickLoop", true, true);


            //update 1
            AddAnimation("AnkhaZone", "AnkhaZone", true, true, true);
            AddAnimation("GangnamStyle", "GangnamStyle", true, true, true);
            AddAnimation("DontStart", "DontStart", true, true, true);
            AddAnimation("BunnyHop", "BunnyHop", true, true, true);
            AddAnimation("BestMates", "BestMates", true, true, true);
            AddAnimation("JackOPose", "", true, false, false);
            AddAnimation("Crackdown", "Crackdown", true, true, true);
            AddAnimation("Thicc", "Thicc", true, true, true);
            AddAnimation("TakeTheL", "TakeTheL", true, true, true);
            AddAnimation("ArkDance", "ArkDance", true, true, true);
            AddAnimation("LetsDanceBoys", "LetsDanceBoys", true, true, true);
            AddAnimation("BlindingLightsIntro", "BlindingLights", "BlindingLights", true, true);
            AddAnimation("ImDiamond", "ImDiamond", true, true, true);
            AddAnimation("ItsDynamite", "ItsDynamite", true, true, true);
            AddAnimation("TheRobot", "TheRobot", true, true, true);
            AddAnimation("Cartwheelin", "Cartwheelin", true, false, false);
            AddAnimation("CrazyFeet", "CrazyFeet", true, true, true);
            AddAnimation("FullTilt", "FullTilt", true, true, true);
            CustomEmotesAPI.BlackListEmote("FullTilt");
            AddAnimation("FloorSamus", "FloorSamus", true, false, false);
            AddAnimation("DEDEDE", "DEDEDE", true, false, false);
            AddAnimation("Specialist", "Specialist", false, true, true);



            //Update 2
            AddStartAndJoinAnim(new string[] { "PPmusic", "PPmusicFollow" }, "PPmusic", true, true, true);
            AddAnimation("GetDown", "GetDown", false, true, true);
            AddAnimation("Yakuza", "Yakuza", true, true, true);
            AddAnimation("Miku", "Miku", true, true, true);
            AddAnimation("Horny", new string[] { "Play_MEMEME", "Play_Horny" }, "Horny", true, true, true);
            AddAnimation("GangTorture", "GangTorture", false, true, true);
            AddAnimation("PoseBurter", "GinyuForce", true, true, true);
            AddAnimation("PoseGinyu", "GinyuForce", true, true, true);
            AddAnimation("PoseGuldo", "GinyuForce", true, true, true);
            AddAnimation("PoseJeice", "GinyuForce", true, true, true);
            AddAnimation("PoseRecoome", "GinyuForce", true, true, true);
            AddAnimation("StoodHere", new string[] { "Play_StandingHere2" }, "StandingHere2", true, true, false, new JoinSpot[] { new JoinSpot("StandingHereJoinSpot", new Vector3(0, 0, 2)) });
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/StandingHere.anim"), true, visible: false);
            AddAnimation("Carson", "Carson", false, true, true);
            AddAnimation("Frolic", "Frolic", true, true, true);
            AddAnimation("MoveIt", "MoveIt", true, true, true);
            AddStartAndJoinAnim(new string[] { "ByTheFireLead", "ByTheFirePartner" }, "ByTheFire", true, true, true);
            AddStartAndJoinAnim(new string[] { "SwayLead", "SwayPartner" }, "Sway", true, true, true);
            AddAnimation("Macarena", "Macarena", true, true, true);
            //AddAnimation("Renegade", "Renegade", true, true, true);
            AddAnimation("Thanos", "Thanos", true, true, true);
            AddAnimation("StarGet", "StarGet", false, false, false);
            AddAnimation("Poyo", "Poyo", true, true, true);
            AddAnimation("Hi", "Hi", false, false, false);
            AddAnimation("Chika", "Chika", false, true, true);
            AddAnimation("Goopie", "Goopie", false, true, true);
            AddAnimation("Sad", "Sad", false, true, true);
            AddAnimation("Crossbounce", "Crossbounce", true, true, true);
            AddAnimation("Butt", "Butt", false, false, false);



            //update 3
            AddAnimation("SuperIdol", "SuperIdol", true, true, true);
            AddAnimation("MakeItRainIntro", "MakeItRain", "MakeItRainLoop", true, true);
            AddAnimation("Penguin", "Penguin", true, true, true);
            AddAnimation("DesertRivers", "DesertRivers", false, true, true);
            AddAnimation("HondaStep", "HondaStep", false, true, true);
            AddAnimation("UGotThat", "UGotThat", false, true, true);




            //update 4
            AddAnimation("OfficerEarl", "", true, false, false);
            CustomEmotesAPI.BlackListEmote("OfficerEarl");
            AddAnimation("Cirno", "Cirno", false, true, true);
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/Haruhi.anim") }, false, new string[] { "Play_Haruhi", "Play_HaruhiYoung" }, new string[] { "Stop_Haruhi", "Stop_Haruhi" }, dimWhenClose: true, syncAnim: true, syncAudio: true, startPref: 0, joinPref: 0, joinSpots: new JoinSpot[] { new JoinSpot("Yuki_Nagato", new Vector3(3, 0, -3)), new JoinSpot("Mikuru_Asahina", new Vector3(-3, 0, -3)) });
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/Yuki_Nagato.anim") }, false, "", visible: false, syncAnim: true);
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/Mikuru_Asahina.anim") }, false, "", visible: false, syncAnim: true);
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/GGGG.anim"), Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/GGGG2.anim"), Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/GGGG3.anim") }, false, new string[] { "Play_GGGG" }, new string[] { "Stop_GGGG" }, dimWhenClose: true, syncAnim: true, syncAudio: true, startPref: -2, joinPref: -2);
            AddAnimation("Shufflin", "Shufflin", false, true, true);
            AddStartAndJoinAnim(new string[] { "Train", "TrainPassenger" }, "Train", new string[] { "Trainloop", "TrainPassenger" }, true, false, true);
            CustomEmotesAPI.BlackListEmote("Train");
            AddAnimation("BimBamBom", "BimBamBom", true, true, true);
            AddAnimation("Savage", "Savage", true, true, true);
            AddAnimation("Stuck", "Stuck", true, true, true);
            AddAnimation("Roflcopter", "Roflcopter", true, true, true);
            AddAnimation("Float", "Float", false, true, true);
            AddAnimation("Rollie", "Rollie", true, true, true);
            AddAnimation("GalaxyObservatory", new string[] { "Play_GalaxyObservatory1", "Play_GalaxyObservatory2", "Play_GalaxyObservatory3" }, "GalaxyObservatory", true, true, true);
            AddAnimation("Markiplier", "Markiplier", false, false, false);
            AddAnimation("DevilSpawn", "DevilSpawn", true, true, true);
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/DuckThisOneIdle.anim") }, true, new string[] { "Play_DuckThisOneIdle" }, new string[] { "Stop_DuckThisOne" }, joinSpots: new JoinSpot[] { new JoinSpot("DuckThisJoinSpot", new Vector3(0, 0, 2)) }, dimWhenClose: true);
            CustomEmotesAPI.BlackListEmote("DuckThisOneIdle");
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/DuckThisOne.anim") }, false, new string[] { "Play_DuckThisOne" }, new string[] { "Stop_DuckThisOne" }, visible: false, dimWhenClose: true);
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/DuckThisOneJoin.anim"), false, visible: false, dimWhenClose: true);
            //CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/DevilSpawn.anim") }, true, joinSpots: new JoinSpot[] { new JoinSpot(Vector3.zero) });
            AddAnimation("Griddy", "Griddy", true, true, true);
            AddAnimation("Tidy", "Tidy", true, true, true);
            AddAnimation("Toosie", "Toosie", true, true, true);
            AddAnimation("INEEDAMEDICBAG", "INEEDAMEDICBAG", true, false, false);
            AddAnimation("Smoke", "Smoke", true, true, true);
            AddAnimation("FamilyGuyDeath", "", true, false, false);
            AddAnimation("Panda", "", false, false, false);
            AddAnimation("Yamcha", "", true, false, false);


            //update 5
            AddAnimation("Thriller", "Thriller", true, true, true);
            AddAnimation("Wess", "Wess", false, true, true);
            AddAnimation("Distraction", "Distraction", true, true, true);
            AddAnimation("Security", "Security", true, true, true);
            //CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:Assets/animationreplacements/Cum Throne.anim"), false, "Play_Cum", "Stop_Cum", dimWhenClose: true, syncAnim: true, syncAudio: true);


            //update 6
            AddAnimation("KillMeBaby", "KillMeBaby", false, true, true);
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/MyWorld.anim") }, true, new string[] { "Play_MyWorld" }, new string[] { "Stop_MyWorld" }, dimWhenClose: true, syncAnim: true, syncAudio: true, joinSpots: new JoinSpot[] { new JoinSpot("MyWorldJoinSpot", new Vector3(2, 0, 0)) });
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/MyWorldJoin.anim") }, true, new string[] { "Play_MyWorld" }, new string[] { "Stop_MyWorld" }, dimWhenClose: true, syncAnim: true, syncAudio: true, visible: false);
            BoneMapper.animClips["MyWorldJoin"].syncPos--;
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/VSWORLD.anim") }, true, new string[] { "Play_VSWORLD" }, new string[] { "Stop_VSWORLD" }, dimWhenClose: true, syncAnim: true, syncAudio: true, joinSpots: new JoinSpot[] { new JoinSpot("VSWORLDJoinSpot", new Vector3(-2, 0, 0)) });
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/VSWORLDLEFT.anim") }, true, new string[] { "Play_VSWORLD" }, new string[] { "Stop_VSWORLD" }, dimWhenClose: true, syncAnim: true, syncAudio: true, visible: false);
            BoneMapper.animClips["VSWORLDLEFT"].syncPos--;
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/ChugJug.anim") }, false, new string[] { "Play_ChugJug", "Play_MikuJug" }, new string[] { "Stop_ChugJug", "Stop_ChugJug" }, dimWhenClose: true, syncAnim: true, syncAudio: true);
            CustomEmotesAPI.AddNonAnimatingEmote("IFU Stage");
            CustomEmotesAPI.BlackListEmote("IFU Stage");
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/ifu.anim") }, false, new string[] { "Play_ifu", "Play_ifucover" }, new string[] { "Stop_ifu", "Stop_ifu" }, dimWhenClose: true, syncAnim: true, syncAudio: true, visible: false);
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/ifeleft.anim") }, false, new string[] { "Play_ifu", "Play_ifucover" }, new string[] { "Stop_ifu", "Stop_ifu" }, dimWhenClose: true, syncAnim: true, syncAudio: true, visible: false);
            BoneMapper.animClips["ifeleft"].syncPos--;
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/ifuright.anim") }, false, new string[] { "Play_ifu", "Play_ifucover" }, new string[] { "Stop_ifu", "Stop_ifu" }, dimWhenClose: true, syncAnim: true, syncAudio: true, visible: false);
            BoneMapper.animClips["ifuright"].syncPos -= 2;
            GameObject g2 = Assets.Load<GameObject>($"assets/prefabs/ifustagebasebased.prefab");
            var g = g2.transform.Find("ifuStage").Find("GameObject").Find("LivingParticlesFloor11_Audio").gameObject;
            g2.AddComponent<StageHandler>();
            g2.transform.Find("ifuStage").Find("GameObject").Find("Plane").gameObject.AddComponent<SurfaceDefProvider>().surfaceDef = Addressables.LoadAssetAsync<SurfaceDef>("RoR2/Base/Common/sdMetal.asset").WaitForCompletion();
            g2.transform.Find("ifuStage").Find("GameObject").Find("stairs front").gameObject.AddComponent<SurfaceDefProvider>().surfaceDef = Addressables.LoadAssetAsync<SurfaceDef>("RoR2/Base/Common/sdMetal.asset").WaitForCompletion();
            g2.transform.Find("ifuStage").Find("GameObject").Find("stairs left").gameObject.AddComponent<SurfaceDefProvider>().surfaceDef = Addressables.LoadAssetAsync<SurfaceDef>("RoR2/Base/Common/sdMetal.asset").WaitForCompletion();
            g2.transform.Find("ifuStage").Find("GameObject").Find("stairs right").gameObject.AddComponent<SurfaceDefProvider>().surfaceDef = Addressables.LoadAssetAsync<SurfaceDef>("RoR2/Base/Common/sdMetal.asset").WaitForCompletion();
            g2.transform.Find("ifuStage").Find("GameObject").Find("stairs back").gameObject.AddComponent<SurfaceDefProvider>().surfaceDef = Addressables.LoadAssetAsync<SurfaceDef>("RoR2/Base/Common/sdMetal.asset").WaitForCompletion();
            LivingParticlesAudioModule module = g.GetComponent<LivingParticlesAudioModule>();
            module.audioPosition = g.transform;
            g.GetComponent<ParticleSystemRenderer>().material.SetFloat("_DistancePower", .5f);
            g.GetComponent<ParticleSystemRenderer>().material.SetFloat("_NoisePower", 8f);
            g.GetComponent<ParticleSystemRenderer>().material.SetFloat("_AudioAmplitudeOffsetPower2", 1.5f);
            stageInt = CustomEmotesAPI.RegisterWorldProp(g2, new JoinSpot[] { new JoinSpot("ifumiddle", new Vector3(0, .4f, 0)), new JoinSpot("ifeleft", new Vector3(-2, .4f, 0)), new JoinSpot("ifuright", new Vector3(2, .4f, 0)) });


            AddAnimation("SingleFurry", "SingleFurry", true, true, true);
            AddAnimation("Summertime", "Summertime", false, true, true);
            AddAnimation("Dougie", "Dougie", true, true, true);
            CustomEmotesAPI.AddNonAnimatingEmote("Peace And Tranquility");
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:Assets/ThunderAnimation/PeaceAndTranquility.anim"), true, $"Play_PeaceAndTranquility", $"Stop_PeaceAndTranquility", dimWhenClose: true, syncAnim: true, syncAudio: true, visible: false);

            CustomEmotesAPI.animChanged += CustomEmotesAPI_animChanged;
            CustomEmotesAPI.emoteSpotJoined_Body += CustomEmotesAPI_emoteSpotJoined_Body;
            CustomEmotesAPI.emoteSpotJoined_Prop += CustomEmotesAPI_emoteSpotJoined_Prop;
        }

        private void CustomEmotesAPI_emoteSpotJoined_Prop(GameObject emoteSpot, BoneMapper joiner, BoneMapper host)
        {
            string emoteSpotName = emoteSpot.name;
            if (emoteSpotName == "ifumiddle")
            {
                host.GetComponentsInChildren<Animator>()[1].SetTrigger("Start");
                joiner.PlayAnim("ifu", 0);
                GameObject g = new GameObject();
                g.name = "ifumiddle_JoinProp";
                IFU(joiner, host, emoteSpot, g);
            }
            else if (emoteSpotName == "ifeleft")
            {
                host.GetComponentsInChildren<Animator>()[1].SetTrigger("Start");

                joiner.PlayAnim("ifeleft", 0);

                GameObject g = new GameObject();
                g.name = "ifeleft_JoinProp";
                IFU(joiner, host, emoteSpot, g);
            }
            else if (emoteSpotName == "ifuright")
            {
                host.GetComponentsInChildren<Animator>()[1].SetTrigger("Start");

                joiner.PlayAnim("ifuright", 0);

                GameObject g = new GameObject();
                g.name = "ifuright_JoinProp";
                IFU(joiner, host, emoteSpot, g);
            }
        }
        private void IFU(BoneMapper joiner, BoneMapper host, GameObject emoteSpot, GameObject g)
        {
            joiner.props.Add(g);
            g.transform.SetParent(host.transform);
            g.transform.localPosition = new Vector3(0, .5f, 0);
            g.transform.localEulerAngles = Vector3.zero;
            g.transform.localScale = host.transform.localScale;
            joiner.AssignParentGameObject(g, true, true, true, true, true);
            emoteSpot.GetComponent<EmoteLocation>().SetEmoterAndHideLocation(joiner);
            if (joiner.local)
            {
                localBody = NetworkUser.readOnlyLocalPlayersList[0].master?.GetBody();
                CharacterCameraParamsData data = new CharacterCameraParamsData();
                data.fov = 70f;
                data.idealLocalCameraPos = new Vector3(0, 1.5f, -16);
                if (!fovHandle.isValid)
                {
                    fovHandle = localBody.GetComponentInChildren<EntityStateMachine>().commonComponents.cameraTargetParams.AddParamsOverride(new CameraTargetParams.CameraParamsOverrideRequest
                    {
                        cameraParamsData = data
                    }, 1f);
                }
            }
        }
        private void CustomEmotesAPI_emoteSpotJoined_Body(GameObject emoteSpot, BoneMapper joiner, BoneMapper host)
        {
            string emoteSpotName = emoteSpot.name;
            if (emoteSpotName == "StandingHereJoinSpot")
            {
                joiner.PlayAnim("StandingHere", 0);
                GameObject g = new GameObject();
                g.name = "StandingHereProp";
                joiner.props.Add(g);
                g.transform.SetParent(host.transform);
                Vector3 scal = host.transform.lossyScale;
                g.transform.localPosition = new Vector3(0, 0, .75f / scal.z);
                g.transform.localEulerAngles = new Vector3(0, 130, 0);
                g.transform.localScale = new Vector3(.8f, .8f, .8f);
                joiner.AssignParentGameObject(g, true, true, true, true, true);
                joiner.SetAnimationSpeed(2);
                emoteSpot.GetComponent<EmoteLocation>().SetEmoterAndHideLocation(joiner);
            }

            if (emoteSpotName == "DuckThisJoinSpot")
            {
                joiner.PlayAnim("DuckThisOneJoin", 0);

                GameObject g = new GameObject();
                g.name = "DuckThisOneJoinProp";
                joiner.props.Add(g);
                g.transform.SetParent(host.transform);
                Vector3 scal = host.transform.lossyScale;
                g.transform.localPosition = new Vector3(0, 0, 1 / scal.z);
                g.transform.localEulerAngles = new Vector3(0, 180, 0);
                g.transform.localScale = Vector3.one;
                joiner.AssignParentGameObject(g, true, true, true, true, true);


                host.PlayAnim("DuckThisOne", 0);

                g = new GameObject();
                g.name = "DuckThisOneHostProp";
                host.props.Add(g);
                g.transform.localPosition = host.transform.position;
                g.transform.localEulerAngles = host.transform.eulerAngles;
                g.transform.localScale = Vector3.one;
                host.AssignParentGameObject(g, true, true, true, true, false);
            }

            if (emoteSpotName == "Yuki_Nagato")
            {
                joiner.PlayAnim("Yuki_Nagato", 0);
                CustomAnimationClip.syncTimer[joiner.currentClip.syncPos] = CustomAnimationClip.syncTimer[host.currentClip.syncPos];
                CustomAnimationClip.syncPlayerCount[joiner.currentClip.syncPos]++;
                joiner.PlayAnim("Yuki_Nagato", 0);
                CustomAnimationClip.syncPlayerCount[joiner.currentClip.syncPos]--;

                GameObject g = new GameObject();
                g.name = "Yuki_NagatoProp";
                joiner.props.Add(g);
                g.transform.SetParent(host.transform);
                Vector3 scal = host.transform.lossyScale;
                g.transform.localPosition = new Vector3(0, 0, 0);
                g.transform.localEulerAngles = Vector3.zero;
                g.transform.localScale = Vector3.one;
                joiner.AssignParentGameObject(g, true, true, true, true, true);
                emoteSpot.GetComponent<EmoteLocation>().SetEmoterAndHideLocation(joiner);
            }
            if (emoteSpotName == "Mikuru_Asahina")
            {
                joiner.PlayAnim("Mikuru_Asahina", 0);
                CustomAnimationClip.syncTimer[joiner.currentClip.syncPos] = CustomAnimationClip.syncTimer[host.currentClip.syncPos];
                CustomAnimationClip.syncPlayerCount[joiner.currentClip.syncPos]++;
                joiner.PlayAnim("Mikuru_Asahina", 0);
                CustomAnimationClip.syncPlayerCount[joiner.currentClip.syncPos]--;

                GameObject g = new GameObject();
                g.name = "Mikuru_AsahinaProp";
                joiner.props.Add(g);
                g.transform.SetParent(host.transform);
                Vector3 scal = host.transform.lossyScale;
                g.transform.localPosition = new Vector3(0, 0, 0);
                g.transform.localEulerAngles = Vector3.zero;
                g.transform.localScale = Vector3.one;
                joiner.AssignParentGameObject(g, true, true, true, true, true);
                emoteSpot.GetComponent<EmoteLocation>().SetEmoterAndHideLocation(joiner);
            }
            if (emoteSpotName == "MyWorldJoinSpot")
            {
                joiner.PlayAnim("MyWorldJoin", 0);

                GameObject g = new GameObject();
                g.name = "MyWorldJoinProp";
                joiner.props.Add(g);
                g.transform.SetParent(host.transform);
                g.transform.localPosition = new Vector3(0, 0, 0);
                g.transform.localEulerAngles = Vector3.zero;
                g.transform.localScale = Vector3.one;
                joiner.AssignParentGameObject(g, true, true, true, true, true);
                emoteSpot.GetComponent<EmoteLocation>().SetEmoterAndHideLocation(joiner);
            }
            if (emoteSpotName == "VSWORLDJoinSpot")
            {
                joiner.PlayAnim("VSWORLDLEFT", 0);

                GameObject g = new GameObject();
                g.name = "VSWORLDLEFTJoinProp";
                joiner.props.Add(g);
                Vector3 scale = host.transform.parent.localScale;
                host.transform.parent.localScale = Vector3.one;
                g.transform.SetParent(host.transform.parent);
                g.transform.localPosition = new Vector3(-2, 0, 0);
                g.transform.localEulerAngles = Vector3.zero;
                g.transform.localScale = Vector3.one;
                g.transform.SetParent(null);
                host.transform.parent.localScale = scale;
                g.transform.SetParent(host.transform.parent);

                joiner.AssignParentGameObject(g, true, true, true, true, true);
                emoteSpot.GetComponent<EmoteLocation>().SetEmoterAndHideLocation(joiner);
            }
        }

        int stand = -1;
        List<BoneMapper> punchingMappers = new List<BoneMapper>();
        int prop1 = -1;
        CameraTargetParams.CameraParamsOverrideHandle fovHandle;
        internal CharacterBody localBody = null;
        private void CustomEmotesAPI_animChanged(string newAnimation, BoneMapper mapper)
        {
            prop1 = -1;
            try
            {
                if (newAnimation != "none")
                {
                    stand = mapper.currentClip.syncPos;
                }
            }
            catch (System.Exception)
            {
            }
            if (punchingMappers.Contains(mapper))
            {
                punchingMappers.Remove(mapper);
            }
            if (punchingMappers.Count == 0)
            {
                AkSoundEngine.SetRTPCValue("MetalGear_Vocals", 0);
            }
            if (newAnimation == "StandingHere")
            {
                punchingMappers.Add(mapper);
                AkSoundEngine.SetRTPCValue("MetalGear_Vocals", 1);
            }
            if (newAnimation == "StoodHere")
            {
                GameObject g = new GameObject();
                g.name = "StoodHereProp";
                mapper.props.Add(g);
                g.transform.localPosition = mapper.transform.position;
                g.transform.localEulerAngles = mapper.transform.eulerAngles;
                g.transform.localScale = Vector3.one;
                mapper.AssignParentGameObject(g, false, false, true, true, false);
            }
            if (newAnimation == "Chika")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/models/desker.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();

                if (mapper.local)
                {
                    localBody = NetworkUser.readOnlyLocalPlayersList[0].master?.GetBody();
                    CharacterCameraParamsData data = new CharacterCameraParamsData();
                    data.fov = 70f;
                    data.idealLocalCameraPos = new Vector3(0, 1.5f, -23);
                    if (!fovHandle.isValid)
                    {
                        fovHandle = localBody.GetComponentInChildren<EntityStateMachine>().commonComponents.cameraTargetParams.AddParamsOverride(new CameraTargetParams.CameraParamsOverrideRequest
                        {
                            cameraParamsData = data
                        }, 1f);
                    }
                }
            }
            else
            {
                if (mapper.local && fovHandle.isValid)
                {
                    localBody = NetworkUser.readOnlyLocalPlayersList[0].master?.GetBody();
                    localBody.GetComponentInChildren<EntityStateMachine>().commonComponents.cameraTargetParams.RemoveParamsOverride(fovHandle, 1f);
                    fovHandle = default(CameraTargetParams.CameraParamsOverrideHandle);
                }
            }
            if (newAnimation == "MakeItRainIntro")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/money.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "DesertRivers" || newAnimation == "Cirno" || newAnimation == "Haruhi" || newAnimation == "GGGG")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/desertlight.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
            }
            if (newAnimation == "HondaStep")
            {
                prop1 = mapper.props.Count;
                GameObject myNutz = GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/hondastuff.prefab"));
                foreach (var item in myNutz.GetComponentsInChildren<ParticleSystem>())
                {
                    item.time = CustomAnimationClip.syncTimer[mapper.currentClip.syncPos];
                }
                Animator a = myNutz.GetComponentInChildren<Animator>();
                //a.Play("MusicSync", -1);
                a.Play("MusicSync", 0, (CustomAnimationClip.syncTimer[mapper.currentClip.syncPos] % a.GetCurrentAnimatorClipInfo(0)[0].clip.length) / a.GetCurrentAnimatorClipInfo(0)[0].clip.length);
                myNutz.transform.SetParent(mapper.transform.parent);
                myNutz.transform.localEulerAngles = Vector3.zero;
                myNutz.transform.localPosition = Vector3.zero;
                mapper.props.Add(myNutz);
                //mapper.ScaleProps();
            }
            if (stand != -1 && newAnimation == "Train")
            {
                prop1 = mapper.props.Count;
                if (CustomAnimationClip.syncPlayerCount[stand] == 1)
                {
                    mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/train.prefab")));
                }
                else
                {
                    mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/passenger.prefab")));
                }
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.SetAutoWalk(1, true);
                mapper.ScaleProps();
            }
            if (newAnimation == "BimBamBom")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/BimBamBom.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "PeaceAndTranquility")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:Assets/test/assets/prefabs/SetupTrail.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.smr1.rootBone);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "Summertime")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:Assets/Prefabs/Summermogus.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.smr1.rootBone);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "Float")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/FloatLight.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "Markiplier")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/Amogus.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "OfficerEarl")
            {
                mapper.SetAutoWalk(1, false);
            }
            if (newAnimation == "DuckThisOneIdle")
            {
                GameObject g = new GameObject();
                g.name = "DuckThisOneIdleProp";
                mapper.props.Add(g);
                g.transform.localPosition = mapper.transform.position;
                g.transform.localEulerAngles = mapper.transform.eulerAngles;
                g.transform.localScale = Vector3.one;
                mapper.AssignParentGameObject(g, true, true, true, true, false);
            }
            if (newAnimation == "FullTilt")
            {
                mapper.SetAutoWalk(1, false);
            }
            if (newAnimation == "Smoke")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/Prefabs/BluntAnimator.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.transform.parent);
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.props[prop1].GetComponentInChildren<ParticleSystem>().gravityModifier *= mapper.scale;
                var velocity = mapper.props[prop1].GetComponentInChildren<ParticleSystem>().limitVelocityOverLifetime;
                velocity.dampen *= mapper.scale;
                velocity.limitMultiplier = mapper.scale;
                mapper.ScaleProps();
            }
            if (newAnimation == "Haruhi")
            {
                GameObject g = new GameObject();
                g.name = "HaruhiProp";
                mapper.props.Add(g);
                g.transform.localPosition = mapper.transform.position;
                g.transform.localEulerAngles = mapper.transform.eulerAngles;
                g.transform.localScale = Vector3.one;
                mapper.AssignParentGameObject(g, false, false, true, true, false);
            }
            if (newAnimation == "Thriller")
            {
                if (mapper.local)
                {
                    localBody = NetworkUser.readOnlyLocalPlayersList[0].master?.GetBody();
                    CharacterCameraParamsData data = new CharacterCameraParamsData();
                    data.fov = 70f;
                    data.idealLocalCameraPos = new Vector3(0, 1.5f, -23);
                    if (!fovHandle.isValid)
                    {
                        fovHandle = localBody.GetComponentInChildren<EntityStateMachine>().commonComponents.cameraTargetParams.AddParamsOverride(new CameraTargetParams.CameraParamsOverrideRequest
                        {
                            cameraParamsData = data
                        }, 1f);
                    }
                }
            }
            if (newAnimation == "Security")
            {
                prop1 = mapper.props.Count;
                mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/prefabs/neversee.prefab")));
                mapper.props[prop1].transform.SetParent(mapper.gameObject.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Spine));
                mapper.props[prop1].transform.localEulerAngles = Vector3.zero;
                mapper.props[prop1].transform.localPosition = Vector3.zero;
                mapper.ScaleProps();
            }
            if (newAnimation == "IFU Stage")
            {
                if (NetworkServer.active)
                {
                    if (stage)
                    {
                        NetworkServer.Destroy(stage);
                    }
                    stage = CustomEmotesAPI.SpawnWorldProp(stageInt);
                    stage.transform.SetParent(mapper.transform.parent);
                    stage.transform.localPosition = new Vector3(0, 0, 0);
                    stage.transform.SetParent(null);
                    stage.transform.localPosition += new Vector3(0, .5f, 0);
                    NetworkServer.Spawn(stage);
                }
            }
            //if (newAnimation == "Sad")
            //{
            //    prop1 = mapper.props.Count;
            //    mapper.props.Add(GameObject.Instantiate(Assets.Load<GameObject>("@BadAssEmotes_badassemotes:assets/models/trombone.prefab")));
            //    mapper.props[prop1].transform.SetParent(mapper.a2.GetBoneTransform(HumanBodyBones.RightHand));
            //    mapper.props[prop1].transform.localEulerAngles = new Vector3(0, 270, 0);
            //    mapper.props[prop1].transform.localPosition = Vector3.zero;
            //    mapper.props[prop1].transform.localScale = Vector3.one;
            //}
        }
        internal void AddAnimation(string AnimClip, string wwise, bool looping, bool dimAudio, bool sync)
        {
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip}.anim"), looping, $"Play_{wwise}", $"Stop_{wwise}", dimWhenClose: dimAudio, syncAnim: sync, syncAudio: sync);
        }
        internal void AddAnimation(string AnimClip, string[] wwise, string stopWwise, bool looping, bool dimAudio, bool sync)
        {
            List<string> stopwwise = new List<string>();
            foreach (var item in wwise)
            {
                stopwwise.Add($"Stop_{stopWwise}");
            }
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip}.anim") }, looping, wwise, stopwwise.ToArray(), dimWhenClose: dimAudio, syncAnim: sync, syncAudio: sync);
        }
        internal void AddAnimation(string AnimClip, string[] wwise, string stopWwise, bool looping, bool dimAudio, bool sync, JoinSpot[] joinSpots)
        {
            List<string> stopwwise = new List<string>();
            foreach (var item in wwise)
            {
                stopwwise.Add($"Stop_{stopWwise}");
            }
            CustomEmotesAPI.AddCustomAnimation(new AnimationClip[] { Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip}.anim") }, looping, wwise, stopwwise.ToArray(), dimWhenClose: dimAudio, syncAnim: sync, syncAudio: sync, joinSpots: joinSpots);
        }
        internal void AddAnimation(string AnimClip, string wwise, string AnimClip2ElectricBoogaloo, bool dimAudio, bool sync)
        {
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip}.anim"), false, $"Play_{wwise}", $"Stop_{wwise}", secondaryAnimation: Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip2ElectricBoogaloo}.anim"), dimWhenClose: dimAudio, syncAnim: sync, syncAudio: sync);
        }
        internal void AddStartAndJoinAnim(string[] AnimClip, string wwise, bool looping, bool dimaudio, bool sync)
        {
            List<AnimationClip> nuts = new List<AnimationClip>();
            foreach (var item in AnimClip)
            {
                nuts.Add(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{item}.anim"));
            }
            CustomEmotesAPI.AddCustomAnimation(nuts.ToArray(), looping, $"Play_{wwise}", $"Stop_{wwise}", dimWhenClose: dimaudio, syncAnim: sync, syncAudio: sync, startPref: 0, joinPref: 1);
        }
        internal void AddStartAndJoinAnim(string[] AnimClip, string wwise, string[] AnimClip2ElectricBoogaloo, bool looping, bool dimaudio, bool sync)
        {
            List<AnimationClip> nuts = new List<AnimationClip>();
            foreach (var item in AnimClip)
            {
                nuts.Add(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{item}.anim"));
            }
            List<AnimationClip> nuts2 = new List<AnimationClip>();
            foreach (var item in AnimClip2ElectricBoogaloo)
            {
                nuts2.Add(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{item}.anim"));
            }
            CustomEmotesAPI.AddCustomAnimation(nuts.ToArray(), looping, $"Play_{wwise}", $"Stop_{wwise}", dimWhenClose: dimaudio, syncAnim: sync, syncAudio: sync, startPref: 0, joinPref: 1, secondaryAnimation: nuts2.ToArray());
        }
    }


}
