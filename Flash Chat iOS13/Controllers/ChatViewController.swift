//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var ms: [msg] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "MsgCellTableViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadmsg()
        
    }
    
    func loadmsg()
    {
        
        db.collection("Messages").order(by: "time").addSnapshotListener{ querysnap, error in
            self.ms = []
            if error != nil
            {
                print("Problem in retrieving data")
            }
            else
            {
                if let doc = querysnap?.documents
                {
                    for d in doc
                    {
                        if let s = d.data()["sender"] as? String , let m = d.data()["body"] as? String
                        {
                            self.ms.append(msg(s: s, m: m))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: IndexPath(row: self.ms.count-1, section: 0), at: .top, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text , let sender = Auth.auth().currentUser?.email
        {
            db.collection("Messages").addDocument(data: [
                "sender":sender,
                "body":message,
                "time":Date().timeIntervalSince1970
            ]) { error in
                if error != nil
                {
                    print("Failed to save data")
                }
                else
                {
                    print("SAVED")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func lo(_ sender: UIBarButtonItem) {
        do
        {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch let signOutError as NSError
        {
          print("Error signing out: %@", signOutError)
        }
          
    }
    
}


extension ChatViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
            as! MsgCellTableViewCellTableViewCell
            let mess = ms[indexPath.row]
            cell.label.text = mess.m
            if mess.s == Auth.auth().currentUser?.email
            {
                cell.se.isHidden = true
                cell.A.isHidden = false
                cell.V.backgroundColor = UIColor(named: "BrandLightPurple")
                cell.label.textColor = UIColor(named: "BrandPurple")
            }
            else
            {
                cell.se.isHidden = false
                cell.A.isHidden = true
                cell.V.backgroundColor = UIColor(named: "BrandPurple")
                cell.label.textColor = UIColor(named: "BrandLightPurple")
            }
           
            return cell
            
        }

    
    
}
