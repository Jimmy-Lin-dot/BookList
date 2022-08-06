//
//  WebApiObject.swift
//  BookCase
//
//  Created by 林柏頲 on 2022/8/5.
//

import Foundation
import SwiftyJSON
import PromiseKit
import Alamofire

class WebApiObject {
    static let apiUrl = "https://mservice.ebook.hyread.com.tw/exam/user-list"
    
    static func getUserList() -> Promise<JSON> {
        return Promise { seal in
            Alamofire.request(self.apiUrl, method: .get).responseJSON { response in
                if response.result.isSuccess {
                // Api 服務正常並成功接收到回傳結果
                    do{
                        try seal.fulfill(JSON(data: response.data!))
                    } catch {
                        
                    }
                } else {
                    // 呼叫API失敗拋出Alamofire的錯誤
                    // 當呼叫reject閉包則會返回至catch的block
                    seal.reject(response.result.error!)
                }
            }
        }
    }
}
