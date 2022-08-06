//
//  BookViewController.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import UIKit
import Alamofire
import AlamofireImage

class BookViewController: UIViewController {
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var books = [Book]()
    var bookCollectionFlowLayout:UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        if (bookCollectionFlowLayout == nil) {
            bookCollectionFlowLayout = UICollectionViewFlowLayout()
            bookCollectionFlowLayout.sectionInset = UIEdgeInsets.zero
            bookCollectionFlowLayout.itemSize = CGSize(width: (self.view.frame.width - 40)/3, height: self.view.frame.height / 4)
            bookCollectionFlowLayout.scrollDirection = .vertical
            bookCollectionFlowLayout.minimumLineSpacing = CGFloat(30)
            bookCollectionView.setCollectionViewLayout(bookCollectionFlowLayout, animated: true)
        }
    }
}

extension BookViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as? BookCollectionViewCell {
            let bookCellItem = books[indexPath.row]
            bookCell.bookImage.af_setImage(withURL: URL(string: bookCellItem.coverUrl)!)
            bookCell.bookTitle.text = bookCellItem.title
            bookCell.bookDetail = bookCellItem
            bookCell.isFavorite = bookCellItem.isFavorite
            bookCell.isFavoriteIcon.image = bookCellItem.isFavorite ? UIImage(named: "heart") : UIImage(named: "love")
            
            return bookCell
        }
        
        return UICollectionViewCell()
    }
}

extension BookViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
