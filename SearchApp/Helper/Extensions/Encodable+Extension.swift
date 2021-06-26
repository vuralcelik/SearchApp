//
//  Encodable+Extension.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

extension Encodable {
    var asDictionaryForQueryString: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: String] }
    }
    
    var asDictionaryWithoutNilValues: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var asDictionaryWithNilValues: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).map { ($0 as? [String: Any] ?? [:]) }
    }
    
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
