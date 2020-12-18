//
//  MusicModelHandJ.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/18.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import HandyJSON

class MusicModelHandJ: HandyJSON ,Decodable{
//    var code : Int = 0
    var channels:Array<MusicDataItem> = []
    
    
    required init() {
        
    }
}

class MusicDataItem: HandyJSON,Decodable {
    var seq_id: String? = ""
    var abbr_en: String = ""
    var name: String = ""
    var channel_id: String = ""
    var name_en: String? = ""
    
    required init() {
        
    }
}

