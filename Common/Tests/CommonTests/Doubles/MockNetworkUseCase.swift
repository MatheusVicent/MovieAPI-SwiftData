//
//  MockNetworkUseCase.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import Foundation
@testable import MovieAPI_SwiftData
import Common

class MockNetworkUseCase: NetworkRequestUseCase {
    var shouldReturnNil = false

    func request<T>(urlMovie: URLMoviesType) async -> T? where T: Decodable {
        if shouldReturnNil {
            return nil
        }

        if T.self == Data.self {
            return nil
        }
        return MovieResponseModel.getMovieResponse() as? T
    }
}