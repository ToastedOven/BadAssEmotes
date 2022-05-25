using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using R2API;
using System;
using System.IO;
using System.Linq;
using System.Reflection;
using Path = System.IO.Path;
namespace testMod
{

internal static class Assets
    {
        internal const string assetBundleName = "SmugDanceAssets";

        internal const string soundBankName = "Test";

        internal static AssetBundle mainAssetBundle = null;

        public static GameObject TrailSetup;
        public static GameObject TrailPrefab;

        public static Material particleMat;
        public static Material mat1;
        public static Material mat2;
        public static Shader VHS;
        public static Shader Dance;

        public static AnimationClip smugDance;

        public static ComputeShader computeShader;

        internal static void Init()
        {
            LoadAssetBundle();
            LoadSoundBank();
            PopulateAssets();
        }

        internal static void PopulateAssets()
        {
            if (!mainAssetBundle)
            {
                Log.LogError(TestModPlugin.PluginName + ": assetBundle not Found.");
                return;
            }

            TrailSetup = mainAssetBundle.LoadAsset<GameObject>("SetupTrail");
            TrailPrefab = mainAssetBundle.LoadAsset<GameObject>("TrailPrefab");
            particleMat = mainAssetBundle.LoadAsset<Material>("TrailMat");
            VHS = mainAssetBundle.LoadAsset<Shader>("VHSRewind");
            Dance = mainAssetBundle.LoadAsset<Shader>("DanceBackground");
            mat1 = mainAssetBundle.LoadAsset<Material>("matDanceBG");
            mat2 = mainAssetBundle.LoadAsset<Material>("matVHS");
            smugDance = mainAssetBundle.LoadAsset<AnimationClip>("SmugDance");
            computeShader = mainAssetBundle.LoadAsset<ComputeShader>("MassParticle");

        }

        internal static void LoadAssetBundle()
        {
            if (mainAssetBundle == null)
            {
                var path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
                mainAssetBundle = AssetBundle.LoadFromFile(Path.Combine(path, assetBundleName));

                if (!mainAssetBundle)
                {
                    Log.LogError(TestModPlugin.PluginName + ": assetBundle not Found.");

                    return;
                }
                
            }
                
        }

        internal static void LoadSoundBank()
        {
            if (soundBankName == "")
            {
                Log.LogInfo(TestModPlugin.PluginName + ": SoundBank name is blank.");
                return;
            }
            var path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            SoundAPI.SoundBanks.Add(Path.Combine(path, soundBankName + ".bnk"));
        }
    }
}
