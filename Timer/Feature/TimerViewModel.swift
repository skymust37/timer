//
//  TimerViewModel.swift
//  Timer
//
//  Created by 김승현 on 8/10/24.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var isDisplaySetTimeView: Bool
    @Published var time: Time
    @Published var timer: Timer?
    @Published var timeRemaining: Int
    @Published var isPaused: Bool
    var notificationService: NotificationService
    var soundManager: SoundManager
    
    init(
        isDisplaySetTimeView: Bool = true,
        time: Time = .init(hours: 0, minutes: 0, seconds: 0),
        timer: Timer? = nil,
        timeRemaining: Int = 0,
        isPaused: Bool = false,
        notificationService: NotificationService = .init(),
        soundManager: SoundManager = .init()
    ) {
        self.isDisplaySetTimeView = isDisplaySetTimeView
        self.time = time
        self.timer = timer
        self.timeRemaining = timeRemaining
        self.isPaused = isPaused
        self.notificationService = notificationService
        self.soundManager = soundManager
    }
}

extension TimerViewModel {
    func settingBtnTapped() {
        isDisplaySetTimeView = false
        timeRemaining = time.convertedSeconds
        startTimer()
    }
    
    func cancleBtnTapped() {
        onlyStopTimer()
        isDisplaySetTimeView = true
    }
    
    func pauseOrRestartBtnTapped() {
        if isPaused {
            startTimer()
        } else {
            onlyStopTimer()
        }
        isPaused.toggle()
    }
    
    func stopTimerAndStopSound() { //타이머 종료후 중지 버튼 눌렀을 때
        self.soundManager.stopSound()
        timer?.invalidate()
        timer = nil
    }
}

private extension TimerViewModel {
    func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.onlyStopTimer()
                self.soundManager.playSound()
                self.notificationService.sendNotification()
            }
        }
    }
    
    func onlyStopTimer() { //취소, 일시정지
        timer?.invalidate()
        timer = nil
    }
}
