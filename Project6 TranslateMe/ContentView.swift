//
//  ContentView.swift
//  Project6 TranslateMe
//
//  Created by Anthony Irizarry on 10/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var input: String = ""
    @State var translatedWord: String = ""
    @State var obtainedMatch: Int = 0
    @State var responseData: TranslateResponse.ResponseData?
    @State var historyManager: HistoryManager
    
    init(isMocked: Bool = false){
        historyManager = HistoryManager(isMocked: isMocked)
    }
    
    var body: some View {
        NavigationStack{
        VStack(alignment: .leading) {
            Text("Translate Me")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            TextField("Enter text", text: $input)
                .padding()
            Text("Translate Me")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.50), radius: 2, x: 0, y: 3)
                .onTapGesture{
                    Task {
                        await fetchTranslation()
                        historyManager.sendTranslation(translatedText: translatedWord, match: obtainedMatch)
                    }
                }
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(.clear)
                    .frame(width: .infinity, height: 200)
                    .border(.blue)
                    .padding(.top)
                Text(translatedWord)
                    .padding()
                
            }
            
            Spacer()
            
            NavigationLink(destination: HistoryView()){
                Text("View Saved Translations")
                    .frame(maxWidth: .infinity)
            }
            
            
            
            
            Spacer()
        }
    }
        .padding()
    }
    
    private func fetchTranslation() async {
        let url = URL(string: "https://api.mymemory.translated.net/get?q=\(input)&langpair=en|es")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            
            let translateResponse = try decoder.decode(TranslateResponse.self, from: data)

            let responseData = translateResponse.responseData

            self.responseData = responseData
            
            translatedWord = responseData.translatedText
            obtainedMatch = responseData.match
                        
            print(responseData.translatedText)
            print(responseData.match)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView(isMocked: true)
}
