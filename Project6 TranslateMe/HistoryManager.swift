//
//  HistoryManager.swift
//  Project6 TranslateMe
//
//  Created by Anthony Irizarry on 10/15/24.
//

import Foundation
import FirebaseFirestore

@Observable
class HistoryManager {
    
    var savedTranslations: [TranslateResponse.ResponseData] = []
    
    private let dataBase = Firestore.firestore()
    
    init(isMocked: Bool = false) {
        if isMocked {
            savedTranslations = TranslateResponse.mockedTranslations
        } else {
            getSavedTranslations()

        }
    }
    
    func getSavedTranslations() {
        dataBase.collectionGroup("savedTranslations").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents \(String(describing: error))")
                return
            }
            
            let savedTranslations = documents.compactMap { document in
                do {
                    return try document.data(as: TranslateResponse.ResponseData.self)
                } catch {
                    print("Error decoding document into translation: \(error)")
                    return nil
                }
            }
            
            self.savedTranslations = savedTranslations
            
        }
    }
    
    func deleteSavedTranslations() async {
        do {
            let querySnapshot = try await dataBase.collection("savedTranslations").getDocuments()
            
            for document in querySnapshot.documents {
                    try await document.reference.delete()
            }
        } catch{
            print("Error deleting translations: \(error)")
        }
    }
    
    
    func sendTranslation(translatedText: String, match: Int) {
        do {
            let translation = TranslateResponse.ResponseData(translatedText: translatedText, match: match)
            
            try dataBase.collection("savedTranslations").document().setData(from: translation)
            print("Translation successfully sent: \(translatedText)")
        } catch {
            print("Error sending translation to Firestore: \(error)")
        }
    }
}
