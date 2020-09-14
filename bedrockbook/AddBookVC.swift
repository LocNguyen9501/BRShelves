//
//  AddBookVC.swift
//  bedrockbook
//
//  Created by Nguyenxloc on 7/3/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SCLAlertView


class AddBookVC: UIViewController {
    //Mark : Variables
    var input = ""
    
    //Mark : outlet
    @IBOutlet weak var txtInput: UITextField!
    // Return
    @IBAction func btnReturn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    //ADD
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        
        if (txtInput.text?.isEmpty)! {
            let alertView = SCLAlertView()
            alertView.showError("Warning", subTitle: "Please type the title of the book")
        }
        else {
            input = txtInput.text!
            
            input = input.replacingOccurrences(of: " ", with: "+")
            // request URL
            Alamofire.request(URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(input)&key=AIzaSyDP2zX2okXCxN88zHtKlYceLFho3DjwpGY")!)
                .validate()
                .responseJSON { response in
                    guard response.result.isSuccess else {
                        return
                    }
                    
                    do {
                        let receivedJSON = try JSON(data: response.data!)
                        
                        if let numberOfBooks = receivedJSON["totalItems"].int {//ok roi
                            print(numberOfBooks)
                            if let bookArray = receivedJSON["items"].array {
                                for i in 0..<numberOfBooks {
                                    if let title = bookArray[i]["volumeInfo"]["title"].string {
                                        if title.isEmpty || title == "" || title.replacingOccurrences(of: " ", with: "") == "" {
                                            
                                            if i == numberOfBooks - 1 {
                                                let appearance = SCLAlertView.SCLAppearance(
                                                    showCloseButton: false
                                                )
                                                let alertView = SCLAlertView(appearance: appearance)
                                                alertView.addButton("Ok that's fine") {
                                                    print("Sorry")
                                                    self.dismiss(animated: true, completion: nil)
                                                }
                                                alertView.showError("Sorry 😬😬😬", subTitle: "We don't have that book...")
                                            }
                                            
                                            continue
                                        }
                                        else {
                                            inputBookID = bookArray[i]["id"].stringValue
                                            // quay lại màn hình chính
                                            self.dismiss(animated: true, completion: nil)
                                            break
                                        }
                                    }
                                }
                            }

                        }
                    }
                    catch{}
            }
        }
    }
    
    
    // Mark : Defaults
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
}
