//
//  ZetizenVM.swift
//  NewsIndo
//
//  Created by Hidayat Abisena on 23/04/24.
//

import Foundation

@MainActor
class ZetizenVM: ObservableObject {
    @Published var movies = [Movies]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNews() async {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        do {
            movies = try await ZetizenServices.shared.loadZetizen()
//            isLoading = false
        } catch {
            errorMessage = "🔥 \(error.localizedDescription). Failed to fetch News from API!!!🔥"
            print(errorMessage ?? "N/A")
//            isLoading = false
        }
    }
}
