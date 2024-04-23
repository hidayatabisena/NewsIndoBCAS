//
//  ZetizenServices.swift
//  NewsIndo
//
//  Created by Hidayat Abisena on 23/04/24.
//

import Foundation
import Alamofire

class ZetizenServices {
    static let shared = ZetizenServices()
    private init() {}
    
    func loadZetizen() async throws -> [Movies] {
        guard let url = URL(string: Constant.zetizenUrlNews) else { throw URLError(.badURL) }
        
        let news = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: Zetizen.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    continuation.resume(returning: newsResponse.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        return news
    }
    
}
