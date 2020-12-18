//
//  DataT.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/15.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

/**
 cocoapods安装及依赖集成步骤：
 1，sudo gem install cocoapods       //安装cocoapods
 2， pod setup --verbose         //查看安装状态
 3，cd /Users/elliott/ITestProgram/NetworkTe              //进入项目根目录
 4， pod init          //初始化生成Podfile文件
 5，open -a Xcode Podfile                 //Xcode打开此文件
 6，pod 'Alamofire', '~> 5.4.0'    //有具体版本的
 6，pod 'Alamofire'     //无版本会根据iOS版本添加最新的合适iOS的版本
 7，pod install        //安装Podfile文件里配置的依赖，对于安装过的则不会重复安装，
 8，安装完成后 Please close any current Xcode sessions and use `NetworkTe.xcworkspace` for this project from now on. 重新打开   .xc   的项目，开发。

 */
/**
 self是实例的指针，[self class]是类的指针，静态方法得用类的指针来调用
 使用self指明被访问的是自身属性还是参数
 convenience init() {
   /*
   必须使用self，因为按照二段构造的规则，
   在第一阶段初始化完成之前，
   无法使用self，
   而且由于面向对象语言的特性，
   所有的初始化方法名都是init，
   没有self，系统不知道调用谁的init
   */
   self.init()
   // 进行初始化
 }
 
 闭包中访问自身属性和调用自身方法时,闭包可能被抛出，其必须知道其中的方法和属性属于谁，所以要用self
 
 */
import Foundation
import Moya

//使用多个 target 的 Privider 可以这么定义
let provider = MoyaProvider<MultiTarget>()


//初始化豆瓣FM请求的provider
let DouBanProvider = MoyaProvider<DouBan>(plugins: [RequestLoadingPlugin()])
//（并使用自定义插件）
//let DouBanProvider = MoyaProvider<DouBan>(PluginType:[ RequestAlertPlugin(viewController: self)])
/** 下面定义豆瓣FM请求的endpoints（供provider使用）**/
//请求分类
public enum DouBan {
    case channels  //获取频道列表
    case playlist(String) //获取歌曲
}

//请求配置
extension DouBan:AuthorizedTargetType{
    //服务器地址
       public var baseURL: URL {
           switch self {
           case .channels:
               return URL(string: "https://www.douban.com")!
           case .playlist(_):
               return URL(string: "https://douban.fm")!
           }
       }
    
    //各个请求的具体路径
       public var path: String {
           switch self {
           case .channels:
               return "/j/app/radio/channels"
           case .playlist(_):
               return "/j/mine/playlist"
           }
       }
        
       //请求类型
       public var method: Moya.Method {
           return .get
       }
    
    //请求任务事件（这里附带上参数）
    //我们将一个参数设为 nil，那么相当于将其从参数列表中删除，发送请求时是不会传递这个参数的

       public var task: Task {
           switch self {
           case .playlist(let channel):
               var params: [String: Any] = [:]
               params["channel"] = channel
               params["type"] = "n"
               params["from"] = "mainsite"
               return .requestParameters(parameters: params,
                                         encoding: URLEncoding.default)
           default:
               return .requestPlain
           }
       }
        
       //是否执行Alamofire验证
       public var validate: Bool {
           return false
       }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
      public var sampleData: Data {
          return "{}".data(using: String.Encoding.utf8)!
      }
       
      //请求头
      public var headers: [String: String]? {
          return nil
      }
    //是否需要授权
      public var needsAuth: Bool {
          switch self {
          case .channels:
              return true
          case .playlist(_):
              return false
          }
      }
    
}
