//
//  DataBase.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import Foundation
import SQLite

class DataBase {
    
    // DB初始化，建立書本Table
    func initDB() {
        createBooks()
    }
    
    // 書本資訊
    let uuid = Expression<Int>("uuid")
    let title = Expression<String>("title")
    let coverUrl = Expression<String>("coverUrl")
    let publishDate = Expression<String>("publishDate")
    let publisher = Expression<String>("publisher")
    let author = Expression<String>("author")
    let isFavorite = Expression<Bool>("isFavorite")
    let bookTable = Table("books")
    
    private func createBooks() {
        try! SQLiteHelp.run(bookTable.create(ifNotExists: true) { t in
            t.column(uuid, primaryKey: true)
            t.column(title)
            t.column(coverUrl)
            t.column(publishDate)
            t.column(publisher)
            t.column(author)
            t.column(isFavorite)
        })
    }
}

