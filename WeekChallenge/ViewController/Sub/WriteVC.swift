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
    let picker = UIImagePickerController()
    var current: String?
    var imgUrl: String?
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var mainText: UITextField!
    @IBOutlet weak var imageMainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setText()
//        imageMainView.isHidden = true
        picker.delegate = self
    }
    
    func setText() {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyyMMdd"
        let current = String(fomatter.string(from: Date()))
        self.current! = current
        
        let range = documentID!.firstIndex(of: "+") ?? documentID!.endIndex
        self.mainTitle.text = String(documentID![..<range])
        self.currentDate.text = current
    }

    
    @IBAction func sendDB(_ sender: Any) {
        self.showTextOverlay("please Wait....")
//        if self.mainText.text != nil && self.mainTitle.text != nil && self.imageView.image != nil {
            if let userID = Auth.auth().currentUser?.email {
                let path = self.db.collection(userID).document("10+152157")
                var map = [String: String]()
                map["Title"] = "테스트입니다"
                map["Text"] =  "Test"
                map["Image"] = "gs://week-challenge-67756.appspot.com/bbb@bbb.com/10+152157/2022-02-28"
                path.updateData(["2022-02-28": map]) { err in
                    if err == nil {
                        print("성공")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            self.removeAllOverlays()
//        } else {
//            //Alert 생성
//        }
        
    }
    
    func uploadImg(img: UIImage) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        guard let userID = Auth.auth().currentUser?.email  else { return }
        let filePath = "\(userID)/10+152157/2022-02-28"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        storage.reference().child(filePath).putData(data,metadata: metaData)
    }
}

//MARK: 이미지 첨부 관련(UIImagePicker 사용)
extension WriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func selectedImage(_ sender: Any) {
        print("WriteVC_selectedImageButton")
//        self.imageMainView.isHidden = false
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
            self.dismiss(animated: true, completion: nil)
        } else {
            print("사진 가져오기 실패")
        }
    }
}
