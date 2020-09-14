//
//  BookCV_Helper.swift
//  bedrockbook
//
//  Created by Nguyenxloc on 7/6/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit
import SDWebImage
import UIImageColors
import FirebaseDatabase

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource/*, PinterestLayoutDelegate*/, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMyCollection {
            return myCollection.count
        }
        return books.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! myCell
        cell.delegate = self
        if isMyCollection {
            let bookDetail = myCollection[indexPath.row]
            cell.myImageView.sd_setImage(with: bookDetail.imageLink, completed: nil)
        }
        else {
            let bookDetail = books[indexPath.row]
            cell.myImageView.sd_setImage(with: bookDetail.imageLink, completed: nil)
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.1
        cell.clipsToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 10
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 10).cgPath
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 3
        let width = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 10
        
        return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: ((width / numberOfColumns) - (xInsets + cellSpacing)) * 1.6)
    }
    /*
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let numberOfColumns: CGFloat = 3
        let width = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 10
        
        return ((width / numberOfColumns) - (xInsets + cellSpacing)) * 1.6
    }*/
    //Mark: Delete Item
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addBarButtonItem.isEnabled = !editing
        if let indexPaths = booksCollectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths{
                if let cell = booksCollectionView?.cellForItem(at: indexPath) as? myCell{
                    cell.isEditing = editing
                }
            }
        }
        
    }
    
    
}

extension ViewController : BookCellDelegate {
    func delete(cell: myCell) {
        if let indexPath = booksCollectionView?.indexPath(for: cell) {
            
            let removingBook = books[indexPath.row]
            
            
            ref = Database.database().reference()
            ref.child("books").child(removingBook.ID).removeValue()
            
            //Remove a book from collection
            books.remove(at: indexPath.row)
            
            booksCollectionView?.deleteItems(at: [indexPath])
            
            bookCountOutlet.title = "Book Count: \(books.count)"
        }
    }
}
