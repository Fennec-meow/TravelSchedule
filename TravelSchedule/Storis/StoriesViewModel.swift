//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import Foundation

// MARK: - StoriesViewModel

@Observable final class StoriesViewModel: ObservableObject {
    
    // MARK: Public Property
    
    let stories: [StoriesModel]
    
    init() {
        let story1 = StoriesModel(storyName: "firstStory")
        let story2 = StoriesModel(storyName: "secondStory")
        let story3 = StoriesModel(storyName: "thirdStory")
        let story4 = StoriesModel(storyName: "fourthStory")
        let story5 = StoriesModel(storyName: "fifthStory")
        let story6 = StoriesModel(storyName: "sixthStory")
        let story7 = StoriesModel(storyName: "seventhStory")
        let story8 = StoriesModel(storyName: "eightStory")
        let story9 = StoriesModel(storyName: "ninthStory")
        let story10 = StoriesModel(storyName: "tenthStory")
        let story11 = StoriesModel(storyName: "elevenStory")
        let story12 = StoriesModel(storyName: "twelveStory")
        let story13 = StoriesModel(storyName: "thirteenStory")
        let story14 = StoriesModel(storyName: "fourteenStory")
        let story15 = StoriesModel(storyName: "fifteenStory")
        let story16 = StoriesModel(storyName: "sixteenStory")
        let story17 = StoriesModel(storyName: "seventeenStory")
        let story18 = StoriesModel(storyName: "eighteenStory")
        
        self.stories = [
            story1, story2, story3, story4, story5, story6,
            story7, story8, story9, story10, story11, story12,
            story13, story14, story15, story16, story17, story18
        ]
    }
}
