//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let userdefault = UserDefaults.standard
  
    let db = Firestore.firestore()
  
    var messages: [Messages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextfield.delegate = self
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        fetchMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
  
    func fetchMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("error fetch data from firestore\(e)")
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    for doc in snapShotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Messages(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1 , section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date()
            ]) { (error) in
                if let e = error {
                    print("firestore has problem \(e)")
                } else {
                    print("success to save data")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                        self.textFieldShouldReturn(self.messageTextfield)
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.contentsLabel.text = message.body
        
        if userdefault.object(forKey: "key") != nil {
            cell.myImageView.image = readimage()
        }
        
        // MARK: message from you
        if message.sender == Auth.auth().currentUser?.email {
            cell.youImageView.isHidden = true
            cell.myImageView.isHidden = false
            cell.contentsView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.contentsLabel.textColor = UIColor(named: K.BrandColors.purple)
        }
        
        // MARK: message from another user
        else {
            cell.youImageView.isHidden = false
            cell.myImageView.isHidden = true
            cell.contentsView.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.contentsLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
    
    func readimage() -> UIImage {
        let data:NSData = userdefault.object(forKey: "key") as! NSData
        let savedData = UIImage(data: data as Data)
        return savedData!
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextfield.resignFirstResponder()
        return true
    }
}
