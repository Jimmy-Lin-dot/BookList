//
//  DataBaseModel.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import Foundation
import SQLite
import SwiftyJSON

class DataBaseModel {
    let bookTable = Table("books")
    let db = DataBase()
    
    // 取得資料庫書籍資料
    func getBook() -> [Book] {
        let bookDatas = try! SQLiteHelp.prepare(bookTable)
        var books = [Book]()
        for bookData in bookDatas {
            let bookItem = Book(uuid: bookData[db.uuid],title: bookData[db.title], coverUrl: bookData[db.coverUrl], publishDate: bookData[db.publishDate], publisher: bookData[db.publisher], author: bookData[db.author], isFavorite: bookData[db.isFavorite])
            books.append(bookItem)
        }
        
        return books
    }
    
    // 儲存書籍資料(一開始進來預設是否為最愛 = false)
    func saveBook(data:[Book]) {
        for i in 0..<data.count {
            let bookItem = data[i]
            try! SQLiteHelp.run(bookTable.insert(or: .replace,
                                                 db.uuid <- bookItem.uuid,
                                                 db.title <- bookItem.title,
                                                 db.coverUrl <- bookItem.coverUrl,
                                                 db.publishDate <- bookItem.publishDate,
                                                 db.publisher <- bookItem.publisher,
                                                 db.author <- bookItem.author,
                                                 db.isFavorite <- false))
        }
    }
    
    // 取得當前資料庫Table內的資料筆數
    func getCountOfBookTable() -> Int {
        let count = try! SQLiteHelp.scalar(bookTable.count)
        return count
    }
    
    // 更改DB中是否為最愛狀態
    func changeIsFavorite(bookUUID:Int , isFavoriteState: Bool) {
        let findBook = bookTable.filter(db.uuid == bookUUID)
        try! SQLiteHelp.run(findBook.update(db.isFavorite <- isFavoriteState))
    }
}
