//
//  XMLInterfaces.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public protocol XMLEventHandler {
    
    func documentStart()
    
    func xmlDeclaration(version: String, encoding: String?, standalone: String?)
    
    func documentTypeDeclaration(type: String, publicID: String?, systemID: String?)
    
    func text(text: String)
    
    func cdataSection(text: String)
    
    func comment(text: String)
    
    func elementStart(name: String, attributes: inout [String:String])
    
    func elementEnd(name: String)
    
    func processingInstruction(target: String, content: String?)
    
    func internalEntityDeclaration(name: String, value: String)
    
    func parameterEntityDeclaration(name: String, value: String)
    
    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String)
    
    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String)
    
    func notationDeclaration(name: String, publicID:  String?, systemID: String?)
    
    func internalEntity(name: String)
    
    func externalEntity(name: String)
    
    func elementDeclaration(text: String)
    
    func attributeListDeclaration(text: String)
    
    func parsingTime(seconds: Double)
    
    func documentEnd()
}

open class DefaultXMLEventHandler: XMLEventHandler {
    
    public init() {}
    
    open func documentStart() {}
    
    open func xmlDeclaration(version: String, encoding: String?, standalone: String?) {}
    
    open func documentTypeDeclaration(type: String, publicID: String?, systemID: String?) {}
    
    open func text(text: String) {}
    
    open func cdataSection(text: String) {}
    
    open func comment(text: String) {}
    
    open func elementStart(name: String, attributes: inout [String:String]) {}
    
    open func elementEnd(name: String) {}
    
    open func processingInstruction(target: String, content: String?) {}
    
    open func internalEntityDeclaration(name: String, value: String) {}
    
    open func parameterEntityDeclaration(name: String, value: String) {}
    
    open func externalEntityDeclaration(name: String, publicID:  String?, systemID: String) {}
    
    open func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String) {}
    
    open func notationDeclaration(name: String, publicID:  String?, systemID: String?) {}
    
    open func internalEntity(name: String) {}
    
    open func externalEntity(name: String) {}
    
    open func elementDeclaration(text: String) {}
    
    open func attributeListDeclaration(text: String) {}
    
    open func parsingTime(seconds: Double) {}
    
    open func documentEnd() {}
}
