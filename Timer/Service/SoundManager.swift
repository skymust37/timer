//
//  SoundManager.swift
//  Timer
//
//  Created by 김승현 on 8/15/24.
//

import AVKit

class SoundManager {
//    static let instance = SoundManager()
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
        player?.stop()
        }
}
