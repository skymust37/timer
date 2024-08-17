//
//  TimerView.swift
//  Timer
//
//  Created by 김승현 on 8/11/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timerViewModel = TimerViewModel()
    @State private var selectedTab = 1  // 현재 선택된 탭 인덱스를 저장
    
    var body: some View {
        TabView(selection: $selectedTab){
                CalendarView()
                    .modifier(TabItemModifier(imageName: "calendar", title: "Calendar"))
                    .tag(1)
            if timerViewModel.isDisplaySetTimeView {
                SetTimerView(timerViewModel: timerViewModel)
                    .modifier(TabItemModifier(imageName: "timer", title: "Timer"))
                    .tag(2)
            } else {
                TimerOperationView(timerViewModel: timerViewModel)
                    .modifier(TabItemModifier(imageName: "timer", title: "Timer"))
                    .tag(2)
            }
        }
    }
}

// MARK: - 탭 아이템 리팩토링
private struct TabItemModifier: ViewModifier {
    var imageName: String
    var title: String
    
    func body(content: Content) -> some View {
        content
            .tabItem {
                Image(systemName: imageName)
                Text(title)
            }
    }
}

// MARK: - 캘린더 뷰
private struct CalendarView: View {
    @State private var date = Date()

    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.hourAndMinute, .date]
        )
        .datePickerStyle(.graphical)
    }
}

// MARK: - 타이머 설정 뷰
private struct SetTimerView: View {
    @ObservedObject private var timerViewModel = TimerViewModel()
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            TitleView()
            
            Spacer()
                .frame(height: 50)
            
            TimePickerView(timerViewModel: timerViewModel)
            
            Spacer()
                .frame(height: 50)
            
            TimerCreateBtnView(timerViewModel: timerViewModel)
            
            Spacer()
        }
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("타이머")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
}

// MARK: - 타이머 설정 뷰
private struct TimePickerView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
      
      fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
      }
    
    fileprivate var body: some View {
        VStack{
            Rectangle()
                .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                .frame(height: 1)
            HStack{
                Picker("Hour", selection: $timerViewModel.time.hours) {
                    ForEach(0..<24) { hour in
                        Text("\(hour)시")
                        
                    }
                }
                
                Picker("Minute", selection: $timerViewModel.time.minutes) {
                    ForEach(0..<60) { minute in
                        Text("\(minute)분")
                    }
                }
                        
                Picker("Second", selection: $timerViewModel.time.seconds) {
                    ForEach(0..<60) { second in
                        Text("\(second)초")
                    }
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            
            Rectangle()
                .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                .frame(height: 1)
        }
    }
}

// MARK: - 타이머 생성 버튼 뷰
private struct TimerCreateBtnView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        Button(
            action: {
                timerViewModel.settingBtnTapped()
            },
            label: {
                Text("설정하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.81, blue: 0.47))
            }
        )
    }
}

// MARK: - 타이머 작동 뷰
private struct TimerOperationView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
  
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
  
    fileprivate var body: some View {
        VStack{
            ZStack{
                VStack{
                    Text("\(timerViewModel.timeRemaining.formattedTimeString)")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                        .monospaced()
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: "bell.fill")
                        
                        Text("\(timerViewModel.time.convertedSeconds.formattedSettingTime)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                }
                
                Circle()
                    .stroke(Color(red: 1, green: 0.75, blue: 0.52), lineWidth: 6)
                    .frame(width: 350)
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack{
                Button(
                    action: {
                        timerViewModel.cancleBtnTapped()
                    },
                    label: {
                        Text("취소")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .padding(.vertical, 25)
                            .padding(.horizontal, 22)
                            .background(
                                Circle()
                                    .fill(Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.3))
                            )
                    }
                )
                
                Spacer()
                
                continueAndPauseButton (
                    title: timerViewModel.isPaused ? "계속진행" : "일시정지",
                    action: { timerViewModel.pauseOrRestartBtnTapped() },
                    backgroundColor: Color(red: 1, green: 0.75, blue: 0.52).opacity(0.3),
                    isEnabled: timerViewModel.timeRemaining > 0
                )
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - 일시정지 계속진행 리팩토링
private struct continueAndPauseButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color
    var isEnabled: Bool = true

    var body: some View {
        Button(
            action: action,
            label: {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(.vertical, 25)
                    .padding(.horizontal, 7)
                    .background(
                        Circle()
                            .fill(backgroundColor)
                    )
                    .opacity(isEnabled ? 1.0:0.3)
            }
        )
        .disabled(!isEnabled)
    }
}
