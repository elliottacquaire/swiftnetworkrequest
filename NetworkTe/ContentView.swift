//
//  ContentView.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/15.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import SwiftUI
import Alamofire
import Moya
import SwiftyJSON

struct Joke: Codable,Identifiable{
    let id = UUID()
    var joke: String
    var status: Int
}


struct ContentView: View {
    @State private var jokes: [Joke] = []

    var body: some View {
       NavigationView {
                   VStack {
                       List {
                        
                           ForEach(jokes) { joke in
                               Text(joke.joke)
                               
                           }
                       }
                       .navigationBarTitle(Text("ICanHazDadJokes"))
                    Button(action: {test()},
                              label: {Text("Get Another Joke")})
                   }
                   
               }
               .onAppear(perform: { getJoke() })
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func getJoke() {
        let urlStr = URL(string: "https://baike.baidu.com/api/openapi/BaikeLemmaCardApi?scope=103&format=json&appid=379020&bk_key=swift&bk_length=600")!
       let url = URL(string: "https://api.liwushuo.com/v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0")!
    let urls = URL(string: "https://www.baidu.com")!
       var urlRequest = URLRequest(url:url)
    urlRequest.httpMethod = "GET"
//       urlRequest.addValue("text/plain",forHTTPHeaderField: "Accept")
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let data = data,
               let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode,
               let strData = String(bytes: data, encoding: .utf8)
           {
               print(strData)
//               jokes.insert(Joke(joke: strData, status: 20), at: 0)
           }
        
       }.resume()
       
   }
func getWek(){
    let url =  "https://api.liwushuo.com/v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0"
    
//    Alamofire.request(url).responseString{response in
//        print("Success: \(response.result.isSuccess)")
//        print("Response String: \(response.result.value)")
//    }
    
    /**
      // 默认是get请求
     Alamofire.request("https://httpbin.org/post", method: .post)
     Alamofire.request("https://httpbin.org/put", method: .put)
     Alamofire.request("https://httpbin.org/delete", method: .delete)
     
     let parameters: Parameters = ["foo": "bar"]

     // 下面这三种写法是等价的
     Alamofire.request("https://httpbin.org/get", parameters: parameters) // encoding 默认是`URLEncoding.default`
     Alamofire.request("https://httpbin.org/get", parameters: parameters, encoding: URLEncoding.default)
     Alamofire.request("https://httpbin.org/get", parameters: parameters, encoding: URLEncoding(destination: .methodDependent))

     // https://httpbin.org/get?foo=bar

     let parameters: Parameters = [
         "foo": "bar",
         "baz": ["a", 1],
         "qux": [
             "x": 1,
             "y": 2,
             "z": 3
         ]
     ]

     // 下面这三种写法是等价的
     Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
     Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: URLEncoding.default)
     Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: URLEncoding.httpBody)

     // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3

     设置Bool类型参数的编码
     URLEncoding.BoolEncoding提供了两种编码方式：

     .numeric：把true编码为1，false编码为0
     .literal：把true编码为true，false编码为false
     默认情况下：Alamofire使用.numeric。
     可以使用下面的初始化函数来创建URLEncoding，指定Bool编码的类型
     let encoding = URLEncoding(boolEncoding: .literal)
     URLEncoding.ArrayEncoding提供了两种编码方式：

     .brackets: 在每个元素值的key后面加上一个[]，如foo=[1,2]编码成foo[]=1&foo[]=2
     .noBrackets：不添加[]，例如foo=[1,2]编码成``foo=1&foo=2`
     默认情况下，Alamofire使用.brackets。

     可以使用下面的初始化函数来创建URLEncoding，指定Array编码的类型：

     let encoding = URLEncoding(arrayEncoding: .noBrackets)
     JSON编码
     JSONEncoding类型创建了一个JOSN对象，并作为请求体。编码请求的请求头的Content-Type请求字段被设置为application/json。

     使用JSON编码参数的POST请求

     let parameters: Parameters = [
         "foo": [1,2,3],
         "bar": [
             "baz": "qux"
         ]
     ]

     // 下面这两种写法是等价的
     Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
     Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding(options: []))

     // HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}

     
     let headers: HTTPHeaders = [
         "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
         "Accept": "application/json"
     ]

     Alamofire.request("https://httpbin.org/headers", headers: headers).responseJSON { response in
         debugPrint(response)
     }

     
     默认的Alamofire SessionManager为每一个请求提供了一个默认的请求头集合，包括：

     Accept-Encoding，默认是gzip;q=1.0, compress;q=0.5。
     Accept-Language，默认是系统的前6个偏好语言，格式类似于en;q=1.0。
     User-Agent，包含当前应用程序的版本信息。例如
     iOS Example/1.0 (com.alamofire.iOS-Example; build:1; iOS 10.0.0) Alamofire/4.0.0。
     如果要自定义这些请求头集合，我们必须创建一个自定义的URLSessionConfiguration，defaultHTTPHeaders属性将会被更新，并且自定义的会话配置也会应用到新的SessionManager实例。

     认证
     认证是使用系统框架URLCredential和URLAuthenticationChallenge实现的。

     支持的认证方案
     HTTP Basic
     HTTP Digest
     Kerberos
     NTLM
     HTTP Basic认证
     在合适的时候，在一个请求的authenticate方法会自动提供一个URLCredential给URLAuthenticationChallenge：

     let user = "user"
     let password = "password"

     Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
         .authenticate(user: user, password: password)
         .responseJSON { response in
             debugPrint(response)
     }
     根据服务器实现，Authorization header也可能是适合的：

     let user = "user"
     let password = "password"

     var headers: HTTPHeaders = [:]

     if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
         headers[authorizationHeader.key] = authorizationHeader.value
     }

     Alamofire.request("https://httpbin.org/basic-auth/user/password", headers: headers)
         .responseJSON { response in
             debugPrint(response)
     }
     使用URLCredential认证
     let user = "user"
     let password = "password"

     let credential = URLCredential(user: user, password: password, persistence: .forSession)

     Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
         .authenticate(usingCredential: credential)
         .responseJSON { response in
             debugPrint(response)
     }
     注意：使用URLCredential来做认证，如果服务器发出一个challenge，底层的URLSession实际上最终会发两次请求。第一次请求不会包含credential，并且可能会触发服务器发出一个challenge。这个challenge会被Alamofire接收，credential会被添加，然后URLSessin会重试请求。

     
     */
    Alamofire.request(url)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
        switch response.result {
        case .success:
            print("Validation Successful")
        case .failure(let error):
            print(error)
        }
    }

    
    
}

