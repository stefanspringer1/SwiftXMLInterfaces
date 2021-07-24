//
//  XMLInterfaces.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public class XMLEventHandler {
    
    public func documentStart() {}
    
    public func xmlDeclaration(version: String, encoding: String?, standalone: String?) {}
    
    public func documentTypeDeclaration(type: String, publicID: String?, systemID: String?) {}
    
    public func text(text: String) {}
    
    public func cdataSection(text: String) {}
    
    public func comment(text: String) {}
    
    public func elementStart(name: String, attributes: inout [String:String]) {}
    
    public func elementEnd(name: String) {}
    
    public func processingInstruction(target: String, content: String?) {}
    
    public func internalEntityDeclaration(name: String, value: String) {}
    
    public func parameterEntityDeclaration(name: String, value: String) {}
    
    public func externalEntityDeclaration(name: String, publicID:  String?, systemID: String) {}
    
    public func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String) {}
    
    public func notationDeclaration(name: String, publicID:  String?, systemID: String?) {}
    
    public func internalEntity(name: String) {}
    
    public func externalEntity(name: String) {}
    
    public func elementDeclaration(text: String) {}
    
    public func attributeListDeclaration(text: String) {}
    
    public func parsingTime(seconds: Double) {}
    
    public func documentEnd() {}
}
