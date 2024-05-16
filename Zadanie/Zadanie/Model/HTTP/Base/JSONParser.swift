//
//  JSONParser.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

public class JSONParser {
    
    private let decoder: JSONDecoder
    
    init() {
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
        do {
            let decodedObject = try decoder.decode(type.self, from: data)
            return .success(decodedObject)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Decoding error (keyNotFound): \(key) not found in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return .failure(AppError.parsing)
        } catch let DecodingError.dataCorrupted(context) {
            print("Decoding error (dataCorrupted): data corrupted in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return .failure(AppError.parsing)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Decoding error (typeMismatch): type mismatch of \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return .failure(AppError.parsing)
        } catch let DecodingError.valueNotFound(type, context) {
            print("Decoding error (valueNotFound): value not found for \(type) in \(context.debugDescription)")
            return .failure(AppError.parsing)
        } catch {
            return .failure(AppError.parsing)
        }
    }
}
           
