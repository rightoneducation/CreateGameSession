//
//  GQLRequest.swift
//  
//
//  Created by Mani Ramezan on 5/15/22.
//

import Foundation

struct GQLRequest: Encodable {
    var query: String
    var operationName: String? = nil
    var variables: [String: String]
}
