//
//  Created by Gianluca Orpello.
//  Copyright © 2025 Unicorn Donkeys. All rights reserved.
//

import SwiftUI
import Translation

struct ContentView: View {
    
    @State private var inputText: String = ""
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            TextField("Write something...", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .translationPresentation(
                    isPresented: $isPresented,
                    text: inputText)
            {
                inputText = $0
            }
             
            Button {
                isPresented.toggle()
            } label: {
                Text("Translate")
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
