//
//  SignInViewController.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/10.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit
import LeanCloud
import SVProgressHUD

class SignInViewController: UIViewController,IMClientDelegate {
    

    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordText.isSecureTextEntry=true
        passwordText.clearButtonMode = .whileEditing
        usernameText.clearButtonMode = .whileEditing
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    // MARK: - IMClientDelegateProtocol
    func client(_ client: IMClient, event: IMClientEvent) {
        print("dd")
    }
    
    func client(_ client: IMClient, conversation: IMConversation, event: IMConversationEvent) {
        print("sdf")
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        //SVProgressHUD.setDefaultStyle(.dark)
        //SVProgressHUD.setDefaultMaskType(.black)
        //SVProgressHUD.show()
        LCUser.logOut()
        LCUser.logIn(username: usernameText.text!, password: passwordText.text!){result in
            switch result{
            case .success(object: let user):
                print("登录成功")
                do {
                    let client = try IMClient(user: user)
                    client.delegate = delegator
                    client.open(completion: {result in
                        switch result{
                        case .failure(error: let error):
                            print(error.reason!)
                            //SVProgressHUD.dismiss()
                            break
                        case .success:
                            print("已开启")
                            print(client.ID)
                            current = client
                            //SVProgressHUD.dismiss()
                            self.performSegue(withIdentifier: "signInToChat", sender: self)
//                            if LCApplication.default.currentUser?.username == "azh"{
//                                do{
//                                    try client.createConversation(clientIDs: ["5e429eaa0a8a8400815a84b6"], name: "王文东", isUnique: true){result in
//                                        switch result{
//                                        case .success(value: let conversation):
//                                            print(conversation)
//                                            break
//                                        case .failure(error: let error):
//                                            print("建立会话失败")
//                                            print(error)
//                                            break
//                                        }
//                                    }
//                                }catch{
//                                    print(error.localizedDescription)
//                                }
//                            }
                            break
                        }
                    })
                }catch{
                    print(error.localizedDescription)
                }
                break
            case .failure(error: let error):
                let alert = UIAlertController(title: "登录失败", message: "\(error.errorUserInfo)", preferredStyle: .alert)
                let action = UIAlertAction(title: "重试", style: .default){action in
                    self.usernameText.text=""
                    self.passwordText.text=""
                    //SVProgressHUD.dismiss()
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                break
            }
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
