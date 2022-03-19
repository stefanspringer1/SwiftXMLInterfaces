//
//  Parsing.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public struct XEventHandlerError: LocalizedError {

    private let message: String

    public init(_ message: String) {
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }
}

public protocol InternalEntityResolver {
    func resolve(entityWithName entityName: String, forAttributeWithName attributeName: String?, atElementWithName elementName: String?) -> String?
}

public enum WhitespaceIndicator {
    case WHITESPACE
    case NOT_WHITESPACE
    case UNKNOWN
}

public struct TextRange: CustomStringConvertible {
    
    public let startLine: Int
    public let startColumn: Int
    public let endLine: Int
    public let endColumn: Int
    
    public init(
        startLine: Int,
        startColumn: Int,
        endLine: Int,
        endColumn: Int
    ) {
        self.startLine = startLine
        self.startColumn = startColumn
        self.endLine = endLine
        self.endColumn = endColumn
    }
    
    public var description: String { get { "\(startLine):\(startColumn) - \(endLine):\(endColumn)" } }
}

public struct DataRange: CustomStringConvertible {
    
    public let binaryStart: Int
    public let binaryUntil: Int
    
    public init(
        binaryStart: Int,
        binaryUntil: Int
    ) {
        self.binaryStart = binaryStart
        self.binaryUntil = binaryUntil
    }
    
    public var description: String { get { "\(binaryStart)..<\(binaryUntil)" } }
}

public protocol XEventHandler {

    func documentStart()

    func xmlDeclaration(version: String, encoding: String?, standalone: String?, textRange: TextRange?, dataRange: DataRange?)

    func documentTypeDeclarationStart(type: String, publicID: String?, systemID: String?, textRange: TextRange?, dataRange: DataRange?)
    
    func documentTypeDeclarationEnd(textRange: TextRange?, dataRange: DataRange?)

    func elementStart(name: String, attributes: [String:String]?, textRange: TextRange?, dataRange: DataRange?)

    func elementEnd(name: String, textRange: TextRange?, dataRange: DataRange?)

    func text(text: String, whitespace: WhitespaceIndicator, textRange: TextRange?, dataRange: DataRange?)

    func cdataSection(text: String, textRange: TextRange?, dataRange: DataRange?)

    func processingInstruction(target: String, data: String?, textRange: TextRange?, dataRange: DataRange?)

    func comment(text: String, textRange: TextRange?, dataRange: DataRange?)

    func internalEntityDeclaration(name: String, value: String, textRange: TextRange?, dataRange: DataRange?)

    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String, textRange: TextRange?, dataRange: DataRange?)

    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String, textRange: TextRange?, dataRange: DataRange?)

    func notationDeclaration(name: String, publicID:  String?, systemID: String?, textRange: TextRange?, dataRange: DataRange?)

    func internalEntity(name: String, textRange: TextRange?, dataRange: DataRange?)

    func externalEntity(name: String, textRange: TextRange?, dataRange: DataRange?)

    func elementDeclaration(name: String, literal: String, textRange: TextRange?, dataRange: DataRange?)

    func attributeListDeclaration(name: String, literal: String, textRange: TextRange?, dataRange: DataRange?)

    func parameterEntityDeclaration(name: String, value: String, textRange: TextRange?, dataRange: DataRange?)

    func documentEnd()
}

open class DefaultXEventHandler: XEventHandler {

    public init() {}

    open func documentStart() {}

    open func xmlDeclaration(version: String, encoding: String?, standalone: String?, textRange: TextRange?, dataRange: DataRange?) {}
    
    open func documentTypeDeclarationStart(type: String, publicID: String?, systemID: String?, textRange: TextRange?, dataRange: DataRange?) {}
    
    open func documentTypeDeclarationEnd(textRange: TextRange?, dataRange: DataRange?) {}

    open func elementStart(name: String, attributes: [String:String]?, textRange: TextRange?, dataRange: DataRange?) {}

    open func elementEnd(name: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func text(text: String, whitespace: WhitespaceIndicator, textRange: TextRange?, dataRange: DataRange?) {}

    open func cdataSection(text: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func processingInstruction(target: String, data: String?, textRange: TextRange?, dataRange: DataRange?) {}

    open func comment(text: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func internalEntityDeclaration(name: String, value: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func externalEntityDeclaration(name: String, publicID:  String?, systemID: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func notationDeclaration(name: String, publicID:  String?, systemID: String?, textRange: TextRange?, dataRange: DataRange?) {}

    open func internalEntity(name: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func externalEntity(name: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func elementDeclaration(name: String, literal: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func attributeListDeclaration(name: String, literal: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func parameterEntityDeclaration(name: String, value: String, textRange: TextRange?, dataRange: DataRange?) {}

    open func documentEnd() {}
}
