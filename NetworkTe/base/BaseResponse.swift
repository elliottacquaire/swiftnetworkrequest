//
//  BaseResponse.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/17.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import HandyJSON

class BaseResponse<T:Any>: HandyJSON {
    var message:String?
    var data:T?
    var desc : String? = "" // 请求描述
    var status : Bool? = false // 请求成功与否
    var flag: String! // 标记
    
    required init() {
        
    }

}

//2、返回为列表时的结构
class BaseListBean<T>:HandyJSON {
   var content:[T]?
   var number:Int?
   var size:Int?
   var totalElements:Int?
   
   required init() {
       
   }
}
