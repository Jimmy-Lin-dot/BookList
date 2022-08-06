//
//  ApiModel.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import Foundation
import SwiftyJSON
import PromiseKit

class ApiModel {
    // 取得使用者書單
    static func getBookListFromApi(completion:@escaping (_ isSuccess:Bool, _ result: [Book]) -> Void){
        firstly {
            WebApiObject.getUserList()
        }.done { resultData in
            var bookList = [Book]()
            // 取得資料之後存入資料庫
            for i in 0..<resultData.count {
                let item = resultData[i]
                let bookItem = Book(uuid: item["uuid"].intValue, title: item["title"].stringValue, coverUrl: item["coverUrl"].stringValue, publishDate: item["publishDate"].stringValue, publisher: item["publisher"].stringValue, author: item["author"].stringValue)
                bookList.append(bookItem)
            }
            
            let dbModel = DataBaseModel()
            dbModel.saveBook(data: bookList)
            completion(true,bookList)
        }.catch { error in
            print("error = \(error)")
            completion(false,[])
        }
    }
}
