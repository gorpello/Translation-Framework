//
//  Created by Gianluca Orpello.
//  Copyright © 2025 Unicorn Donkeys. All rights reserved.
//  

import SwiftUI
import Translation

struct ContentView: View {
    
    @State private var tasks: [String] = [
        "Buy groceries",
        "Finish homework",
        "Walk the dog",
        "Call a friend",
        "Read a book"
    ]
    
    @State private var configuration: TranslationSession.Configuration?
    
    private var taskBatch: [TranslationSession.Request] {
        tasks.map {
            TranslationSession.Request(sourceText: $0, clientIdentifier: $0)
        }
    }
    
    var body: some View {
        VStack {
            List(tasks, id: \.self) { task in
                Text(task)
            }
            
            Button {
                if configuration == nil {
                    configuration = TranslationSession.Configuration()
                    return
                }
                
                configuration?.invalidate()
            } label: {
                Text("Translate")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
        }
        .translationTask(configuration, action: { session in
            do {
                for try await response in session.translate(batch: taskBatch) {
                     addTranslation(response)
                }
            } catch {
                print(error)
            }
        })
    }
    
    private func addTranslation(_ response: TranslationSession.Response) {
        guard let matchingTask = tasks.firstIndex(where: { $0 == response.clientIdentifier })
        else { return }
        tasks[matchingTask] = response.targetText
    }
}

#Preview {
    ContentView()
}

