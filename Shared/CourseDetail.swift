//
//  CourseDetail.swift
//  DesignCodeCourse
//
//  Created by sigil wen on 2020-11-30.
//

import SwiftUI

struct CourseDetail: View {
    var course: Course = courses[0]
    var namespace: Namespace.ID
    #if os(iOS)
    var cornerRadius: CGFloat = 10
    #else
    var cornerRadius: CGFloat = 0
    #endif
    @State var showModal = false
    
    var body: some View {
        #if os(iOS)
        content
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        #else
        #endif
    }
    
    var content: some View {
        VStack {
            ScrollView {
                Courseitem(course: course, cornerRadius: 0)//not gonna be empty
                    .matchedGeometryEffect(id: course.id, in: namespace) //matching geometry
                    .frame(height: 300)
            
            VStack { //list
                ForEach(courseSections) { item in
                    CourseRow(item: item)
                        .sheet(isPresented: $showModal){
                            CourseSectionDetail()
                                
                        }
                        .onTapGesture{
                            showModal = true
                        }
                    Divider()
                }
            }.padding()
        }
        
    }
    .background(Color("Background 1"))
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    .matchedGeometryEffect(id: "container\(course.id)", in: namespace)
        //matching geometry
   /*.transition(
    .asymmetric(
    insertion:  AnyTransition.opacity.animation(Animation.spring().delay(0.3)),
    removal: AnyTransition
    .opacity
    .animation(.spring()))
    )*/
   //different types of animations
   //asymmetric
    }
}

struct CourseDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseDetail(namespace: namespace)
    }
}
