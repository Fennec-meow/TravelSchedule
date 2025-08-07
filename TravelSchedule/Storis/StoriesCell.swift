//
//  StoriesCell.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import SwiftUI

// MARK: - StoriesCell

struct StoriesCell: View {
    var stories: [StoriesModel]
    let storiesHeight: Double = 140
    let storiesWidth: Double = 92
    
    var body: some View {
        NavigationLink(destination: StoriesView(onViewed: { _ in }, stories: stories, initialIndex: 0)) {
            ZStack {
                if let firstStory = stories.first, let imageName = firstStory.imageName.first {
                    Image(imageName)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(width: storiesWidth, height: storiesHeight)
                } else {
                    // Заглушка, если изображение отсутствует
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray)
                        .frame(width: storiesWidth, height: storiesHeight)
                }
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.blue, lineWidth: 4)
                    .frame(width: storiesWidth, height: storiesHeight)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // Предположим, что у вас есть функция, которая возвращает группу историй для этой истории
    func storyGroup(for story: StoriesModel) -> [StoriesModel] {
        
        // Например, возвращаете все истории или одну группу
        // В вашем случае, можно передавать конкретную группу
        // Для примера, возвращаю одну историю
        return [story]
    }
}

#Preview {
    StoriesCell(stories: [.init(
        storyName: "firstStory",
        title: "First Story",
        description: "This is first stories",
        imageName: ["firstStory"]
    )]
    )
}
