//
//  LandmarkList.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/16.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    
    @ObservedObject var musicDataList = MusicLoadManager()
    
    var body: some View {
        //         List {
        //            LandmarkRow(landmark: musicDataList.landmarks[0])
        //            LandmarkRow(landmark: musicDataList.landmarks[1])
        //              }
//        NavigationView{
//            List(musicDataList.landmarks, id: \.channel_id) { landmark in
//                NavigationLink(destination: ContentView()){
//                     LandmarkRow(landmark: landmark)
//                }
//
//            }.navigationBarTitle("列表",displayMode: .inline)
//        }

//            NavigationView{
//                       List(musicDataList.music, id: \.channel_id) { landmark in
//                                  NavigationLink(destination: ContentView()){
//                                       LandmarkRowMu(landmark: landmark)
//                                  }
//
//                              }.navigationBarTitle("列表",displayMode: .inline)
//                          }

//        NavigationView{
//            List(musicDataList.musicModel.channels, id: \.channel_id) { landmark in
//                   NavigationLink(destination: ContentView()){
//                        LandmarkRowMu(landmark: landmark)
//                   }
//
//               }.navigationBarTitle("列表",displayMode: .inline)
//           }
       NavigationView{
                  List(musicDataList.musicHand.channels, id: \.channel_id) { landmark in
                         NavigationLink(destination: ContentView()){
                              LandmarkRow(landmark: landmark)
                         }

                     }.navigationBarTitle("列表",displayMode: .inline)
                 }
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}
