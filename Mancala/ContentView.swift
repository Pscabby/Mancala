//
//  ContentView.swift
//  Mancala
//
//  Created by Abby on 2023/3/29.
//

import SwiftUI

struct ContentView: View {
    @State private var ShowPlayer = false
    @State private var ShowComputer = false
    @State private var ShowStatistics = false
    @State private var ShowHowToPlay = false
    @State private var score = ScoreData(total: 0, win: 0, lose: 0, draws: 0)
    @State private var Player1 = ScoreData(total: 0, win: 0, lose: 0, draws: 0)
    @State private var Player2 = ScoreData(total: 0, win: 0, lose: 0, draws: 0)
    @AppStorage("Score") private var Score = Data()
    @AppStorage("ScorePlayer1") private var ScorePlayer1 = Data()
    @AppStorage("ScorePlayer2") private var ScorePlayer2 = Data()
    var body: some View {
        ZStack{
            Image("FirstPage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.7)
            VStack{
                Text("     The\n Mancala")
                    .font(.custom("Comics Deluxe", size: 60))
                HStack{
                    Button {
                        ShowComputer = true
                    } label: {
                        Text("VS Computer")
                            .font(.custom("Comics Deluxe", size: 30))
                    }.buttonStyle(.borderedProminent)
                    .padding(.trailing)
                    .fullScreenCover(isPresented: $ShowComputer) {
                        ComputerPage(ShowStatis: $ShowStatistics, ShowPlayer: $ShowComputer)
                    }
                    
                    Button {
                        ShowPlayer = true
                    } label: {
                        Text("VS Human")
                            .font(.custom("Comics Deluxe", size: 30))
                    }.buttonStyle(.borderedProminent)
                        .foregroundColor(.yellow)
                    .padding(.leading)
                    .fullScreenCover(isPresented: $ShowPlayer) {
                        PlayersGamePage(ShowStatis: $ShowStatistics, ShowPlayer: $ShowPlayer)
                    }
                }.padding(.bottom)
                
                HStack{
                    Button {
                        ShowStatistics = true
                        loadScore()
                    } label: {
                        Text("Statistics")
                            .font(.custom("Comics Deluxe", size: 30))
                    }.buttonStyle(.borderedProminent)
                        .foregroundColor(.green)
                        .padding(.trailing)
                        .fullScreenCover(isPresented: $ShowStatistics) {
                            
                            StatisiticsView(score: $score, Player1: $Player1, Player2: $Player2, ShowStatis: $ShowStatistics)
                        }
                    
                    Button {
                        ShowHowToPlay = true
                    } label: {
                        Text("How to Play")
                            .font(.custom("Comics Deluxe", size: 30))
                    }.buttonStyle(.borderedProminent)
                        .padding(.leading)
                        .fullScreenCover(isPresented: $ShowHowToPlay) {
                            HowToPlay(ShowHowToPlay: $ShowHowToPlay)
                        }
                }
                
            }
        }
    }
    func loadScore(){
        guard !Score.isEmpty else{return}
        do{
            score = try JSONDecoder().decode(ScoreData.self, from: Score)
            Player1 = try JSONDecoder().decode(ScoreData.self, from: ScorePlayer1)
            Player2 = try JSONDecoder().decode(ScoreData.self, from: ScorePlayer2)
        } catch{
            print(error)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
