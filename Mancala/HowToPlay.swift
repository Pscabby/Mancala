//
//  HowToPlay.swift
//  Mancala
//
//  Created by Abby on 2023/4/11.
//

import SwiftUI

struct HowToPlay: View {
    @State private var pic = ["1","2","3","4","5","6","7","8","9","10","11"]
    @Binding var ShowHowToPlay : Bool
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
            Button {
                ShowHowToPlay = false
            } label: {
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .foregroundColor(.purple)
                    .font(.custom("", size: 40))
            }
                Spacer()
                Text("How TO Play")
                    .font(.custom("Comics Deluxe", size: 40))
                    .foregroundColor(.purple)
                ForEach(pic,id:\.self){ data in
                    Image(data)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

//struct HowToPlay_Previews: PreviewProvider {
//    static var previews: some View {
//        HowToPlay()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
