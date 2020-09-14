//
//  ViewController.swift
//  bedrockbook
//
//  Created by Nguyenxloc on 6/30/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import FirebaseDatabase
import FBSDKLoginKit
import SCLAlertView

class ViewController: UIViewController {
    
    //Mark Variables
    var bookTitle = ""
    var bookAuthors = [String]() // array
    var bookImageLink: URL!
    var bookPublisher = ""
    var publishedDate = ""
    var pageCount = 0
    var categories = [String]()
    var avarageRating = 0.0
    var ratingCount = 0
    var language = ""
    var buyLink: URL!
    var bookDescription = ""
    var mainCategory = ""
    var thumbnailLink :  URL!
    var retailPrice = 0.0
    var currencyCode = ""
    
    var books = [Book]()
    var myCollection = [Book]()
    
    var isAdding = false
    
    var isMyCollection = false
    
    //MARK: Outlets (outlets la cac cai IBOutlet nay)
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var bookCountOutlet: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnLogoutOutlet: UIBarButtonItem!
    @IBOutlet weak var btnLogOutlet: UIBarButtonItem!
    @IBOutlet weak var btnMyCollectionOutlet: UIBarButtonItem!
    //MARK: Actions
    override func viewDidAppear(_ animated: Bool) {
        
        checkBorrowReturn()

        handleNewAddBook()
        
        self.booksCollectionView.reloadData()
        if isMyCollection {
            bookCountOutlet.title = "Book Count: \(myCollection.count)"
            
        }
        else {
            bookCountOutlet.title = "Book Count: \(books.count)"
            
        }
    }
    
    // Mark : Default
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if let layout = booksCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }*/
        
        //UI
        booksCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        booksCollectionView.backgroundColor = UIColor.white
        
        //getAvailableBooksFromFirebase()

        self.autoUpdateAddedBook()
        
        updateUserInfo()
        
        //Implement delete
        navigationItem.leftBarButtonItems = [editButtonItem, btnLogoutOutlet, btnLogOutlet, btnMyCollectionOutlet]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    deinit {
        ref.child("books").removeAllObservers()
    }

    
    //Bar Button
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("I want to log out") {
            print("Logging out")
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            
            userDefaults.set("", forKey: defaultsKeys.userName)
            userDefaults.set("", forKey: defaultsKeys.userUid)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
            self.present(newViewController, animated: true, completion: nil)
        }
        alertView.addButton("No") {
            print("Doing Nothing")
        }
        alertView.showError("Confirmation", subTitle: "Are you sure you want to log out?")
    }
    
    
    @IBAction func btnLog(_ sender: UIBarButtonItem) {
        //Done
    }
    
    @IBAction func btnMyCollection(_ sender: UIBarButtonItem) {
        myCollection.removeAll()
        if !isMyCollection {
            //Open collection
            isMyCollection = true
            sender.image = #imageLiteral(resourceName: "icons8-book-shelf-64")
            for book in books {
                if book.borrowID == userName {
                    myCollection.append(book)
                }
            }
        }
        else {
            //Open Shelves
            isMyCollection = false
            sender.image = #imageLiteral(resourceName: "icons8-user-64")
        }
        
        
        self.booksCollectionView.reloadData()
        if isMyCollection {
            bookCountOutlet.title = "Book Count: \(myCollection.count)"
            
        }
        else {
            bookCountOutlet.title = "Book Count: \(books.count)"
            
        }
    }
}

