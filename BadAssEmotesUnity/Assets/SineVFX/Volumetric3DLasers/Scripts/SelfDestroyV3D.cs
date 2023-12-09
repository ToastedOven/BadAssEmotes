using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelfDestroyV3D : MonoBehaviour {

    public float timeToDestroy = 2f;

	void Start () {
        Destroy(gameObject, timeToDestroy);
    }
}
