//
//  ContentView.swift
//  MKTOne
//
//  Created by bbqm on 12.01.24.
//


import SwiftUI

// MARK: - Topic 1
// Network Calls

struct ContentView: View {

    @State private var user: GithubUser?

    var body: some View {
        VStack(spacing: 20){

            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }

            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)

            Text(user?.bio ?? "Bio Placeholder")
                .padding()

            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid response")
            } catch GHError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }

            /*
            // FIXME: This call will not work
            // Following Generics Example

            do {
                user = try await fetchData(for: GithubUser.self, from: URL(string: "https://api.github.com/users/debughercules")!)
            } catch {
                
            }
             */
        }
    }

    func getUser() async throws -> GithubUser {
        let endpoint = "https://api.github.com/users/debughercules"

        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as?HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GithubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }

    //Example using Generics
    // TODO: It doesn't work
    let decoder = JSONDecoder()
    func fetchData<T: Decodable>(for: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data (from: url)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}


#Preview {
    ContentView()
}


struct GithubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}


enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}








