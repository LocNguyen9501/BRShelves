//
//  LogTVC.swift
//  bedrockbook
//
//  Created by QUANG on 7/27/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LogTVC: UITableViewController {
    
    var texts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        texts.removeAll()
        
        ref = Database.database().reference()
        ref.child("status").observeSingleEvent(of: .value) { (snapshot) in
            for node in snapshot.children.allObjects as! [DataSnapshot] {
                let value = node.value as? NSDictionary
                let text = value?["text"] as? String ?? ""
                self.texts.append(text)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogCell

        let text = texts[indexPath.row]
        
        cell.lblTitle.text = text

        return cell
    }
}
