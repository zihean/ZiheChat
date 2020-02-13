//
//  SignUpViewController.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/10.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit
import LeanCloud

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText1: UITextField!
    @IBOutlet var passwordText2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameText.resignFirstResponder()
        passwordText1.resignFirstResponder()
        passwordText2.resignFirstResponder()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        print("点击注册")
        if passwordText1.text == passwordText2.text{
            print("密码一致")
//            let user=BmobUser()
//            user.username=usernameText.text!
//            user.password=passwordText1.text!
//            user.signUpInBackground(){ (isSuccessful, error) in
//                if error != nil{
//                    print("Error:::::\(error)")
//
//                    let alert = UIAlertController(title: "亲爱的用户", message: "\(error?.localizedDescription)", preferredStyle: .alert)
//                    let action = UIAlertAction(title: "重试", style: .default)
//                    alert.addAction(action)
//                    self.present(alert, animated: true, completion: nil)
//                }else{
//                    print("注册成功")
//                    let alert = UIAlertController(title: "亲爱的用户", message: "注册成功！", preferredStyle: .alert)
//                    let action = UIAlertAction(title: "立即体验", style: .default ){action in
//                        self.performSegue(withIdentifier: "signUpToChat", sender: self)
//                    }
//                    alert.addAction(action)
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
            do{
                let user = LCUser()
                user.username = usernameText.text?.lcString
                user.password = passwordText1.text?.lcString
                _ = user.signUp{(result) in
                    switch result{
                    case .success:
                        print("注册成功")
                    let alert = UIAlertController(title: "亲爱的用户", message: "注册成功！", preferredStyle: .alert)
                    let action = UIAlertAction(title: "立即体验", style: .default ){action in
                        _ = LCUser.logIn(username: self.usernameText.text!, password: self.passwordText1.text!){result in
                            switch result{
                            case .success(object: let user):
                                do {
                                    let client = try IMClient(user: user)
                                    client.open(completion: {result in
                                        
                                    })
                                }catch{
                                    print("error")
                                }
                                break
                            case .failure(error: let error):
                                print(error)
                            }
                        }
                        self.performSegue(withIdentifier: "signUpToChat", sender: self)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                        break
                    case .failure(error: let error):
                        print("Error::::\(error)")
                        let alert = UIAlertController(title: "亲爱的用户", message: "\(error.errorUserInfo)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "重试", style: .default)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }else{
            print("两次密码输入不一致")
            let alert = UIAlertController(title: "亲爱的用户", message: "两次密码输入不一致，请检查！", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default ){action in
                self.passwordText1.text=""
                self.passwordText2.text=""
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
