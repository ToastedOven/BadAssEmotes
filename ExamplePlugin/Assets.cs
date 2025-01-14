﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;
using UnityEngine;
using UnityEngine.AddressableAssets;
using static R2API.SoundAPI;

namespace ExamplePlugin
{
    public static class Assets
    {
        private static readonly string[] KnownExtensions = { "png", "exe", "txt", "xcf", "bat" };
        internal static readonly List<AssetBundle> AssetBundles = new List<AssetBundle>();
        private static readonly Dictionary<string, int> AssetIndices = new Dictionary<string, int>();
        private static readonly List<string> SoundBanksToLoad = new List<string>();
        private static readonly List<string> FoundSoundBanks = new List<string>();
        private static readonly Dictionary<string, string> DisplayRuleSetOverrides = new Dictionary<string, string>();

        private static Material _prefab;

        public static Material LoadMaterial(string texture)
        {
            Material newMat = UnityEngine.Object.Instantiate(Load<Material>("general/basehgstandard.mat"));

            newMat.SetTexture("_MainTex", Load<Texture>(texture));
            newMat.name = texture;

            return newMat;
        }

        public static Material RobloxMaterial(string texture)
        {
            if (!_prefab)
                _prefab = UnityEngine.Object.Instantiate<Material>(Addressables.LoadAssetAsync<GameObject>("RoR2/Base/Golem/GolemBody.prefab").WaitForCompletion().GetComponentInChildren<SkinnedMeshRenderer>().material);

            Material newMat = UnityEngine.Object.Instantiate<Material>(_prefab);

            newMat.mainTexture = Load<Texture>(texture);

            newMat.SetColor("_Color", Color.white);
            newMat.SetFloat("_EmPower", 0f);
            newMat.SetColor("_EmColor", Color.white);
            newMat.SetTexture("_EmTex", null);
            newMat.SetTexture("_FresnelRamp", null);
            newMat.SetFloat("_NormalStrength", 0.5f);
            newMat.SetTexture("_NormalTex", null);

            newMat.name = texture;

            return newMat;
        }

        public static Material CopyMaterial(Texture texture)
        {
            if (!_prefab)
                _prefab = UnityEngine.Object.Instantiate<Material>(Addressables.LoadAssetAsync<GameObject>("RoR2/Base/Commando/CommandoBody.prefab").WaitForCompletion().GetComponentInChildren<SkinnedMeshRenderer>().material);

            Material newMat = UnityEngine.Object.Instantiate<Material>(_prefab);

            newMat.mainTexture = texture;

            newMat.SetColor("_Color", Color.white);
            newMat.SetFloat("_EmPower", 0f);
            newMat.SetColor("_EmColor", Color.white);
            newMat.SetTexture("_EmTex", null);
            newMat.SetFloat("_NormalStrength", 0.5f);
            newMat.SetTexture("_NormalTex", null);

            return newMat;
        }

        internal static void PopulateAssets()
        {
            string[] resourceNames = Assembly.GetExecutingAssembly().GetManifestResourceNames();

            foreach (var resource in resourceNames)
            {
                ResourceType resourceType = GetResourceType(resource);

                switch (resourceType)
                {
                    case ResourceType.AssetBundle:
                        // DebugClass.Log($"Loading AssetBundle {resource}");
                        LoadAssetBundle(resource);
                        break;
                    case ResourceType.SoundBank:
                        FoundSoundBanks.Add(resource);
                        break;
                    case ResourceType.DisplayRuleSetOverride:
                        DisplayRuleSetOverrides.Add(GetFileName(resource).Split('.')[0], resource);
                        break;
                    case ResourceType.Other:
                        // DebugClass.Log($"Loading Other {resource}");
                        // The majority of this stuff is manually loaded as needed.
                        break;
                }
            }
        }

        internal static void LoadSoundBanks()
        {
            foreach (var soundBank in FoundSoundBanks)
            {

                int index = SoundBanksToLoad.IndexOf(GetFileName(soundBank));
                if (index < 0)
                {
                    //DebugClass.Log($"Not loading [{soundBank}] because rune is fat");
                    continue;
                }

                LoadSoundBank(soundBank);
                SoundBanksToLoad.RemoveAt(index);
            }
        }

        private static string GetFileName(string resource)
        {
            string[] split = resource.Split('.');

            return split[split.Length - 2] + "." + split[split.Length - 1];
        }

        internal static void AddSoundBank(string name)
        {
            SoundBanksToLoad.Add($"{name}");
        }

