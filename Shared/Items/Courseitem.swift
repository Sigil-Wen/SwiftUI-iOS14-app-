//
//  Courseitem.swift
//  DesignCodeCourse
//
//  Created by sigil wen on 2020-11-30.
//

import SwiftUI

struct Courseitem: View {
    var course: Course = courses[0]
    #if os(iOS)
    var cornerRadius: CGFloat = 22
    #else
    var cornerRadius: CGFloat = 10
    #endif
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Spacer()
            HStack {
                HStack {
                    Spacer()
                    Image(course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                
            }
            Text(course.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                
            Text(course.subtitle)
                .font(.footnote)
                .foregroundColor(Color.white)
                
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .cardStyle(color: Color.blue, cornerRadius: 22)
    }
}

struct Courseitem_Previews: PreviewProvider {
    static var previews: some View {
        Courseitem()
    }
}
