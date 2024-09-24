//
//  DataLoader.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import Foundation

enum DataLoadingError: Error {
    case invalidURL
    case badResponse
}

struct DataLoader {
    func loadData<T: Decodable>(from endpoint: String) async -> T {
        let data = await fetchSerializedData(from: endpoint)
        let content: T = decodeData(data: data)
        return content
    }
    
    func decodeData<T: Decodable>(data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let content = try decoder.decode(T.self, from: data)
            
            return content
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Deconding Error. Found nil value for \(type) - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("Decoding Error. Found corrupted data at \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            fatalError("Decoding Error. Expected \(type) but found - \(context.debugDescription)")
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Decoding Error. \(key.stringValue) missing - \(context.debugDescription)")
        } catch {
            fatalError("Failed to decode data - \(error.localizedDescription)")
        }
    }
    
    func fetchSerializedData(from endpoint: String) async -> Data {
        do {
            let url = URL(string: endpoint)
            
            guard let url else {
                throw DataLoadingError.invalidURL
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw DataLoadingError.badResponse
            }
            
            return data
        } catch DataLoadingError.invalidURL {
            fatalError("Invalid URL")
        } catch DataLoadingError.badResponse {
            fatalError("Bad response")
        } catch {
            fatalError("Failed to fetch data - \(error.localizedDescription)")
        }
    }
}
