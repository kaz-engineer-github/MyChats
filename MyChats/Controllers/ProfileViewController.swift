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
    var alertController: UIAlertController!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        IconImageView.contentMode = .scaleAspectFill
        IconImageView.clipsToBounds = true
        IconImageView.layer.cornerRadius = IconImageView.frame.height / 2.0
        self.view.addSubview(IconImageView)
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
                let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                    let cameraPicker = UIImagePickerController()
                    cameraPicker.sourceType = sourceType
                    cameraPicker.delegate = self
                    self.present(cameraPicker, animated: true, completion: nil)
                }
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
  
    // MARK: comfirm alert function. If tap OK, user account delete.
    @IBAction func dispAlert(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "delete your account", message: "OK？", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
                Auth.auth().currentUser?.delete { error in
                    if let e = error {
                        print("error\(e)")
                        self.alert(title: "Error", message: "can't delte your account. Please do again.")
                    } else {
                        print("// Account deleted.")
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            })
      
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
  
    // MARK: Error alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
