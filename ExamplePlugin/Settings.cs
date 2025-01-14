﻿using BepInEx.Configuration;
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
        public static ConfigEntry<string> EnemyEmotes;
        public static ConfigEntry<float> RainbowSpeed;
        internal static void Setup()
        {
            ModSettingsManager.SetModIcon(Assets.Load<Sprite>("@BadAssEmotes_badassemotes:assets/hydrolic/icon.png"));
            ModSettingsManager.SetModDescription("Don't ask me how I know");
            EnemyTauntOnDeathChance = BadAssEmotesPlugin.instance.Config.Bind<float>("Yes", "Enemies taunt on loss chance", 100, "Bottom Text");
            ModSettingsManager.AddOption(new SliderOption(EnemyTauntOnDeathChance));
            EnemyEmotes = BadAssEmotesPlugin.instance.Config.Bind<string>("Yes",
                             "Enemy Emotes",
                             "Extraterrestial,Droop,SeeTinh,PopLock,DanceMoves,ImDiamond,Frolic,SwayLead,BestMates,Crackdown,Distraction,GangnamStyle,FlamencoIntro,Popular Vibe,VSWORLD,PPmusic,SquatKickIntro,Breakneck,Dougie,MyWorld,BimBamBom,GetDown,ArkDance,Macarena,ElectroSwing,Horny,Fresh,Goopie,TakeTheL,Infectious,Rollie,NeverGonna,CaliforniaGirls",
                             "Emotes that enemies play on players death");
            RainbowSpeed = BadAssEmotesPlugin.instance.Config.Bind<float>("Yes", "RainbowSpeed", 1, "Bottom Text");
            ModSettingsManager.AddOption(new StringInputFieldOption(EnemyEmotes));
            ModSettingsManager.AddOption(new FloatFieldOption(RainbowSpeed));
        }
    }
}
