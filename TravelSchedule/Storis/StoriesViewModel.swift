//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import Foundation
import Combine

class StoriesViewModel: ObservableObject {
    @Published var storiesGroups: [[StoriesModel]] = [
        StoriesModel.history1,
        StoriesModel.history2,
        StoriesModel.history3,
        StoriesModel.history4,
        StoriesModel.history5,
        StoriesModel.history6,
        StoriesModel.history7,
        StoriesModel.history8,
        StoriesModel.history9
    ]
    
    @Published var currentGroupIndex: Int = 0
    
    var currentStories: [StoriesModel] {
        storiesGroups[currentGroupIndex]
    }
    
    func nextGroup() {
        currentGroupIndex = (currentGroupIndex + 1) % storiesGroups.count
    }
}
