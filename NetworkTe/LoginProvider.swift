//
//  LoginProvider.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/18.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import Moya

let loginProvider = MoyaProvider<LoginProvider>()

public enum LoginProvider{
    case loginOn(phoneNum : String,passNum : String)
}

extension LoginProvider : TargetType{
    
    public var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    public var path: String {
        return "dddd"
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .loginOn(let phoneNum, let passNum):
            var params: [String: Any] = [:]
            params["phoneNum"] = phoneNum
            params["passNum"] = passNum
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
       
        }
        
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    
}
