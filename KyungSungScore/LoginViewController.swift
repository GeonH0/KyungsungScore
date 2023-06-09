//
//  LoginViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/04/13.
//

import UIKit
import FirebaseAuth

class LoginViewController : UIViewController{
    
    
    
    @IBOutlet weak var errorLable: UILabel!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButton.isEnabled = false
        
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
        
        
    }
    
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        
        
        
        let email = EmailTextField.text ?? ""
        let password = PasswordTextField.text ?? ""
        
        
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error{
                let code = (error as NSError).code
                switch code{
                case 17007: // 이미 가입한 계정일때
                    
                    self.loginUser(withEmail: email, password: password)
                    //로그인 하기
                    
                default:
                    self.errorLable.text = error.localizedDescription
                    
                    
                }
            }else
            {
                showalert()
//                showViewController()
            }
        }
        
    }
    
    private func showViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func showalert(){
        let alert = UIAlertController(title: "주의", message: "합격의 기준은 22년도 70%컷에 의존합니다.", preferredStyle: UIAlertController.Style.alert)
        let OkAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){
            action in self.showViewController()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel){
            action in self.dismiss(animated: true,completion: nil)
        }
        
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        
        self.present(alert,animated: false)
    }
    
    
    private func loginUser(withEmail email:String,password:String){
        
        
        Auth.auth().signIn(withEmail: email,password: password ){
            [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error{
                errorLable.text = error.localizedDescription
                
            }else{
                showalert()
//                showViewController()
            }
            
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    } // 작성 완료시 키보드를 내려준다.
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = EmailTextField.text == ""
        let isPasswordEmpty = PasswordTextField.text == ""
        LoginButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    } // login 버튼을 활성화 시켜준다.
}
