//
//  getBookInfo_Helper.swift
//  bedrockbook
//
//  Created by Nguyenxloc on 7/6/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension ViewController {
    
    func getBookDetail(with ID: String, completion: @escaping (Book) -> ()) {
        
        var newBook: Book!
        
        Alamofire.request(URL(string: "https://www.googleapis.com/books/v1/volumes/\(ID)?key=\(apiKey)")!)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    return
                }
                
                do {
                    let receivedJSON = try JSON(data: response.data!)
                    
                    
                    
                    if let bookTitle = receivedJSON["volumeInfo"]["title"].string {
                        self.bookTitle = bookTitle
                    }
                    
                    if let bookAuthor = receivedJSON["volumeInfo"]["authors"].array {for i in 0..<bookAuthor.count {
                            self.bookAuthors.append(bookAuthor[i].string!)
                        }
                    }
                    if let bookImageLink = receivedJSON["volumeInfo"]["imageLinks"]["thumbnail"].string {self.bookImageLink = URL(string: bookImageLink)!
                    }
                    
                    if let bookPublisher = receivedJSON["volumeInfo"]["publisher"].string{self.bookPublisher = bookPublisher
                    }
                    
                    if let publishedDate = receivedJSON["volumeInfo"]["publishedDate"].string{self.publishedDate = publishedDate
                    }
                    
                    
                    if let categories = receivedJSON["volumeInfo"]["categories"].array{for i in 0..<categories.count {
                        self.categories.append(categories[i].string!)}
                        
                    }
                    if let pageCount = receivedJSON["volumeInfo"]["pageCount"].int {self.pageCount = pageCount}
                    if let avarageRating = receivedJSON["volumeInfo"]["averageRating"].double {self.avarageRating = avarageRating}
                    if let ratingCount = receivedJSON["volumeInfo"]["ratingsCount"].int {self.ratingCount = ratingCount}
                    if let language = receivedJSON["volumeInfo"]["language"].string{self.language = language}
                    if let buyLink = receivedJSON["saleInfo"]["buyLink"].string{self.buyLink = URL(string: buyLink)!}
                    else { self.buyLink = URL(string: "https://google.com") }
                    if let bookDescription = receivedJSON["volumeInfo"]["description"].string { self.bookDescription = bookDescription }
                    if let mainCategory = receivedJSON["volumeInfo"]["mainCategory"].string {
                        self.mainCategory = mainCategory
                    }
                    if let thumbnailLink = receivedJSON["volumeInfo"]["imageLinks"]["thumbnail"].string {
                        self.thumbnailLink = URL(string: thumbnailLink)!
                    }
                    if let retailPrice = receivedJSON["saleInfo"]["retailPrice"]["amount"].double {
                        self.retailPrice = retailPrice
                    }
                    
                    if let currencyCode = receivedJSON["saleInfo"]["retailPrice"]["currencyCode"].string {
                        self.currencyCode = currencyCode
                    }
                    
                    //http://jsonviewer.stack.hu/#https://www.googleapis.com/books/v1/volumes/zyTCAlFPjgYC?key=AIzaSyDP2zX2okXCxN88zHtKlYceLFho3DjwpGY
                    
                    newBook = Book(ID: ID, title: self.bookTitle, authors: self.bookAuthors, publisher: self.bookPublisher, publishedDate: self.publishedDate, bookDescription: self.bookDescription, pageCount: self.pageCount, mainCategory: self.mainCategory, categories: self.categories, averageRating: self.avarageRating, ratingsCount: self.ratingCount, thumbnailLink: self.thumbnailLink , imageLink: self.bookImageLink, language: self.language, retailPrice:self.retailPrice, currencyCode: self.currencyCode, buyLink: self.buyLink, borrowID: "0")
                    completion(newBook)
                }
                catch{}
        }
        
    }
    
}
