//
//  BookCollectionViewCell.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    var bookDetail : Book!
    var isFavorite : Bool!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var isFavoriteIcon: UIImageView!
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doFavorite)))
    }
    
    @objc func doFavorite(){
        let dbModel = DataBaseModel()
        if self.isFavorite {
            // 原本是已收藏，改成未收藏
            self.isFavoriteIcon.image = UIImage(named: "icon_heart_inactive")
        } else {
            // 原本是未收藏，改成已收藏
            self.isFavoriteIcon.image = UIImage(named: "icon_heart_active")
        }
        
        self.isFavorite = !self.isFavorite
        // 更新資料庫資料
        dbModel.changeIsFavorite(bookUUID: bookDetail.uuid , isFavoriteState: self.isFavorite)
    }
    
}
