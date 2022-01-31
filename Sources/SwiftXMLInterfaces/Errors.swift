//
//  Parsing.swift
//
//  Created 2022 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public struct ParseError: LocalizedError {
    
    private let message: String

    init(_ message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        return message
    }
}
