//
//  MusicDataStrc.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/17.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MusicModel : Decodable{
    var code : Int = 0
    var channels:[MusicDataStrc]
    init(jsonData: JSON) {
        channels =  jsonData["channels"].arrayValue.map({
            jsonDataItem -> MusicDataStrc in
            MusicDataStrc(jsonData: jsonDataItem)
        })
    }
}

struct MusicDataStrc : Decodable{
    var seq_id: Int? = 0
    var abbr_en: String = ""
    var name: String = ""
    var channel_id: Int = 0
    var name_en: String? = ""
    
//    var area:[Any]?
//    var detail_address: DetailAddressModel
    
    init(jsonData: JSON) {
         seq_id = jsonData["seq_id"].intValue
         abbr_en  = jsonData["abbr_en"].stringValue
         name = jsonData["name"].stringValue
         channel_id = jsonData["channel_id"].intValue
         name_en = jsonData["name_en"].stringValue
        
//        area          = jsonData["area"].arrayObject
//        detail_address = DetailAddressModel(jsonData: jsonData["detail_address"])

    }
}

struct DetailAddressModel {
    var province: String?
    var city: String?
    var district: String?
    var street: String?
    
    init(jsonData: JSON) {
        province = jsonData["province"].stringValue
        city = jsonData["city"].stringValue
        district = jsonData["district"].stringValue
        street = jsonData["street"].stringValue
    }
    
}
