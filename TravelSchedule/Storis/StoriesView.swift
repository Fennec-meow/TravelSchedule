//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Kira on 04.08.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    let stories: [StoriesModel]
    let onViewed: (Set<Int>) -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var timer: Timer.TimerPublisher
    @State private var selection: Int
    @State private var currentImageIndex: Int = 0
    @State private var progress: CGFloat = 0
    @State private var timerCancellable: Cancellable?
    @State private var localViewedStories: Set<Int> = []
    
    @State private var storyGap: CGFloat = .zero
    
    private let configuration: TimerConfiguration
    
    init(onViewed: @escaping (Set<Int>) -> Void, stories: [StoriesModel], initialIndex: Int) {
        self.onViewed = onViewed
        self.stories = stories
        storyGap = 1.0/CGFloat(stories.count)
        _selection = State(initialValue: initialIndex)
        configuration = TimerConfiguration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var currentStory: StoriesModel? {
        guard !stories.isEmpty else { return nil }
        return stories[selection]
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let story = currentStory {
                GeometryReader { geo in
                    ZStack {
                        // Изображение с закругленными углами
                        Image(stories[selection].imageName[currentImageIndex])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .clipped()
                        
                        // Прогрессбар сверху
                        VStack {
                            ProgressBar(
                                numberOfSections: stories.count,
                                progress: $progress
                            )
                                .padding(.top, 40)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        
                        // Области для тапов
                        HStack(spacing: 0) {
                            // Левая зона — назад
                            Color.clear
                                .contentShape(Rectangle())
                                .frame(width: geo.size.width / 2, height: geo.size.height)
                                .onTapGesture {
                                    if currentImageIndex > 0 {
                                        currentImageIndex -= 1
                                    } else {
                                        // Переход к предыдущей истории, если есть
                                        if selection > 0 {
                                            selection -= 1
                                            currentImageIndex = stories[selection].imageName.count - 1
                                        }
                                    }
                                    progress = 0
                                    restartTimer()
                                }
                            
                            // Правая зона — вперед
                            Color.clear
                                .contentShape(Rectangle())
                                .frame(width: geo.size.width / 2, height: geo.size.height)
                                .onTapGesture {
                                    if currentImageIndex < stories[selection].imageName.count - 1 {
                                        currentImageIndex += 1
                                    } else {
                                        goToNextStory()
                                    }
//                                    progress = 0
                                    restartTimer()
                                }
                        }
                        // Кнопка закрытия
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(.close)
//                                      .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.blackUni)
                                        .padding(.top,57)
                                        .padding(.trailing, 12)
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            localViewedStories.insert(selection)
            timer = Self.createTimer(configuration: configuration)
            timerCancellable = timer.connect()
        }
        .onDisappear {
            timerCancellable?.cancel()
            onViewed(localViewedStories)
        }
        .onReceive(timer) { _ in
            startTimer()
        }
    }
    
    // Таймер
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
    
    private func startTimer() {
        let nextProgress = (progress + configuration.progressPerTick)
        if nextProgress >= storyGap {
            goToNextStory()
            storyGap += 1.0/CGFloat(stories.count)
        }
        progress = nextProgress
    }
    
    private func restartTimer() {
        timerCancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        timerCancellable = timer.connect()
    }
    
    private func goToNextStory() {
        if selection < stories.count - 1 {
            selection += 1
            progress += 1
        } else {
            onViewed(localViewedStories)
            dismiss()
        }
        restartTimer()
    }
}

#Preview {
    let viewModel = StoriesViewModel()
    StoriesView(onViewed: { _ in }, stories: viewModel.storiesGroups.first ?? [], initialIndex: 0)
}
