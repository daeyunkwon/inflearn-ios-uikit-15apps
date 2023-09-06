//
//  NetworkManager.swift
//  MusicSearchApp
//
//  Created by 권대윤 on 2023/09/06.
//

import Foundation

//에러 케이스 정의
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


class NetworkManager {
    
    //싱글톤 설정
    static let shared = NetworkManager()
    private init() {}
    
    //타입 정의
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    //음악 데이터 가져오기
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&media=music&country=KR&limit=199"
        
        performRequest(urlString: urlString) { result in
            completion(result)
        }
    }
    
    private func performRequest(urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(Result.failure(.networkingError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else {
                print("Error: https request failed")
                return
            }
            
            guard let safeData = data else {
                completion(Result.failure(.dataError))
                return
            }
            
            if let musics = self.parseJSON(data: safeData) {
                print("Parse 실행")
                completion(Result.success(musics))
            } else {
                print("Parse 실패")
                completion(Result.failure(.parseError))
            }
            
            
            
            
        }
        task.resume()
    }
    
    private func parseJSON(data: Data) -> [Music]? {
        do {
            let decoder = JSONDecoder()
            let musicData = try decoder.decode(MusicData.self, from: data)
            return musicData.results
        } catch {
            return nil
        }
    }
    
    
    
    
}
