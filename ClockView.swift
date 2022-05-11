//
//  ClockView.swift
//  AlarmApp
//
//  Created by VB on 11.05.2022.
//

import SwiftUI
import UserNotifications
struct ClockView: View {
    @State var starTime = false
    @State var going : CGFloat = 1
    @State var count = 0
    @State var time = Timer.publish(every:1, on: .main, in: .common ).autoconnect()
    var body: some View {
        ZStack{
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09),style: StrokeStyle(lineWidth:35, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: self.going)
                        .stroke(Color("CircleColor").opacity(1),style: StrokeStyle(lineWidth:35, lineCap: .round))
                }.frame(width: 350, height: 350)
                    .rotationEffect(.init(degrees: -90))
                
                VStack{
                    Text("\(self.count)")
                        .font(.system(size: 60))
                        .bold()
                    Text("Kalan Dakika :\(25 - self.count)")
                        .font(.system(size: 30))
                }
                HStack(spacing:20){
                    Button {
                        if self.count == 30{
                            self.count = 0
                            withAnimation(.default){
                                self.going = 0
                            }
                        }
                        self.starTime.toggle()
                    } label: {
                        HStack(spacing:15){
                            Image(systemName:self.starTime ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                            Text(self.starTime ? "Pause" : "Start")
                                .foregroundColor(.white)
                        }.padding(.vertical)
                            .frame(width:(UIScreen.main.bounds.width / 2) - 55)
                            .background(Color.purple)
                            .clipShape(Capsule())
                            .shadow(radius: 6)
                    }
                    Button {
                        self.count = 0
                        withAnimation(.default){
                            self.going = 0
                        }
                    } label: {
                        HStack(spacing:15){
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.purple)
                            Text("Restart")
                                .foregroundColor(.purple)
                        }.padding(.vertical)
                            .frame(width:(UIScreen.main.bounds.width / 2) - 55)
                            .background(Capsule()
                                            .stroke(Color.purple,lineWidth: 2))
                    }
                }
                //.padding(.top,55)
                .onAppear(perform: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_,_) in
                    }
                })
                .onReceive(self.time) { (_) in
                    if self.starTime{
                        if self.count != 25{
                            self.count += 1
                            print("sa")
                            withAnimation(.default) {
                                self.going = CGFloat(self.count) / 25
                            }
                        }
                        else{
                            self.starTime.toggle()
                        }
                    }
                }
            }
        }
    }
}
    struct ClockView_Previews: PreviewProvider {
        static var previews: some View {
            ClockView()
            
        }
}
/* func Notify(){
 let content = UNMutableNotificationContent
 content.title = "MEssage"
 content.body = "Timer IS Complate"
 
 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
 
 let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: req)
 UNUserNotificationCenter.current().add(req,withCompletionHandler: nil)*/
