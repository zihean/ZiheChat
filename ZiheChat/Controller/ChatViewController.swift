//
//  ChatViewController.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/10.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit
import LeanCloud

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendBtn: UIButton!
    
    var messageArr:[String] = [String]()
    var conversation : IMConversation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        openConversation()

        
        messageTextField.delegate=self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(gesture)
        
        
        
        
        
        
        
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant=335
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant=60
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    // MARK: - UITableViewDelegate
    //每个section显示多少个单元格
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomTableViewCell
        //let messageArray=["第一条信息","第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息第二条信息","第三条信息"]
        cell.messageText.text=messageArr[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //调整单元高度
    func configureTableView(){
        messageTableView.delegate=self
        messageTableView.dataSource=self
        messageTableView.separatorStyle = .none
        messageTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        messageTableView.estimatedRowHeight = 120.0
        messageTableView.rowHeight = UITableView.automaticDimension
    }
    
    func openConversation(){
        do {
            let conversationQuery = current.conversationQuery
            try conversationQuery.getConversation(by: "5e43b43f90aef5aa84f948da"){ (result) in
                switch result {
                case .success(value: let conversation):
                    print(conversation)
                    self.conversation=conversation
                    self.getMessages()
                    break
                case .failure(error: let error):
                    print(error)
                    break
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getMessages(){
        do {
            try conversation.queryMessage(limit: 10) { (result) in
                switch result {
                case .success(value: let messages):
                    for message in messages{
                        print(message.content?.string)
                        self.messageArr.append((message.content?.string)!)
                        print(message.fromClientID)
                    }
                    self.configureTableView()
                    break
                case .failure(error: let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func loginOutPressed(_ sender: Any) {
        LCUser.logOut()
        current.close(completion: {result in
            
        })
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        messageTextField.endEditing(true)
        messageTextField.isEnabled=false
        sendBtn.isEnabled=false
        
        do {
            let textMessage = IMTextMessage(text: messageTextField.text!)
            try conversation.send(message: textMessage) { (result) in
                switch result {
                case .success:
                    print("发送成功")
                    break
                case .failure(error: let error):
                    print(error.reason!)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
//        let user=LCApplication.default.currentUser
//        do{
//            let message = LCObject(className: "Message")
//            try message.set("Sender", value: user?.username)
//            try message.set("MessageContent", value: messageTextField.text)
//            _ = message.save(){result in
//                switch result{
//                case .failure(error: let error):
//                    let alert = UIAlertController(title: "对不起，发送失败", message: "\(error.errorUserInfo)", preferredStyle: .alert)
//                    let action=UIAlertAction(title: "重试", style: .default, handler: nil)
//                    alert.addAction(action)
//                    self.present(alert, animated: true, completion: nil)
//                    break
//                case .success:
//                    self.sendBtn.isEnabled = true
//                    self.messageTextField.isEnabled = true
//                    self.messageTextField.text = ""
//                    break
//                }
//            }
//        }catch{
//            print(error)
//        }
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