//频道列表数据
var channels:Array<JSON> = []
func test() {
      //使用我们的provider进行网络请求（获取频道列表数据）
    /**
     Moya 会将 Alamofire 成功或失败的响应包裹在 Result 枚举中返回，
     .success(Moya.Response)：成功的情况。我们可以从 Moya.Response 中得到返回数据（data）和状态（status ）
     .failure(MoyaError)：失败的情况。这里的失败指的是服务器没有收到请求（例如可达性/连接性错误）或者没有发送响应（例如请求超时）可以在这里设置个延迟请求，过段时间重新发送请求。
     除了连接超时这样的网络问题会返回 .failure，像是服务器报错（404）、请求未授权（401）等都是返回 .success 的。这样我们还需要根据状态码来判断返回数据是否是正确的。
     Moya.Response 本身就提供了下面两个方法来过滤 response 响应：
     filterSuccessfulStatusCodes()：返回状态码为 200 - 299 的响应
     filterSuccessfulStatusAndRedirectCodes()：返回状态码为 200 - 399 的响应
     */
            DouBanProvider.request(.channels) { result in
                if case let .success(response) = result {
                    //解析数据
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    channels = json["channels"].arrayValue
                     print("Success: \(json)")
                    //刷新表格数据
                    DispatchQueue.main.async{
//                        self.tableView.reloadData()
                    }
                }
                /**
                 switch result {
                 case let .success(response):
                     let statusCode = response.statusCode // 响应状态码：200, 401, 500...
                     let data = response.data // 响应数据
                 do {
                            //过滤成功的状态码响应
                            try response.filterSuccessfulStatusCodes()
                            let data = try response.mapJSON()
                            //继续做一些其它事情....
                        }
                        catch {
                            //处理错误状态码的响应...
                        }
                     //继续做一些其它事情....
                 case let .failure(error):
                     //错误处理....
                 switch error { //switch 语句判断具体的 MoyaError 错误类型
                 case .imageMapping(let response):
                     print("错误原因：\(error.errorDescription ?? "")")
                     print(response)
                 case .jsonMapping(let response):
                     print("错误原因：\(error.errorDescription ?? "")")
                     print(response)
                     break
                  }
                 }
                 */
            }
    
    //使用我们的provider进行网络请求（根据频道ID获取下面的歌曲）
    //获取选中项信息
//          let channelName = channels[indexPath.row]["name"].stringValue
//          let channelId = channels[indexPath.row]["channel_id"].stringValue
            DouBanProvider.request(.playlist("1")) { result in
                if case let .success(response) = result {
                    //解析数据，获取歌曲信息
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    let music = json["song"].arrayValue[0]
                    let artist = music["artist"].stringValue
                    let title = music["title"].stringValue
                    let message = "歌手：\(artist)\n歌曲：\(title)"
                     print("Success---: \(json)")
                    //将歌曲信息弹出显示
                    showAlert(title: "channelName", message: message)
                }
            }
    
    Network.request(.playlist("0"), success: { json in
        //获取歌曲信息
        let music = json["song"].arrayValue[0]
        let artist = music["artist"].stringValue
        let title = music["title"].stringValue
        let message = "歌手：\(artist)\n歌曲：\(title)"
        //将歌曲信息弹出显示
//        self.showAlert(title: channelName, message: message)
    }, error: { statusCode in
        //服务器报错等问题
        print("请求错误！错误码：\(statusCode)")
    }, failure: { error in
        //没有网络等问题
        print("请求失败！错误信息：\(error.errorDescription ?? "")")
    })

    //使用多个 target 的 Privider 这么使用
//    provider.request(MultiTarget(DouBan.channels)) { result in
        // do something with `result`
//    }



}

//显示消息
   func showAlert(title:String, message:String){
       let alertController = UIAlertController(title: title,
                                               message: message, preferredStyle: .alert)
       let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
       alertController.addAction(cancelAction)
//       self.present(alertController, animated: true, completion: nil)
   }


