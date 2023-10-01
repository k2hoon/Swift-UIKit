//
//  ModelDataLoader.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import Foundation

final class ModelDataLoader {
    func load<T: Decodable>(_ filename: String) throws -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw LoaderError.notFound(filename: filename)
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw LoaderError.bufferFail
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw LoaderError.decodeFail
        }
    }
    
    func load(_ filename: String) throws -> Data {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw LoaderError.notFound(filename: filename)
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw LoaderError.bufferFail
        }
        
        return data
    }
    
}

// MARK: ModelDataLoader error
fileprivate enum LoaderError: Error {
    case notFound(filename: String)
    case bufferFail
    case decodeFail
}

extension LoaderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound(let filename):
            return "Couldn't find \(filename) in main bundle."
        case .bufferFail:
            return "Cannot create data value"
        case .decodeFail:
            return "Cannot decode data"
        }
    }
}
