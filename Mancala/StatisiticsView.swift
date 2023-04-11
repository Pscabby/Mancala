//
//  StatisiticsView.swift
//  Mancala
//
//  Created by Abby on 2023/4/10.
//

import SwiftUI

struct StatisiticsView: View {
    @Binding var score  : ScoreData
    @Binding var Player1 : ScoreData
    @Binding var Player2 : ScoreData
    @Binding var ShowStatis : Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Button {
                    ShowStatis = false
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .foregroundColor(.purple)
                        .font(.custom("", size: 40))
                }
                VStack(alignment: .center){
                    Spacer()
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: geometry.size.width/1.2, height: geometry.size.height/1.1)
                            .foregroundColor(.purple)
                            .opacity(0.45)
                            .overlay {
                                VStack{
                                    Text("Statisitics")
                                        .font(.custom("Comics Deluxe", size: 30))
                                        .foregroundColor(.black)
                                        .padding(.top)
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: geometry.size.width/1.3, height: geometry.size.height/1.4)
                                        .foregroundColor(.gray)
                                        .opacity(0.9)
                                        .padding(.bottom,30)
                                        .overlay {
                                            ScrollView {
                                                HStack(alignment:.top){
                                                    VStack(alignment: .leading){
                                                        Group{
                                                            Text("Player")
                                                                .foregroundColor(.purple)
                                                            Text("You")
                                                            Text("Player1")
                                                            Text("Player2")
                                                        }.font(.custom("Comics Deluxe", size: 20))
                                                            .padding()
                                                        
                                                    }
                                                    VStack(alignment: .center){
                                                        Group{
                                                            Text("Total")
                                                            Group{
                                                                Text("\(score.total)")
                                                                Text("\(Player1.total)")
                                                                Text("\(Player2.total)")
                                                               
                                                            }.foregroundColor(.white)
                                                            
                                                        }.font(.custom("Comics Deluxe", size: 20))
                                                            .padding()
                                                    }
                                                    VStack(alignment: .center){
                                                        Group{
                                                            Text("Win")
                                                            Group{
                                                                Text("\(score.win)")
                                                                Text("\(Player1.win)")
                                                                Text("\(Player2.win)")
                                                               
                                                            }.foregroundColor(.white)
                                                            
                                                        }.font(.custom("Comics Deluxe", size: 20))
                                                            .padding()
                                                    }
                                                    VStack(alignment: .center){
                                                        Group{
                                                            Text("Lose")
                                                            Group{
                                                                Text("\(score.lose)")
                                                                Text("\(Player1.lose)")
                                                                Text("\(Player2.lose)")
                                                               
                                                            }.foregroundColor(.white)
                                                            
                                                        }.font(.custom("Comics Deluxe", size: 20))
                                                            .padding()
                                                    }
                                                    VStack(alignment: .center){
                                                        Group{
                                                            Text("Draws")
                                                            Group{
                                                                Text("\(score.draws)")
                                                                Text("\(Player1.draws)")
                                                                Text("\(Player2.draws)")
                                                               
                                                            }.foregroundColor(.white)
                                                            
                                                        }.font(.custom("Comics Deluxe", size: 20))
                                                            .padding()
                                                    }



                                                }
                                            }
                                        }
                                }
                            }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

//struct StatisiticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisiticsView()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
