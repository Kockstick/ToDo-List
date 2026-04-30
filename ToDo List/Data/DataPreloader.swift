//
//  DataPreloader.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import Foundation

class DataPreloader {
    static var shared = DataPreloader()
    
    private let PRELOAD_KEY = "isPreloaded"
    private(set) var isPreloaded: Bool = false {
        didSet {
            if isPreloaded {
                savePreloadedFlag(newValue: isPreloaded)
            }
        }
    }
    
    private init() {
        loadPreloadedFlag()
    }
    
    func preloadDataIfNeeded() async throws -> [ToDo]? {
        if !isPreloaded {
            let data = try await downloadFile()
            let decoder = JSONDecoder()
            let res = try decoder.decode(ToDosResponde.self, from: data)
            isPreloaded = true
            return res.todos
        }
        return nil
    }
    
    private func downloadFile() async throws -> Data {
        guard let url = URL(string: Bundle.main.apiURL) else {
            throw NSError(domain: "app", code: 1, userInfo: [NSLocalizedDescriptionKey: "Empty URL"])
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let http = responce as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
    
    private func savePreloadedFlag(newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: PRELOAD_KEY)
    }
    
    private func loadPreloadedFlag() {
        isPreloaded = UserDefaults.standard.bool(forKey: PRELOAD_KEY)
    }
}
