//
//  MusicLoadManager.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/16.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

/**

 1. 保持JSON语义，直接解析JSON，但通过封装使调用方式更优雅、更安全 ----------SwiftyJSON
 2. 预定义Model类，将JSON反序列化为类实例，再使用这些实例 --------ObjectMapper、JSONNeverDie、HandyJSON
 */

final class MusicLoadManager : ObservableObject{
    var landmarks = [MusicData]()
    var musicModel = MusicModel(jsonData: JSON("")) //初始化的问题，是否赋值
   @Published var musicHand = MusicModelHandJ()
   @Published var music = [MusicDataStrc]()
    
//    var channels:Array<JSON> = []
    init() {
//        for index in 0...15{
//            let m = MusicData()
//            m.channel_id = index
//            m.name = "jokes--index--"+String(index)
//            landmarks.append(m)
//        }
        fetchBasicInfo()
            .delay(DispatchTimeInterval.milliseconds(500),
        scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { model in
                self.musicHand = model
                print("model---\(model.channels[0].name)")
            }, onError:  { (error) in
                       print("error ===== \(error)")
                   }, onCompleted: {print("complete")}, onDisposed: {print("disposed")})
//            .disposed(by: disposeBag)
        
        
        
        
//        DouBanProvider.request(.channels) { result in
//            if case let .success(response) = result {
//                //解析数据
//                let data = try? response.mapJSON()
//                let json = JSON(data!)
//                //swift 自带序列化方法 需要实现 Decodable 协议 所有的子类及自身
////                let ddd = try! JSONDecoder().decode(MusicModel.self, from: response.data)
//                channels = json["channels"].arrayValue
//                let models = MusicModel.init(jsonData: json)
////                self.music = models.channels
//                print("ssss---\(models.channels[0])")
////                landmarks.applying(models.channels)
////                print("Success: \(ddd)")
//                //刷新表格数据
//                DispatchQueue.main.async{
//                    self.musicModel = MusicModel.init(jsonData: json)
//                    self.music = models.channels
//                }
//            }
//        }
        
//        DouBanProvider.request(.playlist("1")) { result in
//                       if case let .success(response) = result {
//                           //解析数据，获取歌曲信息
//                           let data = try? response.mapJSON()
//                           let json = JSON(data!)
//                           let music = json["song"].arrayValue[0]
//                           let artist = music["artist"].stringValue
//                           let title = music["title"].stringValue
//                           let message = "歌手：\(artist)\n歌曲：\(title)"
//                            print("Success---: \(json)")
//                           //将歌曲信息弹出显示
//                           showAlert(title: "channelName", message: message)
//                       }
//                   }
        
        
        
        
    }
    
    //Rxswift 实现
    func fetchBasicInfo() -> Observable<MusicModelHandJ> {
           return Observable.create { (observer) -> Disposable in
//               let api = DouBan(baseURL: self.baseURL, endpoint: .basicInfo)
//               requestAPI(api: api, observer: observer)
            DouBanProvider.request(.channels) { (response) in
                          switch response {
                          case .success(let value):
                              do {
                                print("result----\(value)")
//                                  let result = try value.map(MusicModelHandJ.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false)
//                                let result = JSONDeserializer<MusicModelHandJ>.deserializeFrom(value)
                                
                                //Rxswift 实现
                                let json = try JSONSerialization.jsonObject(with: value.data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                                                   
                                let result = MusicModelHandJ.deserialize(from: json)
                                  observer.onNext(result!)
                                  observer.onCompleted()
                              } catch {
                                  observer.onError(error)
                              }
                          case .failure(let error):
                              observer.onError(error)
                          }
                      }
            
               return Disposables.create()
           }.observeOn(SerialDispatchQueueScheduler(qos: .default)) // 切换到后台线程
       }
    
    func requestAPI<T: Decodable>(api: DouBan, observer: AnyObserver<T>) {
        DouBanProvider.request(api) { (response) in
               switch response {
               case .success(let value):
                   do {
                       let result = try value.map(T.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false)
                       observer.onNext(result)
                       observer.onCompleted()
                   } catch {
                       observer.onError(error)
                   }
               case .failure(let error):
                   observer.onError(error)
               }
           }
       }
}
