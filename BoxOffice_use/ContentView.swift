//
//  ContentView.swift
//  BoxOffice_use
//
//  Created by 양시관 on 2/10/24.
//

import SwiftUI
import BoxOffices
import Foundation

struct ContentView: View {
    @State private var movies : [Movie] = []
    
    var body: some View {
        List {
            ForEach(movies, id: \.code) {
                movie in
                HStack{
                    Text("#\(movie.rank)")
                        .bold()
                        .foregroundStyle(Color.accentColor)
                    Text(movie.name)
                }
            }
        }
        .task {
            do{
                movies = try await  BoxOffices.shared.fetchDailyTop10().get()
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension BoxOffices {
    static var shared : BoxOffices {
        BoxOffices(key: "7306d0e89e947e73d92d934ee1acc721")
    }
}

#Preview {
    ContentView()
}
