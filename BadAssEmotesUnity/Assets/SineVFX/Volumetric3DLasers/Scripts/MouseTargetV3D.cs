using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseTargetV3D : MonoBehaviour {

    public Transform targetCursor;
    public float speed = 1f;

    private Vector3 mouseWorldPosition;
    
    // Positioning cursor prefab
    void FixedUpdate () {  

        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit))
        {
            mouseWorldPosition = hit.point;
        }

        Quaternion toRotation = Quaternion.LookRotation(mouseWorldPosition - transform.position);
        transform.rotation = Quaternion.Lerp(transform.rotation, toRotation, speed * Time.deltaTime);
        targetCursor.position = mouseWorldPosition;

    }
}
