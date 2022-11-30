//
//  ContentView.swift
//  Todo App
//
//  Created by Pusiewicz, M. (Mateusz) on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
    //MARK - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])
    var todos: FetchedResults<Todo>
    @State private var showingSettingsView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    //MARK  - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) {  todo in
                       HStack {
                           Circle()
                               .frame(width: 10, height: 10, alignment: .center)
                               .foregroundColor(self.colorize(priority: todo.priority ?? "Normal"))
                            Text(todo.name ?? "unknown")
                               .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                               .font(.footnote)
                               .foregroundColor(Color(UIColor.systemGray2))
                               .padding(3)
                               .frame(minWidth: 62)
                               .overlay(Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.74))
                       }//: HSTACK
                       .padding(.vertical, 5)
                    } //: FOREACH
                    .onDelete(perform: deleteTodo)
                } //: LIST
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton() .accentColor(themes[self.theme.themeSettings].themeColor),
                    trailing:
                    Button(action: {
                    self.showingSettingsView.toggle()
                }) {
                    Image(systemName: "paintbrush")
                } //: ADD BUTTON
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                    .sheet(isPresented: $showingSettingsView) {
                        SettingsView()
                    }
            )
                if todos.count == 0 {
                EmptyListView()                }
            }//: ZSTACK
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                }
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                }//: ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                    
                , alignment: .bottomTrailing
            )
        }//: NAVIGATION
       
        
    }
    //MARK: - FUNCTIONS
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
        
    }
}



//MARK - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
    }
}
