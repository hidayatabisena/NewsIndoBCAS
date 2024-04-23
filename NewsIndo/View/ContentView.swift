//
//  ContentView.swift
//  NewsIndo
//
//  Created by Hidayat Abisena on 23/04/24.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @StateObject private var newsVM = NewsVM()
    @StateObject private var zetizenVM = ZetizenVM()
    @State private var searchText = ""
    
    var newsSearchResults: [Movies] {
        guard !searchText.isEmpty else { return zetizenVM.movies }
        
        let results = zetizenVM.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        
        return results
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(zetizenVM.movies) { article in
                    NewsRow(
                        image: article.image,
                        title: article.title,
                        author: article.creator,
                        link: article.link,
                        isoDate: article.isoDate.relativeToCurrentDate()
                    )
                    .redacted(reason: newsVM.isLoading ? .placeholder : [])
                }
            }
            .searchable(text: $searchText)
            .refreshable {
                await newsVM.fetchNews()
            }
            .listStyle(.plain)
            .navigationTitle(Constant.newsTitle)
            .task {
                // await newsVM.fetchNews()
                await zetizenVM.fetchNews()
            }
            .overlay(newsVM.isLoading ? ProgressView() : nil)
        }
    }
}

#Preview {
    ContentView()
}

@ViewBuilder
func WaitingView() -> some View {
    VStack(spacing: 20) {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.pink)
        
        Text("Fetch image.....")
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { scene in
                scene as? UIWindowScene
            }
            .filter { filter in
                filter.activationState == .foregroundActive
            }
            .first?.keyWindow
    }
}


struct NewsRow: View {
    var image: String
    var title: String
    var author: String
    var link: String
    var isoDate: String
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: image)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                WaitingView()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Text(isoDate)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button {
                        let vc = SFSafariViewController(url: URL(string: link)!)
                        
                        UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                    } label: {
                        Text("| Selengkapnya")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
}
