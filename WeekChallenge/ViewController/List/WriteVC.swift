//
//  WriteVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/23.
//

import UIKit
import Firebase
import SwiftOverlays
import FirebaseStorage

class WriteVC: UIViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var documentID: String?
    var titles: String?
    let picker = UIImagePickerController()
    var current: String?
    var imgUrl: String?
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var mainText: UITextField!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        setText()
        self.imgView.isHidden = true
        picker.delegate = self
    }
    
    func setText() {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd"
        let current = String(fomatter.string(from: Date()))
        
        self.mainTitle.text = titles!
        self.currentDate.text = current
    }
    
    
    @IBAction func saveDB(_ sender: Any) {
        self.showTextOverlay("please Wait....")
        if self.newTitle.text != nil && self.mainText.text != nil && self.imageView.image != nil {
            let fomatter = DateFormatter()
            fomatter.dateFormat = "yyyy-MM-dd"
            let current = String(fomatter.string(from: Date()))
            
            guard let userID = Auth.auth().currentUser?.email  else { return }
            let path = self.db.collection(userID).document(self.documentID!)
            var map = [String: String]()
            map["Title"] = self.newTitle.text
            map["Text"] = self.mainText.text
            map["Image"] = "gs://week-challenge-67756.appspot.com/\(userID)/\(self.documentID!)/\(current)"
            path.updateData([current: map]) { err in
                if err == nil {
                    print("성공")
                    self.dismiss(animated: true, completion: nil)
                }
                self.removeAllOverlays()
            }
        } else {
            self.removeAllOverlays()
            print("save 실패")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImg(img: UIImage) {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd"
        let current = String(fomatter.string(from: Date()))
        
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        guard let userID = Auth.auth().currentUser?.email  else { return }
        let filePath = "\(userID)/\(self.documentID!)/\(current)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        storage.reference().child(filePath).putData(data,metadata: metaData)
    }
}

//MARK: 이미지 첨부 관련(UIImagePicker 사용)
extension WriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func selectedImage(_ sender: Any) {
        print("WriteVC_selectedImageButton")
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
            print("사진 가져오기 완료")
            self.imageView.image = image
            print("사진 저장 완료")
            uploadImg(img: image)
            self.imgView.isHidden = false
            self.dismiss(animated: true, completion: nil)
        } else {
            print("사진 가져오기 실패")
        }
    }
}
