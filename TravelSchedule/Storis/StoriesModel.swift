import Foundation
import SwiftUI

struct StoriesModel: Identifiable, Hashable {
    let id = UUID()
    let storyName: String
    let title: String
    let description: String
    let imageName: [String]
    
    static let history1: [StoriesModel] = [
        StoriesModel(storyName: "firstStory", title: "", description: "", imageName: ["firstStory"]),
        StoriesModel(storyName: "secondStory", title: "", description: "", imageName: ["secondStory"])
    ]
    static let history2: [StoriesModel] = [
        StoriesModel(storyName: "thirdStory", title: "", description: "", imageName: ["thirdStory"]),
        StoriesModel(storyName: "fourthStory", title: "", description: "", imageName: ["fourthStory"]),
    ]
    static let history3: [StoriesModel] = [
        StoriesModel(storyName: "fifthStory", title: "", description: "", imageName: ["fifthStory"]),
        StoriesModel(storyName: "sixthStory", title: "", description: "", imageName: ["sixthStory"])
    ]
    static let history4: [StoriesModel] = [
        StoriesModel(storyName: "seventhStory", title: "", description: "", imageName: ["seventhStory"]),
        StoriesModel(storyName: "eightStory", title: "", description: "", imageName: ["eightStory"])
    ]
    static let history5: [StoriesModel] = [
        StoriesModel(storyName: "ninthStory", title: "", description: "", imageName: ["ninthStory"]),
        StoriesModel(storyName: "tenthStory", title: "", description: "", imageName: ["tenthStory"])
    ]
    static let history6: [StoriesModel] = [
        StoriesModel(storyName: "elevenStory", title: "", description: "", imageName: ["elevenStory"]),
        StoriesModel(storyName: "twelveStory", title: "", description: "", imageName: ["twelveStory"])
    ]
    static let history7: [StoriesModel] = [
        StoriesModel(storyName: "thirteenStory", title: "", description: "", imageName: ["thirteenStory"]),
        StoriesModel(storyName: "fourteenStory", title: "", description: "", imageName: ["fourteenStory"])
    ]
    static let history8: [StoriesModel] = [
        StoriesModel(storyName: "fifteenStory", title: "", description: "", imageName: ["fifteenStory"]),
        StoriesModel(storyName: "sixteenStory", title: "", description: "", imageName: ["sixteenStory"])
    ]
    static let history9: [StoriesModel] = [
        StoriesModel(storyName: "seventeenStory", title: "", description: "", imageName: ["seventeenStory"]),
        StoriesModel(storyName: "eighteenStory", title: "", description: "", imageName: ["eighteenStory"])
    ]
}
