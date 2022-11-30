//
//  SettingsView.swift
//  Todo App
//
//  Created by Pusiewicz, M. (Mateusz) on 30/11/2022.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    //THEME
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                //MARK: - FORM
                Form {
                    //MARK: - SECTION 1
                    Section(header:
                                HStack {
                        Text("Choose the app theme")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
                    }) {
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                }) {
                                    HStack {
                                       Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        Text(item.themeName)
                                            
                                    }
                                }//: BUTTON
                                .accentColor(Color.primary)
                            }
                        }
                    }//: SECTION 1
                    .padding(.vertical, 3)
                    //MARK: - SECTION 2
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimasterclass.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://udemy.com")
                    }//: SECTION 2
                    .padding(.vertical, 3)
                    //MARK: - SECTION 3
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "iPone", secondText: "Todo")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Mateusz")
                        FormRowStaticView(icon: "paintbrush", firstText: "Design", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }//: SECTION 3
                    .padding(.vertical, 3 )
                }//: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                //MARK: FOOTER
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }//: VSTACK
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            }
            
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }//: NAVIGATION
        .accentColor(themes[self.theme.themeSettings].themeColor)
        
    }
        
}
//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
