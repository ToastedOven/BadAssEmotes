using BepInEx.Configuration;
using EmotesAPI;
using ExamplePlugin;
using RiskOfOptions.Options;
using RiskOfOptions;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace ExamplePlugin
{
    public static class Settings
    {
        public static ConfigEntry<float> EnemyTauntOnDeathChance;
        internal static void Setup()
        {
            ModSettingsManager.SetModIcon(Assets.Load<Sprite>("@BadAssEmotes_badassemotes:assets/hydrolic/icon.png"));
            ModSettingsManager.SetModDescription("Don't ask me how I know");
            EnemyTauntOnDeathChance = BadAssEmotesPlugin.instance.Config.Bind<float>("Yes", "Enemies taunt on loss chance", 100, "Bottom Text");
            ModSettingsManager.AddOption(new SliderOption(EnemyTauntOnDeathChance));

        }
    }
}
