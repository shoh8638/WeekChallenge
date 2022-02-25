//
//  WriteVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/23.
//

import UIKit
import Firebase
import SwiftOverlays

class WriteVC: UIViewController {
    
    var documentID: String?
    let picker = UIImagePickerController()
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var mainText: UITextField!
    @IBOutlet weak var imageMainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        imageMainView.isHidden = true
        picker.delegate = self
    }
    
    func setUp() {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyyMMdd"
        let current = String(fomatter.string(from: Date()))
        self.mainTitle.text = documentID!
        self.currentDate.text = current
    }
    
    @IBAction func sendDB(_ sender: Any) {
        self.showTextOverlay("please Wait....")
        //텍스트 필드 + 이미지뷰 충족 되면 해당DB 업데이트
        //해당 날짜에 DB안에 데이터가 isEmpty! 이면 알림창나오게
    }
}

//MARK: 이미지 첨부 관련(UIImagePicker 사용)
extension WriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func selectedImage(_ sender: Any) {
        print("WriteVC_selectedImageButton")
        self.imageMainView.isHidden = false
        //갤러리 접근하여 사진 선택 시, 이미지 뷰 부분에 삽입
        //선택을 누르고 이미지뷰에 사진을 넣어서 히든 해제
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
            //해당 DB Update하는 코드
        } else {
            print("사진 가져오기 실패")
        }
    }
}
