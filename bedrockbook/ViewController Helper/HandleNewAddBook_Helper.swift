//
//  HandleNewAddBook_Helper.swift
//  bedrockbook
//
//  Created by QUANG on 7/27/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit

extension ViewController {
    func handleNewAddBook() {
        if inputBookID != "" {
            getBookDetail(with: inputBookID) { (newBook) in
                //Successfully added book
                self.books.append(newBook)
                
                self.isAdding = true
                
                self.pushBooksToDatabase()
                
                self.booksCollectionView.reloadData()
                if self.isMyCollection {
                    self.bookCountOutlet.title = "Book Count: \(self.myCollection.count)"
                    
                }
                else {
                    self.bookCountOutlet.title = "Book Count: \(self.books.count)"
                    
                }
                inputBookID = ""
            }
        }
    }
}
