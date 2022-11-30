//
//  EmptyListView.swift
//  Todo App
//
//  Created by Pusiewicz, M. (Mateusz) on 30/11/2022.
//

import SwiftUI

struct EmptyListView: View {
    //MARK: - PROPERTIES
    
    
    @State private var isAnimated: Bool = false
    
    let images: [String] = [
    "illustration-no1",
    "illustration-no2",
    "illustration-no3"
    ]
    
    let tips: [String] = [
    "Use your time wisely",
    "Slow and steady win the race",
    "Keep it short and sweet",
    "Put hard tasks first",
    "Reward yourself after work",
    "Collect tasks ahead of time",
    "Each night schedule work for tomorrow",
    ]
    
    //MARK: - BODY
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("\(images.randomElement() ?? self.images[0])")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            } //: VSTACK
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5), value: isAnimated)
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        } //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}




struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .environment(\.colorScheme, .dark)
    }
}
