//
//  LandmarkRowMu.swift
//  NetworkTe
//
//  Created by Elliott on 2020/12/17.
//  Copyright © 2020 ElliottTest. All rights reserved.
//

import SwiftUI

struct LandmarkRowMu: View {
    var landmark : MusicDataStrc
    
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

//struct LandmarkRowMu_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarkRowMu()
//    }
//}
