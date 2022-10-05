//
//  ViewModel.swift
//  3_CollectionViewPractice
//
//  Created by Vicki Yang on 2022/9/25.
//

import Foundation

class ViewModel {
    var movies: [MovieModel] = []
    
    func getMovieInf2o() -> [MovieModel] {
        for _ in 0..<20 {
            let movie = MovieModel(title: "天空之城", time: "", info: "", url: "")
            self.movies.append(movie)
        }
        return self.movies
    }
    
    func getMovieInfo() -> [MovieModel] {
        do {
            let url = Bundle.main.url(forResource: "MovieData", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([MovieModel].self, from: data)
//            let result: [MovieModel] = load("MovieData")
            // json 資料裝載
            for topic in result {
                self.movies.append(MovieModel(title: topic.title, time: topic.title, info: topic.info, url: topic.url))
            }
            
            return self.movies
        } catch {
            print(error)
        }
        
        return []
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
