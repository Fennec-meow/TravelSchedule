import SwiftUI

// MARK: - StoriesCell

struct StoriesCell: View {
    var stories: [StoriesModel]
    @State private var viewedStories: Set<Int> = []
    @Binding var isViewed: Bool
    let storiesHeight: Double = 140
    let storiesWidth: Double = 92
    
    var body: some View {
        NavigationLink(destination: StoriesView(
            onViewed: { viewedIndices in
                viewedStories.formUnion(viewedIndices)
            },
            stories: stories,
            initialIndex: 0,
            isViewed: $isViewed
        )) {
            ZStack {
                if let firstStory = stories.first, let imageName = firstStory.imageName.first {
                    Image(imageName)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(width: storiesWidth, height: storiesHeight)
                        .opacity(viewedStories.contains(0) ? 0.5 : 1.0) // яркость зависит от просмотра
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray)
                        .frame(width: storiesWidth, height: storiesHeight)
                        .opacity(viewedStories.contains(0) ? 0.5 : 1.0)
                }
                
                // Обводка: показывать, если история НЕ просмотрена
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(viewedStories.contains(0) ? Color.clear : .blue, lineWidth: 4)
                    .animation(.easeInOut, value: viewedStories)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func storyGroup(for story: StoriesModel) -> [StoriesModel] {
        return [story]
    }
}
