//
//  TranslateResponse.swift
//  Project6 TranslateMe
//
//  Created by Anthony Irizarry on 10/14/24.
//

import Foundation

struct TranslateResponse: Codable, Hashable {
    var responseData: ResponseData
    
    struct ResponseData: Codable, Identifiable, Hashable {
        var id: UUID {
            UUID()
        }
        var translatedText: String
        var match: Int
        //let timestamp: Date
    }
}

extension TranslateResponse {
    static let mockedTranslations: [TranslateResponse.ResponseData] = [
        "Hola",
        "Como estas?",
        "Estoy bien!",
        "Adios",
        "Arroz"
    ].enumerated().map { index, translatedText in
        TranslateResponse.ResponseData(translatedText: translatedText, match: 1)
    }
}
