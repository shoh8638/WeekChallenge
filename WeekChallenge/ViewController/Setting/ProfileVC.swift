//
//  ProfileVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit
import Firebase
import SwiftOverlays

class ProfileVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    let picker = UIImagePickerController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var userImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        picker.delegate = self
        setUp()
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUp() {
        self.imgView.layer.cornerRadius = imgView.frame.height / 2
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.borderWidth = 1
        self.imgView.layer.borderColor = CGColor(red: 223, green: 231, blue: 245, alpha: 1)
        self.imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImg(sender:))))
        self.imgView.isUserInteractionEnabled = true
        
        self.mainView.layer.cornerRadius = 20
        self.mainView.layer.masksToBounds = true
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        self.showTextOverlay("잠시만 기다려주세요")
        uploadImg(img: self.userImage!)
        self.dismiss(animated: true)
    }
    
    func uploadImg(img: UIImage) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        guard let userID = Auth.auth().currentUser?.email else { return }
        let filePath = "\(userID)/\(userID)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        storage.reference().child(filePath).putData(data,metadata: metaData)
        
        guard let userID = Auth.auth().currentUser?.email  else { return }
        let path = self.db.collection(userID).document("UserData")
        
        path.updateData(["Profile": "gs://week-challenge-67756.appspot.com/\(userID)/\(userID)"])
        self.removeAllOverlays()
    }
}

extension ProfileVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func tapImg(sender: UITapGestureRecognizer) {
        let addPhoto = UIAlertController(title: "알림", message: "둘 중 하나를 고르세요", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "갤러리", style: .default) { success in
            self.openLibrary()
        }
        let cameara = UIAlertAction(title: "카메라", style: .default) { success in
            self.openCamera()
        }
        
        addPhoto.addAction(library)
        addPhoto.addAction(cameara)
        self.present(addPhoto, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func openCamera() {
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.userImage = image
            print("사진 업로드 성공")
            self.imgView.image = image
            self.dismiss(animated: true, completion: nil)
        } else {
            print("사진 업로드 실패")
        }
    }
}
