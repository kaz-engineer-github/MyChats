//
//  ProfileViewController.swift
//  MyChats
//
//  Created by 吉本和史 on 2020/10/29.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import Photos

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var IconImageView: UIImageView!
    let userdefault = UserDefaults.standard
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        // MARK: after setting image, use this image permanent
        if userdefault.object(forKey: "key") != nil {
            IconImageView.image = readimage()
        }
    }
  
    @IBAction func setting(_ sender: Any) {
        changeImage()
    }
  
    func changeImage() {
      
        // MARK: message to permit use album
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
            case .authorized:
                print("auth")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                    print("status is \(newStatus)")
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        print("success")
                    }
                })
                print("not Determined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            @unknown default:
                print("default")
        }
      
        // MARK: open Album
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("error occured")
        }
    }
    
    // MARK: after select image from album
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.IconImageView.image = image
            saveImage(image: IconImageView.image!)
            self.dismiss(animated: true, completion: nil)
        }
    }
  
    // MARK: message from another user
    func saveImage(image: UIImage){
        let pngImageData: Data? = image.pngData()
        userdefault.set(pngImageData, forKey: "key")
    }
  
    // MARK: read casted UIimage data
    func readimage() -> UIImage {
        let data:NSData = userdefault.object(forKey: "key") as! NSData
        let savedData = UIImage(data: data as Data)
        return savedData!
    }
  
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
