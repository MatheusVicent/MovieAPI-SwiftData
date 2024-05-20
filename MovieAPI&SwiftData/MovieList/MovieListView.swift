//
//  ContentView.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI
import NetworkService

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @State private var index = 0
    private let frameHeight: CGFloat = 500

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .none) {
                Text("Top rated")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 32)
                    .padding(.leading, 8)
                TabView(selection: $index) {
                    ForEach(viewModel.topRatedList, id: \.self) { movie in
                        MovieCard(
                            image: UIImage().dataConvert(
                                data: movie.imageData
                            ),
                            cardSize: .big
                        )
                    }
                }
                .padding(.top, -12)
                .frame(height: frameHeight)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Carousel(items: $viewModel.popularList, title: "Popular") { index, movie  in
                    MovieCard(
                        image: UIImage().dataConvert(data: movie.imageData),
                        cardSize: .small
                    )
                }
                .padding(.top, 32)
            }
            .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
            .onAppear {
                Task  {
                    await viewModel.getAllListMovies()
                }
            }
        }
    }

}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
