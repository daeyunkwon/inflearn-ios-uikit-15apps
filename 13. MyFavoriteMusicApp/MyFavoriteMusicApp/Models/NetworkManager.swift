//
//  NetworkManager.swift
//  MyFavoriteMusicApp
//
//  Created by 권대윤 on 2023/10/02.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMusic(searchTerm: String, completion: @escaping (Result<[Music], NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&media=music&country=KR&limit=50&lang=ko_KR"
        
        performRequset(urlString: urlString) { result in
            completion(result)
        }
    }
    
    private func performRequset(urlString: String, completion: @escaping (Result<[Music], NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("url 생성 실패")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else {
                print("Error: HTTP response failed")
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let music = self.parseJSON(data: safeData) {
                completion(.success(music))
                print("Parse 실행")
            } else {
                completion(.failure(.parseError))
                print("Parse 실패")
            }
            
        }
        task.resume()
    }
    
    private func parseJSON(data: Data) -> [Music]? {
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: data)
            return musicData.results
        } catch {
            print(error)
            return nil
        }
    }
    
    
    
    
}
