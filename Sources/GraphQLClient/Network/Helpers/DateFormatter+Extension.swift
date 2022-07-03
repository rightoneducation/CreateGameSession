//
//  DateFormatter+Extension.swift
//  
//
//  Created by Mani Ramezan on 5/24/22.
//

import Foundation

extension DateFormatter {
    static let awsISO8601Decode: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withFullDate, .withFractionalSeconds]
        return formatter
    }()

    static let awsISO8601Encode: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withFullDate, .withFractionalSeconds, .withInternetDateTime]
        return formatter
    }()
}
