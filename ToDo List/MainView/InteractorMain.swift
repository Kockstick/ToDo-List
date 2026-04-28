//
//  IteractorView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

import Foundation

class InteractorMain: IInteractorMain {
    
    weak var presenter: IPresenterMain?
    
    var todos: [ToDo] = []
    
    init(presenter: IPresenterMain?) {
        self.presenter = presenter
        parseData() { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            
        }
    }
    
    func setCompletion(index: Int, value: Bool) {
        todos[index].completed = value
    }
    
    private func parseData(completion: @escaping (_ error: Error?) -> Void) {
        Task{
            do{
                let data = try await downloadFile()
                
                let decoder = JSONDecoder()
                let res = try decoder.decode(ToDosResponde.self, from: data)
                
                todos = res.todos
                await MainActor.run{
                    completion(nil)
                    presenter?.refreshTableView()
                }
            } catch {
                await MainActor.run{
                    completion(error)
                }
            }
        }
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
}

protocol IInteractorMain {
    var presenter: IPresenterMain? { get }
    var todos: [ToDo] { get set }
    func setCompletion(index: Int, value: Bool)
}
