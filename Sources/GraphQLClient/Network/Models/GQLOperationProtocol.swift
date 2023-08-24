//
//  GQLOperationProtocol.swift
//  
//
//  Created by Mani Ramezan on 5/3/22.
//

import Foundation

protocol GQLOperationProtocol: Encodable {
    associatedtype Response: Decodable
    associatedtype VariableType: Encodable

    var query: String { get }
    var operationName: String? { get }
    var variables: [String: VariableType] { get }
}

// MARK: - Default Implementation

extension GQLOperationProtocol {
    var operationName: String? {
        nil
    }
}

// MARK: - Encodable

extension GQLOperationProtocol {
    func encode(to encoder: Encoder) throws {
        var encoderContainer = encoder.container(keyedBy: CodingKeys.self)

        try encoderContainer.encode(query, forKey: .query)
        try encoderContainer.encode(operationName, forKey: .operationName)
        try encoderContainer.encode(variables, forKey: .variables)
    }
}

fileprivate enum CodingKeys: String, CodingKey {
    case query
    case operationName
    case variables
}
