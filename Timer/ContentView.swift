//
//  ContentView.swift
//  Timer
//
//  Created by 김승현 on 7/16/24.
//
/*
import SwiftUI
import Combine
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "relaxing-electronic-music-free", withExtension: ".mp3") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
            
        }
    }
    func stopSound() {
        // Stop AVAudioPlayer
        player?.stop()
        }
}

struct ContentView: View {
    let date = Date();
    @State var timeRemaining : Int = 100
    @State var timerRunning = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView {
            VStack(spacing:20) {
                Button("시작") {
                    SoundManager.instance.playSound()
                }
                
                Button("중지") {
                    SoundManager.instance.stopSound()
                }
            }
                .tabItem {
                    Image(systemName: "alarm")
                    Text("알람")
                }
        }
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds - hours*3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
    
    func calcRemain() {
        let calendar = Calendar.current
        let targetTime : Date = calendar.date(byAdding: .second, value: 10 , to: date, wrappingComponents: false) ?? Date()
        let remainSeconds = Int(targetTime.timeIntervalSince(date))
        self.timeRemaining = remainSeconds
    }
}

#Preview {
    ContentView()
}
*/
