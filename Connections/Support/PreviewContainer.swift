//
//  PreviewContainer.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import Foundation
import SwiftData
import SwiftUI

struct PreviewContainer: PreviewModifier {
    typealias Context = ModelContainer
    
    static func makeSharedContext() async throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContianer = try ModelContainer(for: CachedUser.self, configurations: config)
        
        return modelContianer
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var previewContainer: Self = .modifier(PreviewContainer())
}
