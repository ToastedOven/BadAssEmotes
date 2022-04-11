using BepInEx;
using BepInEx.Configuration;
using EmotesAPI;
using R2API;
using R2API.Utils;
using RiskOfOptions;
using RiskOfOptions.Options;
using RoR2;
using UnityEngine;

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
        public const string PluginVersion = "1.0.0";
        public void Awake()
        {
            Assets.PopulateAssets();
            Assets.AddSoundBank("BadAssEmotes.bnk");
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
        }
        internal void AddAnimation(string AnimClip, string wwise, bool looping, bool dimAudio, bool sync)
        {
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip}.anim"), looping, $"Play_{wwise}", $"Stop_{wwise}", dimWhenClose: dimAudio, syncAnim: sync, syncAudio: sync);
        }
        internal void AddAnimation(string AnimClip, string wwise, string AnimClip2ElectricBoogaloo, bool dimAudio, bool sync)
        {
            CustomEmotesAPI.AddCustomAnimation(Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip}.anim"), false, $"Play_{wwise}", $"Stop_{wwise}", secondaryAnimation: Assets.Load<AnimationClip>($"@ExampleEmotePlugin_badassemotes:assets/badassemotes/{AnimClip2ElectricBoogaloo}.anim"), dimWhenClose: dimAudio, syncAnim: sync, syncAudio: sync);
        }
    }
}
