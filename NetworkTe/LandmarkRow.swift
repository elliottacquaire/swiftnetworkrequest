//
//  LandmarkRow.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/16.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: MusicDataItem
    var body: some View {
         HStack {
//                   landmark.image
//                       .resizable()
//                       .frame(width: 50, height: 50)
                   Text(landmark.name)
//            print("ssss---\(landmark.channel_id)")
//                Text(landmark.channel_id)
                   Spacer()
               }
    }
}

//struct LandmarkRow_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarkRow(landmark:MusicData())
//    }
//}
