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

public struct XTextRange: CustomStringConvertible {
    
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

public struct XDataRange: CustomStringConvertible {
    
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
    
    func enterDataSource(data: Data, entityName: String?, url: URL?)
    
    func leaveDataSource()

    func xmlDeclaration(version: String, encoding: String?, standalone: String?, textRange: XTextRange?, dataRange: XDataRange?)

    func documentTypeDeclarationStart(type: String, publicID: String?, systemID: String?, textRange: XTextRange?, dataRange: XDataRange?)
    
    func documentTypeDeclarationEnd(textRange: XTextRange?, dataRange: XDataRange?)

    func elementStart(name: String, attributes: [String:String?]?, textRange: XTextRange?, dataRange: XDataRange?)

    func elementEnd(name: String, textRange: XTextRange?, dataRange: XDataRange?)

    func text(text: String, whitespace: WhitespaceIndicator, textRange: XTextRange?, dataRange: XDataRange?)

    func cdataSection(text: String, textRange: XTextRange?, dataRange: XDataRange?)

    func processingInstruction(target: String, data: String?, textRange: XTextRange?, dataRange: XDataRange?)

    func comment(text: String, textRange: XTextRange?, dataRange: XDataRange?)

    func internalEntityDeclaration(name: String, value: String, textRange: XTextRange?, dataRange: XDataRange?)

    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String, textRange: XTextRange?, dataRange: XDataRange?)

    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String, textRange: XTextRange?, dataRange: XDataRange?)

    func notationDeclaration(name: String, publicID:  String?, systemID: String?, textRange: XTextRange?, dataRange: XDataRange?)

    func internalEntity(name: String, textRange: XTextRange?, dataRange: XDataRange?)

    func externalEntity(name: String, textRange: XTextRange?, dataRange: XDataRange?)

    func elementDeclaration(name: String, literal: String, textRange: XTextRange?, dataRange: XDataRange?)

    func attributeListDeclaration(name: String, literal: String, textRange: XTextRange?, dataRange: XDataRange?)

    func parameterEntityDeclaration(name: String, value: String, textRange: XTextRange?, dataRange: XDataRange?)

    func documentEnd()
}

open class DefaultXEventHandler: XEventHandler {

    public init() {}
    
    open func documentStart() {}
    
    open func enterInternalDataSource(data: Data, entityName: String) {}
    
    open func leaveInternalDataSource() {}
    
    open func enterExternalDataSource(data: Data, entityName: String?, url: URL?) {}
    
    open func leaveExternalDataSource() {}

    open func xmlDeclaration(version: String, encoding: String?, standalone: String?, textRange: XTextRange?, dataRange: XDataRange?) {}
    
    open func documentTypeDeclarationStart(type: String, publicID: String?, systemID: String?, textRange: XTextRange?, dataRange: XDataRange?) {}
    
    open func documentTypeDeclarationEnd(textRange: XTextRange?, dataRange: XDataRange?) {}

    open func elementStart(name: String, attributes: [String:String?]?, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func elementEnd(name: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func text(text: String, whitespace: WhitespaceIndicator, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func cdataSection(text: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func processingInstruction(target: String, data: String?, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func comment(text: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func internalEntityDeclaration(name: String, value: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func externalEntityDeclaration(name: String, publicID:  String?, systemID: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func notationDeclaration(name: String, publicID:  String?, systemID: String?, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func internalEntity(name: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func externalEntity(name: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func elementDeclaration(name: String, literal: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func attributeListDeclaration(name: String, literal: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func parameterEntityDeclaration(name: String, value: String, textRange: XTextRange?, dataRange: XDataRange?) {}

    open func documentEnd() {}
}
