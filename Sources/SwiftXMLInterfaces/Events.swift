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
    func resolve(entityWithName entityName: String, forAttributeName attributeName: String?, atElementWithName elementName: String?) -> String?
}

public enum WhitespaceIndicator {
    case WHITESPACE
    case NOT_WHITESPACE
    case UNKNOWN
}

public struct SourceRange: CustomStringConvertible {
    
    public let startLine: Int
    public let startColumn: Int
    public let endLine: Int
    public let endColumn: Int
    public let binaryStart: Int
    public let binaryUntil: Int
    
    public init(
        startLine: Int,
        startColumn: Int,
        endLine: Int,
        endColumn: Int,
        binaryStart: Int,
        binaryUntil: Int
    ) {
        self.startLine = startLine
        self.startColumn = startColumn
        self.endLine = endLine
        self.endColumn = endColumn
        self.binaryStart = binaryStart
        self.binaryUntil = binaryUntil
    }
    
    public var description: String { get { "\(startLine):\(startColumn) - \(endLine):\(endColumn) (bin. \(binaryStart)..<\(binaryUntil))" } }
}

public protocol XEventHandler {

    func documentStart()

    func xmlDeclaration(version: String, encoding: String?, standalone: String?, sourceRange: SourceRange)

    func documentTypeDeclarationStart(type: String, publicID: String?, systemID: String?, sourceRange: SourceRange)
    
    func documentTypeDeclarationEnd(sourceRange: SourceRange)

    func elementStart(name: String, attributes: [String:String]?, sourceRange: SourceRange)

    func elementEnd(name: String, sourceRange: SourceRange)

    func text(text: String, whitespace: WhitespaceIndicator, sourceRange: SourceRange)

    func cdataSection(text: String, sourceRange: SourceRange)

    func processingInstruction(target: String, data: String?, sourceRange: SourceRange)

    func comment(text: String, sourceRange: SourceRange)

    func internalEntityDeclaration(name: String, value: String, sourceRange: SourceRange)

    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String, sourceRange: SourceRange)

    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String, sourceRange: SourceRange)

    func notationDeclaration(name: String, publicID:  String?, systemID: String?, sourceRange: SourceRange)

    func internalEntity(name: String, sourceRange: SourceRange)

    func externalEntity(name: String, sourceRange: SourceRange)

    func elementDeclaration(name: String, literal: String, sourceRange: SourceRange)

    func attributeListDeclaration(name: String, literal: String, sourceRange: SourceRange)

    func parameterEntityDeclaration(name: String, value: String, sourceRange: SourceRange)

    func documentEnd()
}

open class DefaultXEventHandler: XEventHandler {

    public init() {}

    open func documentStart() {}

    open func xmlDeclaration(version: String, encoding: String?, standalone: String?, sourceRange: SourceRange) {}
    
    open func documentTypeDeclarationStart(type: String, publicID: String?, systemID: String?, sourceRange: SourceRange) {}
    
    open func documentTypeDeclarationEnd(sourceRange: SourceRange) {}

    open func elementStart(name: String, attributes: [String:String]?, sourceRange: SourceRange) {}

    open func elementEnd(name: String, sourceRange: SourceRange) {}

    open func text(text: String, whitespace: WhitespaceIndicator, sourceRange: SourceRange) {}

    open func cdataSection(text: String, sourceRange: SourceRange) {}

    open func processingInstruction(target: String, data: String?, sourceRange: SourceRange) {}

    open func comment(text: String, sourceRange: SourceRange) {}

    open func internalEntityDeclaration(name: String, value: String, sourceRange: SourceRange) {}

    open func externalEntityDeclaration(name: String, publicID:  String?, systemID: String, sourceRange: SourceRange) {}

    open func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String, sourceRange: SourceRange) {}

    open func notationDeclaration(name: String, publicID:  String?, systemID: String?, sourceRange: SourceRange) {}

    open func internalEntity(name: String, sourceRange: SourceRange) {}

    open func externalEntity(name: String, sourceRange: SourceRange) {}

    open func elementDeclaration(name: String, literal: String, sourceRange: SourceRange) {}

    open func attributeListDeclaration(name: String, literal: String, sourceRange: SourceRange) {}

    open func parameterEntityDeclaration(name: String, value: String, sourceRange: SourceRange) {}

    open func documentEnd() {}
}
