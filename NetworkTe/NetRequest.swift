//
//  NetRequest.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/18.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import Moya

extension ObservableType where Element == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
        
//        guard let object = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
//            throw MoyaError.jsonMapping(self)
//        }
//        return object
    }
}

func tt(){
//    loginProvider.request(.loginOn(phoneNum: "13811112222", passNum: "666666")).mapModel(MusicModelHandJ.self).subscribe
}
