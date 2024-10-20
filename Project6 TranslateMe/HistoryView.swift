//
//  HistoryView.swift
//  Project6 TranslateMe
//
//  Created by Anthony Irizarry on 10/14/24.
//

import SwiftUI

struct HistoryView: View {
    @State var str: String = ""
    @State var historyManager: HistoryManager
    
    init(isMocked: Bool = false){
        historyManager = HistoryManager(isMocked: isMocked)
    }
    
    var body: some View {
        List {
            ForEach(historyManager.savedTranslations, id: \.self) { translation in
                    Text(translation.translatedText)
                }
        }
               
                
        Text("Clear All Translations")
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.size.width / 2)
            .background(Color.red)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.50), radius: 2, x: 0, y: 3)
            .onTapGesture {
                Task {
                    await historyManager.deleteSavedTranslations()
                }
            }
        
    }
}

#Preview {
    HistoryView(isMocked: true)
}

