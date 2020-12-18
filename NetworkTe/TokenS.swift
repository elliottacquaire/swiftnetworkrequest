//
//  TokenS.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/16.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

/**
 //定义token源对象
 let source = TokenSource()
          
 //初始化豆瓣FM请求的provider（并使用自定义插件）
 let HttpbinProvider = MoyaProvider<Httpbin>(plugins: [
      AuthPlugin(tokenClosure: { return source.token })
 ])
          
 //设置token串
 source.token = "hangge12345
 
 */
import Foundation
import Moya

//用于存储令牌字符串
class TokenSource {
    var token: String?
    init() { }
}

protocol AuthorizedTargetType: TargetType {
    //返回是否需要授权
    var needsAuth: Bool { get }
}

struct AuthPlugin: PluginType {
    //获取令牌字符串方法
    let tokenClosure: () -> String?
     //令牌字符串
        let token: String
    
    //准备发起请求
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        //判断该请求是否需要授权
               guard
                   let target = target as? AuthorizedTargetType,
                   target.needsAuth
                   else {
                       return request
               }
                
//               var request = request
               //将token添加到请求头中
//               request.addValue(token, forHTTPHeaderField: "Authorization")
        
        var request = request
        //获取获取令牌字符串
        if let token = tokenClosure() {
            //将token添加到请求头中
            request.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

