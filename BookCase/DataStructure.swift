//
//  DataStructure.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import Foundation
import SQLite

// 全域變數
var SQLiteHelp = try! Connection(NSHomeDirectory()+"/Documents/BookCase.sqlite")

struct Book {
    var uuid : Int = 0
    var title : String = ""
    var coverUrl : String = ""
    var publishDate : String = ""
    var publisher : String = ""
    var author : String = ""
    var isFavorite : Bool = false
}
