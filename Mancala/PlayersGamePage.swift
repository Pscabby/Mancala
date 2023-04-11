//
//  PlayersGamePage.swift
//  Mancala
//
//  Created by Abby on 2023/4/4.
//

import SwiftUI
import AVFoundation

struct PlayersGamePage: View {
    @State private var player1 = [HoleData(position: 1,amount: 4),HoleData(position: 2,amount: 4),HoleData(position: 3,amount: 4),HoleData(position: 4,amount: 4),HoleData(position: 5,amount: 4),HoleData(position: 6,amount: 4)]
    @State private var player2 = [HoleData(position: 1,amount: 4),HoleData(position: 2,amount: 4),HoleData(position: 3,amount: 4),HoleData(position: 4,amount: 4),HoleData(position: 5,amount: 4),HoleData(position: 6,amount: 4)]
    @State private var score1 = HoleData(position: 0,amount: 0)
    @State private var score2 = HoleData(position: 0,amount: 0)
    @AppStorage("Score") private var Score = Data()
    @AppStorage("ScorePlayer1") private var ScorePlayer1 = Data()
    @AppStorage("ScorePlayer2") private var ScorePlayer2 = Data()
    @State private var score = ScoreData(total: 0, win: 0, lose: 0, draws: 0)
    @State private var Player1 = ScoreData(total: 0, win: 0, lose: 0, draws: 0)
    @State private var Player2 = ScoreData(total: 0, win: 0, lose: 0, draws: 0)
    @State private var turn1 = true
    @State private var turn2 = false
    @State private var color1 = Color.pink
    @State private var color2 = Color.gray
    @State var looper: AVPlayerLooper?
    @State private var song = "JustMe"
    @State private var sound = true
    @State private var volume = 0.8
    @State private var graphic = "background1"
    @State private var ShowSetting = false
    @State private var fileUrl = Bundle.main.url(forResource: "JustMe", withExtension: "mp3")!
    @State private var player = AVQueuePlayer()
    @State private var music1 = Color.pink
    @State private var music2 = Color.secondary
    @State private var music3 = Color.secondary
    @State private var sound1 = Color.pink
    @State private var sound2 = Color.secondary
    @State private var graphic1 = Color.pink
    @State private var graphic2 = Color.secondary
    @State private var graphic3 = Color.secondary
    @State private var ShowAlert = false
    @State private var ShowText = ""
    @Binding var ShowStatis : Bool
    @Binding var ShowPlayer : Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        Text("Player 2")
                            .font(.custom("Comics Deluxe", size: 20))
                            .foregroundColor(.white)
                    }.frame(width: geometry.size.width/5, height: geometry.size.width/16)
                    .onChange(of: turn2, perform: { value in
                        if value {
                            color2 = Color.pink
                        } else {
                            color2 = Color.gray
                        }
                    })
                    .onAppear{
                        fileUrl = Bundle.main.url(forResource: song, withExtension: "mp3")!
                        let item = AVPlayerItem(url: fileUrl)
                        self.looper = AVPlayerLooper(player: player , templateItem: item)
                        player.play()
                        player.volume = Float(volume)
                    }
                    .onChange(of: song, perform: { newValue in
                        player.removeAllItems()
                        fileUrl = Bundle.main.url(forResource: newValue, withExtension: "mp3")!
                        let item = AVPlayerItem(url: fileUrl)
                        self.looper = AVPlayerLooper(player: player , templateItem: item)
                        player.play()
                        player.volume = Float(volume)
                    })
                    .foregroundColor(color2)
                    .padding(.top)
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Text("\(score2.amount)")
                            .font(.custom("Comics Deluxe", size: 22))
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Gradient(colors: [.blue, .white]), lineWidth: 5)
                            .frame(width: geometry.size.width/10, height: geometry.size.width/5)
                            .shadow(radius: 5)
                            .padding(.trailing)
                            .overlay {
                                HoleView(data: score2)
                            }
                    }
                    
                    VStack{
                        HStack{
                            Spacer()
                            ForEach(player2,id: \.id) { data in
                                VStack(alignment: .trailing){
                                    Text("\(data.amount)")
                                        .font(.custom("Comics Deluxe", size: 22))
                                        .padding(.bottom,-2)
                                    Circle()
                                        .stroke(Gradient(colors: [.pink, .white]), lineWidth: 5)
                                        .frame(width: geometry.size.width/11, height: geometry.size.width/11)
                                        .shadow(radius: 5)
                                        .overlay{
                                            HoleView(data: data)
                                        }
                                        .onTapGesture {
                                            if turn2{
                                                Player2Tap(player1: &player1, player2: &player2, score1: &score1, score2: &score2, data: data, turn1: &turn1, turn2: &turn2)
                                                if Isend(player1: player1, player2: player2){
                                                    if score1.amount>score2.amount{
                                                        ShowText = "Player1 Win!! Congratulations"
                                                        Player1.total+=1
                                                        Player2.total+=1
                                                        Player1.win+=1
                                                        Player2.lose+=1
                                                    }
                                                    else if score2.amount>score1.amount{
                                                        ShowText = "Player2 Win!! Congratulations"
                                                        Player1.total+=1
                                                        Player2.total+=1
                                                        Player1.lose+=1
                                                        Player2.win+=1
                                                    }
                                                    else{
                                                        ShowText = "Draw!! Try again?"
                                                        Player1.total+=1
                                                        Player2.total+=1
                                                        Player1.draws+=1
                                                        Player2.draws+=1
                                                    }
                                                    saveScore()
                                                    ShowAlert = true
                                                }
                                                
                                            }
                                        }
                                        .alert(ShowText, isPresented: $ShowAlert) {
                                            Button("OK") { }
                                        }
                                }
                                Spacer()
                            }
                        }
                        HStack{
                            Spacer()
                            ForEach(player1,id: \.id) { data in
                                VStack(alignment: .leading){
                                    Circle()
                                        .stroke(Gradient(colors: [.white, .pink]), lineWidth: 5)
                                        .frame(width: geometry.size.width/11, height: geometry.size.width/11)
                                        .shadow(radius: 5)
                                        .overlay{
                                        HoleView(data: data)
                                    }
                                    .onTapGesture {
                                        if turn1{
                                            Player1Tap(player1: &player1, player2: &player2, score1: &score1, score2: &score2, data: data, turn1: &turn1, turn2: &turn2)
                                            if Isend(player1: player1, player2: player2){
                                                if score1.amount>score2.amount{
                                                    ShowText = "Player1 Win!! Congratulations"
                                                    Player1.total+=1
                                                    Player2.total+=1
                                                    Player1.win+=1
                                                    Player2.lose+=1
                                                }
                                                else if score2.amount>score1.amount{
                                                    ShowText = "Player2 Win!! Congratulations"
                                                    Player1.total+=1
                                                    Player2.total+=1
                                                    Player1.lose+=1
                                                    Player2.win+=1
                                                }
                                                else{
                                                    ShowText = "Draw!! Try again?"
                                                    Player1.total+=1
                                                    Player2.total+=1
                                                    Player1.draws+=1
                                                    Player2.draws+=1
                                                }
                                                saveScore()
                                                ShowAlert = true
                                            }

                                        }
                                    }
                                    .alert(ShowText, isPresented: $ShowAlert) {
                                        Button("OK") { }
                                    }
                                    Text("\(data.amount)")
                                        .font(.custom("Comics Deluxe", size: 22))
                                        .foregroundColor(.black)
                                        .padding(.bottom,-2)
                                }
                            }
                            Spacer()
                        }
                    }
                    VStack(alignment: .trailing){
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Gradient(colors: [.white, .blue]), lineWidth: 5)
                            .frame(width: geometry.size.width/10, height: geometry.size.width/5)
                            .shadow(radius: 5)
                            .padding(.leading)
                            .overlay {
                                HoleView(data: score1)
                            }
                        Text("\(score1.amount)")
                            .font(.custom("Comics Deluxe", size: 22))
                    }
                    Spacer()
                }.frame(width: geometry.size.width/1.1, height: geometry.size.width/3.5)
                    .padding()
                    .background(Image("checkerboard1").resizable().cornerRadius(20).opacity(0.5).shadow(radius: 5))
                
                
                
                
                HStack{
                    RoundedRectangle(cornerRadius: 10)
                        .overlay {
                            Text("Player 1")
                                .font(.custom("Comics Deluxe", size: 20))
                                .foregroundColor(.white)
                        }.frame(width: geometry.size.width/5, height: geometry.size.width/16)
                        .onChange(of: turn1, perform: { value in
                            if value {
                                color1 = Color.pink
                            } else {
                                color1 = Color.gray
                            }
                        })
                        .foregroundColor(color1)
                    Spacer()
                    Button {
                        ShowPlayer = false
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .overlay {
                                VStack{
                                    Image(systemName: "menucard")
                                        .font(.custom("Comics Deluxe", size: 20))
                                        .foregroundColor(.white)
                                    Text("Quit")
                                        .font(.custom("Comics Deluxe", size: 20))
                                        .foregroundColor(.white)
                                }
                                
                            }.foregroundColor(.orange)
                            .shadow(radius: 5)
                    }.frame(width: geometry.size.width/5, height: geometry.size.width/11)
                    Button {
                        ShowStatis = true
                        loadScore()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .overlay {
                                VStack{
                                    Image(systemName: "chart.line.uptrend.xyaxis")
                                        .font(.custom("Comics Deluxe", size: 20))
                                        .foregroundColor(.white)
                                    Text("Statistics")
                                        .font(.custom("Comics Deluxe", size: 20))
                                        .foregroundColor(.white)
                                }
                                
                            }.foregroundColor(.orange)
                            .shadow(radius: 5)
                    }.frame(width: geometry.size.width/5, height: geometry.size.width/11)
                        .sheet(isPresented: $ShowStatis) {
                            StatisiticsView(score: $score, Player1: $Player1, Player2: $Player2, ShowStatis: $ShowStatis)
                        }
                    Button {
                        ShowSetting = true
                    } label: {
                        RoundedRectangle(cornerRadius:20)
                            .overlay {
                                VStack{
                                    Image(systemName: "gear")
                                        .font(.custom("Comics Deluxe", size: 20))
                                        .foregroundColor(.white)
                                    Text("Setting")
                                        .font(.custom("Comics Deluxe", size: 20))
                                        .foregroundColor(.white)
                                }
                                
                            }.foregroundColor(.orange)
                            .shadow(radius: 5)
                    }.frame(width: geometry.size.width/5, height: geometry.size.width/11)
                        .sheet(isPresented: $ShowSetting) {
                            SettingPage(music1: $music1, music2: $music2, music3: $music3, sound1: $sound1, sound2: $sound2, graphic1: $graphic1, graphic2: $graphic2, graphic3: $graphic3, song: $song, sound: $sound, graphic: $graphic, volume: $volume, ShowSetting: $ShowSetting)
                        }
                    
                }
            }.padding(.leading,30)
                .background(Image(graphic).resizable().ignoresSafeArea().scaledToFill().frame(width: geometry.size.width, height: geometry.size.width))
                .onChange(of: graphic) { newValue in
                    Changebackground(newValue: newValue, player1: &player1, player2: &player2, score1: &score1, score2: &score2)
                }
        }
    }
    
    func saveScore(){
        do{
            Score = try JSONEncoder().encode(score)
            ScorePlayer1 = try JSONEncoder().encode(Player1)
            ScorePlayer2 = try JSONEncoder().encode(Player2)
        } catch {
            print(error)
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

func HoleView(data:HoleData) -> some View{
    ForEach(data.items,id:\.id){ item in
        Image(item.item)
            .resizable()
            .scaledToFit()
            .frame(width:40, height:40)
            .offset(item.offset)
            .rotationEffect(item.rotation)
    }
}

func Player1Tap(player1:inout [HoleData],player2:inout [HoleData],score1: inout HoleData,score2: inout HoleData,data:HoleData,turn1:inout Bool,turn2:inout Bool){
        let index1 = player1.firstIndex {
            $0.id == data.id
        }
        guard index1 != nil else {return}
        let step = data.amount
        var other = step - 6 + data.position
        var own = 0
        var LastStep = index1
        if other < 0{
            own = step
        }
        else{
            own = step - other
        }
        let item = data.items
        var ItemIndex = 0
        if own > 0{
            for i in 1...own{
                player1[(index1 ?? 0)!+i].amount+=1
                player1[(index1 ?? 0)!+i].items.append(item[ItemIndex])
                ItemIndex+=1
                LastStep = (index1 ?? 0)! + i
            }
        }
        if other > 0{
            score1.amount+=1
            score1.items.append(item[ItemIndex])
            ItemIndex+=1
            other-=1
            LastStep = 10
        }
        if other > 0{
            if other == 1{
                player2[5].amount+=1
                player2[5].items.append(item[ItemIndex])
                ItemIndex+=1
                other-=1
                LastStep = 5
            }
            else{
                var n = 6
                let go = other
                for i in 1...go-1{
                    if n==0{
                        break
                    }
                    player2[6-i].amount+=1
                    player2[6-i].items.append(item[ItemIndex])
                    ItemIndex+=1
                    other-=1
                    n-=1
                    LastStep = 6 - i
                }
            }
        }
        if other > 0{
            score2.amount+=1
            score2.items.append(item[ItemIndex])
            ItemIndex+=1
            other-=1
            LastStep = 20
        }
        if other > 0{
            if other == 1{
                player1[0].amount+=1
                player1[0].items.append(item[ItemIndex])
                ItemIndex+=1
                other-=1
                LastStep = 0
            }
            else{
                var n = 6
                let go = other
                for i in 0...go-2{
                    if n==0{
                        break
                    }
                    player1[i].amount+=1
                    player1[i].items.append(item[ItemIndex])
                    ItemIndex+=1
                    other-=1
                    n-=1
                    LastStep = i
                }
            }
        }
        if other > 0{
            score1.amount+=1
            score1.items.append(item[ItemIndex])
            ItemIndex+=1
            other-=1
            LastStep = 10
        }
        if other > 0{
            if other == 1{
                player2[5].amount+=1
                player2[5].items.append(item[ItemIndex])
                ItemIndex+=1
                other-=1
                LastStep = 5
            }
            else{
                var n = 6
                let go = other
                for i in 1...go-1{
                    if n==0{
                        break
                    }
                    player2[6-i].amount+=1
                    player2[6-i].items.append(item[ItemIndex])
                    ItemIndex+=1
                    other-=1
                    n-=1
                    LastStep = 6 - i
                }
            }
        }
        player1[(index1 ?? 0)!].amount=0
        player1[(index1 ?? 0)!].items.removeAll()
        if LastStep == 10{
            turn1=true
            turn2=false
        }
        else{
            if LastStep ?? 0 > -1 && LastStep ?? 0 < 6{
                if player1[LastStep ?? 0].amount==1{
                    score1.amount+=player1[LastStep ?? 0].amount
                    score1.amount+=1
                    player1[LastStep ?? 0].amount=0
                    player2[LastStep ?? 0].amount=0
                    player1[LastStep ?? 0].items.removeAll()
                    player2[LastStep ?? 0].items.removeAll()
                }
            }
            turn1=false
            turn2=true
        }
}

func Player2Tap(player1:inout [HoleData],player2:inout [HoleData],score1: inout HoleData,score2: inout HoleData,data:HoleData,turn1:inout Bool,turn2:inout Bool){
        let index = player2.firstIndex{
            $0.id == data.id
        }
        guard index != nil else {return}
        let step = data.amount
        var other = step - data.position + 1
        var own = 0
        var LastStep = index
        if other < 0{
            own = step
        }
        else{
            own = step - other
        }
        let item = data.items
        var ItemIndex = 0
        if own > 0{
            for i in 1...own{
                player2[(index ?? 0)! - i].amount+=1
                player2[(index ?? 0)! - i].items.append(item[ItemIndex])
                ItemIndex+=1
                LastStep = (index ?? 0)! - i
            }
        }
        if other > 0 {
            score2.amount+=1
            score2.items.append(item[ItemIndex])
            ItemIndex+=1
            other-=1
            LastStep = 20
        }
        if  other > 0 {
            if other == 1{
                player1[0].amount+=1
                player1[0].items.append(item[ItemIndex])
                ItemIndex+=1
                other-=1
                LastStep = 0
            }
            else{
                var n = 6
                let go = other
                for i in 0...go-2{
                    if n == 0{
                        break
                    }
                    player1[i].amount+=1
                    player1[i].items.append(item[ItemIndex])
                    ItemIndex+=1
                    other-=1
                    n-=1
                    LastStep = i
                }
            }
        }
        //round 2
        if other > 0 {
            score1.amount+=1
            score1.items.append(item[ItemIndex])
            ItemIndex+=1
            other-=1
            LastStep = 10
        }
        
        if  other > 0 {
            if other == 1{
                player2[5].amount+=1
                player2[5].items.append(item[ItemIndex])
                ItemIndex+=1
                other-=1
                LastStep = 5
            }
            else{
                var n = 6
                let go = other
                for i in 1...go-1{
                    if n == 0{
                        break
                    }
                    player2[6-i].amount+=1
                    player2[6-i].items.append(item[ItemIndex])
                    ItemIndex+=1
                    other-=1
                    n-=1
                    LastStep = 6 - i
                }
            }
        }
        if other > 0 {
            score2.amount+=1
            score2.items.append(item[ItemIndex])
            ItemIndex+=1
            other-=1
            LastStep = 20
        }
        if  other > 0 {
            if other == 1{
                player1[0].amount+=1
                player1[0].items.append(item[ItemIndex])
                ItemIndex+=1
                other-=1
                LastStep = 0
            }
            else{
                var n = 6
                let go = other
                for i in 0...go-2{
                    if n == 0{
                        break
                    }
                    player1[i].amount+=1
                    player1[i].items.append(item[ItemIndex])
                    ItemIndex+=1
                    other-=1
                    n-=1
                    LastStep = i
                }
            }
        }
        player2[(index ?? 0)!].amount=0
        player2[(index ?? 0)!].items.removeAll()
        if LastStep == 20{
            turn2=true
            turn1=false
        }
        else{
            if LastStep ?? 0 > -1 && LastStep ?? 0 < 6{
                if player2[LastStep ?? 0].amount==1{
                    score2.amount+=player1[LastStep ?? 0].amount
                    score2.amount+=1
                    player1[LastStep ?? 0].amount=0
                    player2[LastStep ?? 0].amount=0
                    player1[LastStep ?? 0].items.removeAll()
                    player2[LastStep ?? 0].items.removeAll()
                }
                
            }
            turn2=false
            turn1=true
        }
}

func Isend(player1:[HoleData],player2:[HoleData])-> Bool{
    var end1 = true
    var end2 = true
    for hole in player1{
        if hole.amount != 0 {
            end1 = false
        }
    }
    for hole in player2{
        if hole.amount != 0 {
            end2 = false
        }
    }
    if end1 || end2 {
        return true
    }
    return false
}

func Changebackground(newValue:String,player1:inout [HoleData],player2:inout [HoleData],score1:inout HoleData,score2:inout HoleData){
        var dices = ["","","",""]
        if newValue == "background1" {
            dices = ["peral1","peral2","peral3","peral4","peral5","peral6","peral7","peral8"]
        }
        if newValue == "background2" {
            dices = ["veg1","veg2","veg3","veg4","veg5","veg6","veg7","veg8"]
        }
        if newValue == "background3" {
            dices = ["flower1","flower2","flower3","flower4","flower5","flower6","flower7","flower8"]
        }
//        for data in player1 {
//            let index = player1.firstIndex{
//                $0.id == data.id
//            }
//            guard index != nil else {return}
//            player1[index ?? 0].items.removeAll()
//            while player1[index ?? 0].items.count != data.amount {
//                let dice = dices.randomElement()!
//                player1[index ?? 0].items.append(ItemsData(id:UUID(),item: dice))
//            }
//        }
//        for data in player2 {
//            let index = player2.firstIndex{
//                $0.id == data.id
//            }
//            guard index != nil else {return}
//            player2[index ?? 0].items.removeAll()
//            while player2[index ?? 0].items.count != data.amount {
//                let dice = dices.randomElement()!
//                player1[index ?? 0].items.append(ItemsData(id:UUID(),item: dice))
//            }
//        }
        score1.items.removeAll()
        score2.items.removeAll()
        while score1.items.count != score1.amount{
            let dice = dices.randomElement()!
            score1.items.append(ItemsData(id:UUID(),item: dice))
        }
        while score2.items.count != score2.amount{
            let dice = dices.randomElement()!
            score2.items.append(ItemsData(id:UUID(),item: dice))
        }
}
//struct PlayersGamePage_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayersGamePage()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
