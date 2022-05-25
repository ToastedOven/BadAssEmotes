using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace testMod
{


    public class on : MonoBehaviour
    {
        [SerializeField]
        public Material mat;
        [SerializeField]
        public Material mat2;


        private void OnPostRender()
        {
            RenderTextureDescriptor renderTextureDescriptor = new RenderTextureDescriptor(Screen.width, Screen.height);
            RenderTexture rText1 = new RenderTexture(renderTextureDescriptor);


            RenderTexture rText2 = new RenderTexture(renderTextureDescriptor);
            if (mat2)
                Graphics.Blit((Texture)rText2, mat2);
            if (mat)
                Graphics.Blit((Texture)rText1, mat);

        }




    }
}
