//
//  ViewModel.swift
//  3_CollectionViewPractice
//
//  Created by Vicki Yang on 2022/9/25.
//

import Foundation

class ViewModel {
    var movies: [MovieModel] = []
    
    func getMovieInfo() -> [MovieModel] {
        for i in 0..<20 {
            let randomInt = Int.random(in: 1...8)
            let movie = MovieModel(title: "第\(i+1)部", image: "熊貓家族_0\(randomInt)", url: "")
            self.movies.append(movie)
        }
        return self.movies
    }
}
