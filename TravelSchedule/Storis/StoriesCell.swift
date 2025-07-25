//
//  StoriesCell.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import SwiftUI

// MARK: - StoriesCell

struct StoriesCell: View {
    
    // MARK: Public Property

    var story: StoriesModel
    let storiesHeight: Double = 140
    let storiesWidth: Double = 92
    
    // MARK: body

    var body: some View {
        ZStack {
            Image(story.storyName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: storiesWidth, height: storiesHeight)
               
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.blueUni, lineWidth: 4)
                .frame(width: storiesWidth, height: storiesHeight)
        }
    }
}

#Preview {
    let stories = StoriesModel(storyName: "firstStory")
    return StoriesCell(story: stories)
        .padding()
        .background(.background)
}
