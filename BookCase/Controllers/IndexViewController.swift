//
//  IndexViewController.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import UIKit

class IndexViewController: UIViewController {
    let TAG = "IndexViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        // 資料庫初始化
        let db = DataBase()
        db.initDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // View出現之後再開始取資料
        getBooks()
    }
    
    // 獲取資料
    private func getBooks() {
        let dbModel = DataBaseModel()
        var books = [Book]()
        
        // 有網路狀態，打Api並拿DB中的資料
        if Reachability.isConnectedToNetwork() {
            // 因為Api那邊沒有給收藏，所以如果DB有資料就直接從DB取
            // 暫時不考慮書籍更新問題
            if dbModel.getCountOfBookTable() > 0 {
                // DB有資料，從DB拿資料
                books = dbModel.getBook()
                goToMyBookPage(books)
            } else {
                // DB沒資料，從Api要資料
                ApiModel.getBookListFromApi { isSuccess, result in
                    if isSuccess {
                        books = dbModel.getBook()
                    } else {
                        // Api目前沒有帶回錯誤訊息，先用print就好，如果錯誤就帶回空的陣列
                        print("\(self.TAG) getBooks Api Error.")
                    }
                    self.goToMyBookPage(books)
                }
            }
        } else {
            // 沒網路，直接拿DB現成資料
            books = dbModel.getBook()
            goToMyBookPage(books)
        }
    }
    
    private func goToMyBookPage(_ books:[Book]) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let bookPage = mainStoryboard.instantiateViewController(withIdentifier: "bookViewController") as? BookViewController{
            bookPage.books = books
            self.present(bookPage, animated: true, completion: nil)
        }
    }
    

}
