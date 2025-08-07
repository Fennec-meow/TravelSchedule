//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Kira on 04.08.2025.
//

import Foundation

struct TimerConfiguration {
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.05
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / secondsPerStory * timerTickInternal
    }
}
