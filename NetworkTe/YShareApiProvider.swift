//
//  YShareApiProvider.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/16.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import UIKit
import Result

//初始rovider
let YShareApiProvider = MoyaProvider<YShareAPI>(plugins: [RequestLoadingPlugin()])

/** 请求的endpoints）**/
//请求分类，定义枚举，存储网络请求
public enum YShareAPI {
    case shareNavList
    case shareList(pageSize: Int, pageNum: Int)
}

//请求配置，实现moya的TargetType协议
extension YShareAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.github.com/")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .shareNavList:
            return "manage/navigation/getNavigationList"
        default:
            return "ddddd/list"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
       
        default:
            return .get
        }
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .shareNavList:
            return .requestPlain
       case .shareList(let pageSize, let pageNum):
            var params: [String: Any] = [:]
            params["pageSize"] = pageSize
            params["pageNum"] = pageNum
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    //这个就是做单元测试模拟的数据，
//    只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    //请求头
    public var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}

