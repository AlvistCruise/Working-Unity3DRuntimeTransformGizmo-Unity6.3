using UnityEngine;

public class CubeController : MonoBehaviour
{
    public float rotationSpeed = 10f;
    public float scaleSpeed = 2f;

    // Fungsi ini otomatis dipanggil oleh Unity saat mouse mengklik dan menahan objek yang memiliki Collider
    void OnMouseDrag()
    {
        // Mengambil input pergerakan mouse di layar
        float mouseX = Input.GetAxis("Mouse X") * rotationSpeed;
        float mouseY = Input.GetAxis("Mouse Y") * rotationSpeed;

        // Menerapkan rotasi berdasarkan pergerakan mouse
        transform.Rotate(Vector3.down, mouseX, Space.World);
        transform.Rotate(Vector3.right, mouseY, Space.World);
    }

    // Fungsi ini dipanggil selama kursor mouse berada di atas objek
    void OnMouseOver()
    {
        // Mengambil input dari roda scroll mouse
        float scroll = Input.GetAxis("Mouse ScrollWheel");
        
        if (scroll != 0f)
        {
            Vector3 newScale = transform.localScale + (Vector3.one * scroll * scaleSpeed);
            
            // Mencegah scale menjadi negatif/terbalik
            if (newScale.x > 0.1f) 
            {
                transform.localScale = newScale;
            }
        }
    }
}