        private static ResourceType GetResourceType(string resourceName)
        {
            string[] split = resourceName.Split('.');

            if (split.Length <= 0)
                throw new Exception($"Invalid asset found: {resourceName}");

            string lastItem = split[split.Length - 1];

            if (lastItem == "bnk")
                return ResourceType.SoundBank;

            if (lastItem == "drso")
                return ResourceType.DisplayRuleSetOverride;

            if (Array.IndexOf(KnownExtensions, lastItem) >= 0)
                return ResourceType.Other;

            return ResourceType.AssetBundle;
        }

        private enum ResourceType
        {
            AssetBundle,
            SoundBank,
            DisplayRuleSetOverride,
            Other
        }

        public static void LoadAssetBundlesFromFolder(string folderName)
        {
            folderName = Path.Combine(Path.GetDirectoryName(BadAssEmotesPlugin.PInfo.Location), folderName);
            foreach (var file in Directory.GetFiles(folderName))
            {
                AssetBundle assetBundle = AssetBundle.LoadFromFile(file);

                int index = AssetBundles.Count;
                AssetBundles.Add(assetBundle);

                foreach (var assetName in assetBundle.GetAllAssetNames())
                {
                    string path = assetName.ToLowerInvariant();
                    if (path.StartsWith("assets/"))
                        path = path.Remove(0, "assets/".Length);

                    //DebugClass.Log($"paring [{path}] with [{index}]");
                    AssetIndices[path] = index;
                }

                DebugClass.Log($"Loaded AssetBundle: {Path.GetFileName(file)}");
            }
        }
        private static void LoadAssetBundle(string location)
        {
            using var assetBundleStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(location);
            AssetBundle assetBundle = AssetBundle.LoadFromStream(assetBundleStream);

            int index = AssetBundles.Count;
            AssetBundles.Add(assetBundle);

            foreach (var assetName in assetBundle.GetAllAssetNames())
            {
                string path = assetName.ToLowerInvariant();
                if (path.StartsWith("assets/"))
                    path = path.Remove(0, "assets/".Length);

                //DebugClass.Log($"paring [{path}] with [{index}]");
                AssetIndices[path] = index;
            }

            DebugClass.Log($"Loaded AssetBundle: {location}");
        }

        public static void LoadAllSoundBanksFromFolder(string folderName)
        {
            folderName = Path.Combine(Path.GetDirectoryName(BadAssEmotesPlugin.PInfo.Location), folderName);

            foreach (var file in Directory.GetFiles(folderName))
            {
                using var bankStream = File.OpenRead($"{folderName}\\{Path.GetFileName(file)}");
                var bytes = new byte[bankStream!.Length];
                bankStream.Read(bytes, 0, bytes.Length);
                SoundBanks.Add(bytes);
                DebugClass.Log($"Loaded SoundBank: {Path.GetFileName(file)}");
            }
        }

        private static void LoadSoundBank(string location)
        {
            using var bankStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(location);
            var bytes = new byte[bankStream!.Length];
            bankStream.Read(bytes, 0, bytes.Length);
            SoundBanks.Add(bytes);

            DebugClass.Log($"Loaded SoundBank: {location}");
        }

        [Obsolete("AssetBundles are loaded automatically, calling this does literally nothing")]
        public static void AddBundle(string assetBundleLocation)
        {
            // Empty method because I don't want to go and remove stuff right now.
        }

        public static T Load<T>(string assetName) where T : UnityEngine.Object
        {
            try
            {
                assetName = assetName.ToLowerInvariant();
                if (assetName.Contains(":"))
                {
                    string[] path = assetName.Split(':');

                    assetName = path[1].ToLowerInvariant();
                }
                if (assetName.StartsWith("assets/"))
                    assetName = assetName.Remove(0, "assets/".Length);
                int index = AssetIndices[assetName];
                //DebugClass.Log($"used [{assetName}] to find index [{index}]");
                T asset = AssetBundles[index].LoadAsset<T>($"assets/{assetName}");

                if (asset is Material material)
                {
                    if (material.shader.name.StartsWith("MoistToolkit/StubbedShader"))
                        material.shader = Addressables.LoadAssetAsync<Shader>($"RoR2/Base/Shaders/{material.shader.name.Substring(27)}.shader").WaitForCompletion();
                }
                return asset;
            }
            catch (Exception e)
            {
                DebugClass.Log($"Couldn't load asset [{assetName}] reason: {e}");
                return null;
            }

        }

        public static Stream LoadDisplayRuleSetOverride(string overrideName)
        {
            string path = DisplayRuleSetOverrides[overrideName];

            return Assembly.GetExecutingAssembly().GetManifestResourceStream(path);
        }
    }
}
