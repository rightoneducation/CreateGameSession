//
//  CodableWrap.swift
//  
//
//  Created by Mani Ramezan on 5/24/22.
//

import Foundation


enum CodableWrap: Encodable {
    case string(String)
    case stringArray([String]?)
    case int(Int)
    case bool(Bool)
    case null

    init<T>(_ val: T) where T: RawRepresentable, T.RawValue == String {
        self = .string(val.rawValue)
    }

    init(_ val: String?) {
        if let val = val {
            self = .string(val)
        } else {
            self = .null
        }
    }

    init(_ val: UUID) {
        self = .init(val.uuidString.lowercased())
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let val):
            try container.encode(val)
        case .int(let val):
            try container.encode(val)
        case .bool(let val):
            try container.encode(val)
        case .stringArray(let val):
            try container.encode(val)
        case .null:
            try container.encodeNil()
        }
    }
}
