//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by sigil wen on 2020-11-30.
//

import SwiftUI

struct CoursesView: View {
    @State var show = false //hides default with a state
    @Namespace var namespace
    @State var selectedItem: Course? = nil
    @State var isDisabled = false //used to ensure selection
    @Namespace var namespace2
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    var body: some View {
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                tabBar
            }else {
                sidebar
            }
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            #else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            #endif
        }
        .navigationTitle("Courses")
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0){
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                    spacing: 16
                ) { //adaptive lazygrid that sets column with minimum
                    //can use fixed() instead and add multiple GridItems
                    // columns: GridItem(.adaptive(minimum: 160), spacing: 16)
                    //Array(repeating: .init(.flexible(), spacing 16), count: 3)
                    //can change to HGrid --> rows, change scrollview(.horizontal)
                    ForEach(courses) { item in
                        VStack {
                            Courseitem(course: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                .frame(height: 200)
                                .onTapGesture{
                                    withAnimation(.spring()){
                                        show.toggle()
                                        selectedItem = item
                                        isDisabled = true
                                    } //chaning animation pace
                                }
                                .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                
                Text("Latest Sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))]) {
                    ForEach(courseSections) { item in
                        #if os(iOS)
                        NavigationLink(destination: CourseDetail(namespace: namespace2)) {
                            CourseRow(item: item)
                        }
                        #else
                        CourseRow(item: item)
                        #endif
                    }
                }.padding()
            }
            
        }
        .zIndex(1)
        .navigationTitle("Courses")
    }
    
    @ViewBuilder
    var fullContent: some View {
        if selectedItem != nil {
         //fullscreen
            ZStack (alignment: .topTrailing) {
                CourseDetail(course: selectedItem!, namespace: namespace)
                
                CloseButton()
                    .padding(16)
                    .onTapGesture{
                        withAnimation(.spring(response:0.5, dampingFraction: 0.7, blendDuration: 0)){
                            show.toggle()
                            selectedItem = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                isDisabled = false
                            }
                        } //chaning animation pace
                    } //makes sure content is above other cards
            }.zIndex(2.0)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
            
        }
    }
    
    
    var tabBar: some View {
        TabView {
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Tutorials")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Livestreams")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "mail.stack")
                Text("Certificates")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
    var sidebar: some View {
        VStack{
        List {
            NavigationLink(destination: CoursesView()) {
                Label("Courses", systemImage: "book.closed")
            }
            Label("Tutorials", systemImage: "list.bullet.rectangle")
                Label("Livestreams", systemImage: "tv")
            Label("Certificates", systemImage: "mail.stack")
            Label("Search", systemImage: "magnifyingglass")
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Learn")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Image(systemName: "person.crop.circle")
            }
        }
            content
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
