//
//  KeyValueStoring.swift
//  Storage
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

public protocol KeyValueStoring {
    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T?
    func save<T: Encodable>(_ value: T, forKey key: String)
}
