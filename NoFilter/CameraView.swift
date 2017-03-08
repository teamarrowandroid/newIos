//
//  CameraView.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-08.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CameraView: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imageViewer: UIImageView!
    
    var storage = FIRStorage.storage()
    var storageRef:FIRStorageReference!
    var data: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        storage = FIRStorage.storage().reference(forURL:"gs://projectreall-35e59.appspot.com")
        userStorage = storage.child("users")
        
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.camera
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //
        }

    }

    @IBAction func takePic(_ sender: UIButton) {
        
           }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       imageViewer.image=info[UIImagePickerControllerOriginalImage] as! UIImage;
        self.data = UIImageJPEGRepresentation(self.imageViewer.image!, 0.5)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postImage(_ sender: UIButton) {
        
        // Create a reference to the file you want to upload
        let uploadImageRef = storageRef.child("images/userUploads.jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = uploadImageRef.put(self.data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
        }
        
    }
}
