using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RoR2;
using ExamplePlugin;

namespace testMod
{


    public class TrailSetup : MonoBehaviour
    {
        //#if UNITY_STANDALONE
        CharacterModel characterModel;
        //#endif
        //[SerializeField]
        List<SkinnedMeshRenderer> skinnedMeshRenderers;
        //[SerializeField]
        List<GameObject> trails;
        [SerializeField]
        GameObject trailPrefab;

        public Material refmat1, refmat2;
        on onn;

        void Start()
        {
            skinnedMeshRenderers = new List<SkinnedMeshRenderer>();
            trails = new List<GameObject>();
            //   //InitGlobal();
            //  if (characterModel)
            // {
            characterModel = gameObject.transform.root.GetComponent<CharacterModel>();
            foreach (SkinnedMeshRenderer item in characterModel.transform.GetComponentsInChildren<SkinnedMeshRenderer>())
            {

                if (item.sharedMesh != null)
                {

                    skinnedMeshRenderers.Add(item);
                    GameObject gameObject = Instantiate(trailPrefab, item.transform);
                    gameObject.transform.Translate(0, 0, -0.34f);
                    //gameObject.GetComponent<tcTest>().SetupSkinnedMesh(item);
                    trails.Add(gameObject);
                }

            }
            // }

            //else
            //{
            //    foreach (SkinnedMeshRenderer item in transform.parent.GetComponentsInChildren<SkinnedMeshRenderer>())
            //    {
            //        skinnedMeshRenderers.Add(item);
            //        GameObject gameObject = Instantiate(trailPrefab, transform);
            //        gameObject.transform.Translate(0, 0, -0.34f);
            //        gameObject.GetComponent<tcTest>().SetupSkinnedMesh(item);
            //        trails.Add(gameObject);
            //    }
            //}
            //for (int i = 0; i < trails.Count; i++)
            //{

            //        trails[i].GetComponent<tcTest>().referencedMesh = skinnedMeshRenderers[i];
            //}

            onn = characterModel.body.master.playerCharacterMasterController.networkUser.localUser.cameraRigController.uiCam.gameObject.AddComponent<on>();
            if (!onn.mat)
                onn.mat = refmat1;
            if (!onn.mat2)
                onn.mat2 = refmat2;

        }
        //[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
        //public static void InitGlobal()
        //{
        //    TC.Internal.TCParticleGlobalManager[] array = Assets.mainAssetBundle.LoadAllAssets<TC.Internal.TCParticleGlobalManager>();
        //    for (int i = 0; i < array.Length; i++)
        //    {
        //        Object.DestroyImmediate(array[i]);
        //    }
        //    TC.Internal.TCParticleGlobalManager.Instance = new GameObject("TCParticleGlobalManager").AddComponent<TC.Internal.TCParticleGlobalManager>();
        //    TC.Internal.TCParticleGlobalManager.Instance.gameObject.hideFlags = HideFlags.HideAndDontSave;
        //    if (Application.isPlaying)
        //    {
        //        Object.DontDestroyOnLoad(TC.Internal.TCParticleGlobalManager.Instance);
        //    }
        //    TC.Internal.TCParticleGlobalManager.Instance.ComputeShader = Assets.computeShader;
        //}
        // Update is called once per frame
        void Update()
        {

        }

        private void OnDestroy()
        {
            for (int i = 0; i < trails.Count; i++)
            {
                Destroy(trails[i]);

            }

            trails.Clear();
            skinnedMeshRenderers.Clear();
            Destroy(onn);

        }
    }
}
