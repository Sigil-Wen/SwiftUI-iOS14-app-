//
//  LibraryContent.swift
//  DesignCodeCourse
//
//  Created by sigil wen on 2020-12-01.
//

import SwiftUI

struct LibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(CloseButton(),
                    title: "Close Button View",
                    category: .control)
        LibraryItem(CloseButton(),
                    title: "Close Button 2",
                    category: .control)
    }
    
    @LibraryContentBuilder
    func modifiers(base: Image) -> [LibraryItem] {
        LibraryItem(
            base.cardStyle(color: Color.blue, cornerRadius: 22),
            title: "Card Style",
            category: .effect
        
        )
    }

}

//reusable modifier
extension View {
    func cardStyle(color: Color, cornerRadius: CGFloat) -> some View{
    return self
    .background(color)
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    .shadow(color: color.opacity(0.3), radius: 20, x:0, y:10)
    }
}
