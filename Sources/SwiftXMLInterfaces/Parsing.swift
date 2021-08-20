//
//  XMLInterfaces.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public struct XMLEventHandlerError: LocalizedError {
    
    private let message: String

    public init(_ message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        return message
    }
}

public protocol InternalEntityResolver {
    func resolve(entityName:String, attributeContext: String?, attributeName: String?) -> String?
}

public protocol XMLEventHandler {
    
    func documentStart()
    
    func xmlDeclaration(version: String, encoding: String?, standalone: String?)
    
    func documentTypeDeclaration(type: String, publicID: String?, systemID: String?)
    
    func elementStart(name: String, attributes: inout [String:String], combineTexts: Bool)
    
    func elementEnd(name: String)
    
    func text(text: String, isWhitespace: Bool)
    
    func cdataSection(text: String)
    
    func processingInstruction(target: String, content: String?)
    
    func comment(text: String)
    
    func internalEntityDeclaration(name: String, value: String)
    
    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String)
    
    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String)
    
    func notationDeclaration(name: String, publicID:  String?, systemID: String?)
    
    func internalEntity(name: String)
    
    func externalEntity(name: String)
    
    func elementDeclaration(name: String, text: String)
    
    func attributeListDeclaration(name: String, text: String)
    
    func parameterEntityDeclaration(name: String, value: String)
    
    func parsingTime(seconds: Double)
    
    func documentEnd()
}

open class DefaultXMLEventHandler: XMLEventHandler {
    
    public init() {}
    
    open func documentStart() {}
    
    open func xmlDeclaration(version: String, encoding: String?, standalone: String?) {}
    
    open func documentTypeDeclaration(type: String, publicID: String?, systemID: String?) {}
    
    open func elementStart(name: String, attributes: inout [String:String], combineTexts: Bool) {}
    
    open func elementEnd(name: String) {}
    
    open func text(text: String, isWhitespace: Bool) {}
    
    open func cdataSection(text: String) {}
    
    open func processingInstruction(target: String, content: String?) {}
    
    open func comment(text: String) {}
    
    open func internalEntityDeclaration(name: String, value: String) {}
    
    open func externalEntityDeclaration(name: String, publicID:  String?, systemID: String) {}
    
    open func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String) {}
    
    open func notationDeclaration(name: String, publicID:  String?, systemID: String?) {}
    
    open func internalEntity(name: String) {}
    
    open func externalEntity(name: String) {}
    
    open func elementDeclaration(name: String, text: String) {}
    
    open func attributeListDeclaration(name: String, text: String) {}
    
    open func parameterEntityDeclaration(name: String, value: String) {}
    
    open func parsingTime(seconds: Double) {}
    
    open func documentEnd() {}
}
