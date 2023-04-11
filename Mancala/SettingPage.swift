//
//  SettingPage.swift
//  Mancala
//
//  Created by Abby on 2023/4/7.
//

import SwiftUI

struct SettingPage: View {
    @Binding var music1 : Color
    @Binding var music2 : Color
    @Binding var music3 : Color
    @Binding var sound1 : Color
    @Binding var sound2 : Color
    @Binding var graphic1 : Color
    @Binding var graphic2 : Color
    @Binding var graphic3 : Color
    @Binding var song : String
    @Binding var sound : Bool
    @Binding var graphic : String
    @Binding var volume : Double
    @Binding var ShowSetting :Bool
    var body: some View {
        GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Button {
                        ShowSetting = false
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
                                        Text("SETTING")
                                            .font(.custom("Comics Deluxe", size: 30))
                                            .foregroundColor(.black)
                                            .padding(.top)
                                        RoundedRectangle(cornerRadius: 25)
                                            .frame(width: geometry.size.width/1.3, height: geometry.size.height/1.4)
                                            .foregroundColor(.gray)
                                            .opacity(0.9)
                                            .padding(.bottom,30)
                                            .overlay {
                                                VStack(alignment: .leading){
                                                    HStack{
                                                        Text("Music")
                                                            .font(.custom("Comics Deluxe", size: 25))
                                                            .foregroundColor(.white)
                                                            .padding(.trailing,30)
                                                        Button {
                                                            music1 = Color.pink
                                                            music2 = Color.secondary
                                                            music3 = Color.secondary
                                                            song = "JustMe"
                                                            volume = 0.8
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(music1)
                                                                    .frame(width: geometry.size.width/6, height: geometry.size.height/5.7)
                                                                Text("1")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                        Button {
                                                            music1 = Color.secondary
                                                            music2 = Color.pink
                                                            music3 = Color.secondary
                                                            song = "sea"
                                                            volume = 1.5
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(music2)
                                                                    .frame(width: geometry.size.width/6, height: geometry.size.height/5.7)
                                                                Text("2")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                        Button {
                                                            music1 = Color.secondary
                                                            music2 = Color.secondary
                                                            music3 = Color.pink
                                                            song = "ice cream"
                                                            volume = 0.0
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(music3)
                                                                    .frame(width: geometry.size.width/6, height: geometry.size.height/5.7)
                                                                Text("OFF")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }


                                                    }
                                                    
                                                    HStack{
                                                        Text("Sound Effect")
                                                            .font(.custom("Comics Deluxe", size: 25))
                                                            .foregroundColor(.white)
                                                            .padding(.trailing,30)
                                                        Button {
                                                            sound1 = Color.pink
                                                            sound2 = Color.secondary
                                                            sound = true
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(sound1)
                                                                    .frame(width: geometry.size.width/6, height: geometry.size.height/5.7)
                                                                Text("ON")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                        Button {
                                                            sound1 = Color.secondary
                                                            sound2 = Color.pink
                                                            sound = false
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(sound2)
                                                                    .frame(width: geometry.size.width/6, height: geometry.size.height/5.7)
                                                                Text("OFF")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                    }
                                                    
                                                    HStack{
                                                        Text("Graphics")
                                                            .font(.custom("Comics Deluxe", size: 25))
                                                            .foregroundColor(.white)
                                                            .padding(.trailing,30)
                                                        Button {
                                                            graphic1 = Color.pink
                                                            graphic2 = Color.secondary
                                                            graphic3 = Color.secondary
                                                            graphic = "background1"
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(graphic1)
                                                                    .frame(width: geometry.size.width/6.4, height: geometry.size.height/5.7)
                                                                Text("1")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                        Button {
                                                            graphic1 = Color.secondary
                                                            graphic2 = Color.pink
                                                            graphic3 = Color.secondary
                                                            graphic = "background2"
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(graphic2)
                                                                    .frame(width: geometry.size.width/6.4, height: geometry.size.height/5.7)
                                                                Text("2")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                        Button {
                                                            graphic1 = Color.secondary
                                                            graphic2 = Color.secondary
                                                            graphic3 = Color.pink
                                                            graphic = "background3"
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 25)
                                                                    .foregroundColor(graphic3)
                                                                    .frame(width: geometry.size.width/6.4, height: geometry.size.height/5.7)
                                                                Text("3")
                                                                    .font(.custom("Comics Deluxe", size: 25))
                                                                    .foregroundColor(.white)
                                                            }
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

//struct SettingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingPage()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
