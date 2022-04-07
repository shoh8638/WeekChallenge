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

//ListVC에 CardView와 같은 형식으로 구성
class WriteVC: UIViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var documentID: String?
    var titles: String?
    let picker = UIImagePickerController()
    var imgUrl: String?
    var dateString: String = ""
    var userDates: [String]?
    var uploadImg: UIImage?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var mainText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LayoutService().onlyCornerApply(view: mainView)
        LayoutService().imgOnlyCornerApply(img: imageView)
        ConnectService().Network(view: self)
        setText()
    }
    
    func setText() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: datePicker.date)
        picker.delegate = self
        datePicker.addTarget(self, action: #selector(pickerDate), for: .valueChanged)
    }
    
    @objc func pickerDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: datePicker.date)
    }
    
    @IBAction func saveDB(_ sender: Any) {
        self.showTextOverlay("please Wait....")
        if self.newTitle.text == "" {
            self.removeAllOverlays()
            print("save 실패")
            self.dismiss(animated: true, completion: nil)
        }
        
        else if self.mainText.text == "" {
            self.removeAllOverlays()
            print("save 실패")
            
        }
        
        else if !self.userDates!.contains(self.dateString) {
            self.removeAllOverlays()
            print("save 실패")
        }
        else {
            guard let userID = Auth.auth().currentUser?.email  else { return }
            
            var data = Data()
            data = self.uploadImg!.jpegData(compressionQuality: 0.8)!
     
            let filePath = "\(userID)/\(self.documentID!)/\(self.dateString)"
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            
        let path = self.db.collection(userID).document(self.documentID!)
        var map = [String: String]()
        map["Title"] = self.newTitle.text
        map["Text"] = self.mainText.text
            map["Image"] = "gs://week-challenge-67756.appspot.com/\(userID)/\(self.documentID!)/\(self.dateString)"
            path.updateData([self.dateString: map]) { err in
            if err == nil {
                print("성공")
                self.storage.reference().child(filePath).putData(data,metadata: metaData)
                self.dismiss(animated: true, completion: nil)
            }
            self.removeAllOverlays()
        }
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImg(img: UIImage) {

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
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        addPhoto.addAction(library)
        addPhoto.addAction(cameara)
        addPhoto.addAction(cancel)
        
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
            self.uploadImg = image
            self.dismiss(animated: true, completion: nil)
        } else {
            print("사진 가져오기 실패")
        }
    }
}
