//
//  SignInVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class SignInVC: UIViewController {
    
    let storage = Storage.storage()
    let picker = UIImagePickerController()
    var userImage: UIImage?
    
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgHeight.constant  = UIScreen.main.bounds.height / 6
        ConnectService().Network(view: self)
        emailText.delegate = self
        pwdText.delegate = self
        signInBtn.isEnabled = false
        signInBtn.backgroundColor = .lightGray
        
        picker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(tap)
        self.userImg.isUserInteractionEnabled = true
    }
}

//MARK: Button
extension SignInVC {
    @IBAction func signInBtn(_ sender: Any) {
        uploadImg(img: self.userImage!)
        let auth = AuthService()
        
        auth.signIn(email: emailText.text!, pwd: pwdText.text!,username: UserNameText.text!, vc: self, img: "gs://week-challenge-67756.appspot.com/\(emailText.text!)/\(emailText.text!)")
    }
}

//MARK: TextFieldDelegate
extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UserNameText {
            emailText.becomeFirstResponder()
        } else if textField == emailText {
            pwdText.becomeFirstResponder()
        } else {
            pwdText.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailText.text!.count > 5 && pwdText.text!.count > 5 {
            signInBtn.isEnabled = true
            signInBtn.backgroundColor = UIColor(red: 1.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        } else {
            signInBtn.isEnabled = false
            signInBtn.backgroundColor = .lightGray
        }
        return true
    }
}

extension SignInVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        print("SignInVC_selectedImageButton")
        let addPhoto = UIAlertController(title: "??????", message: "??? ??? ????????? ????????????", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "?????????", style: .default) { success in
            self.openLibrary()
        }
        let cameara = UIAlertAction(title: "?????????", style: .default) { success in
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
            print("?????? ????????? ??????")
            self.userImg.image = image
            self.dismiss(animated: true, completion: nil)
        } else {
            print("?????? ????????? ??????")
        }
    }
    
    func uploadImg(img: UIImage) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "\(self.emailText.text!)/\(self.emailText.text!)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        storage.reference().child(filePath).putData(data,metadata: metaData)
    }
}
