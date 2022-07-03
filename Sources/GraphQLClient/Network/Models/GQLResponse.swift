//
//  GQLResponse.swift
//  
//
//  Created by Mani Ramezan on 5/3/22.
//

import Foundation

protocol GQLResponseProtocol {
    associatedtype Result: Decodable
    var result: Result? { get set }
    var errorMessages: [String] { get set }
}

struct GQLResponse<Response: Decodable>: Decodable {
    let result: Response?
    let errorMessages: [String]

    enum CodingKeys: String, CodingKey {
        case data
        case errors
    }

    struct GQLResponseError: Decodable {
        let message: String
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let responseDict = try container.decodeIfPresent([String: Response].self, forKey: .data)
        result = responseDict?.values.first

        let errors = try container.decodeIfPresent([GQLResponseError].self, forKey: .errors)

        errorMessages = errors?.map { $0.message } ?? []
    }
}
