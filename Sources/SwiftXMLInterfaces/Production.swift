//
//  XMLInterfaces.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public protocol XMLProduction {
    
    func setLinebreak(linebreak: String)
    
    func setDeclarationInInternalSubsetIndentation(indentation: String)
    
    func documentStart()
    
    func xmlDeclaration(version: String, encoding: String?, standalone: String?)
    
    func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool)
    
    func documentTypeDeclarationInternalSubsetStart()
    
    func documentTypeDeclarationInternalSubsetEnd()
    
    func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool)
    
    func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool)
    
    func attribute(name: String, value: String)
    
    func attributeValue(value: String)
    
    func elementStartAfterAttributes(name: String, hasAttributes: Bool, isEmpty: Bool)
    
    func elementEnd(name: String, hasAttributes: Bool, isEmpty: Bool)
    
    func text(text: String)
    
    func cdataSection(text: String)
    
    func processingInstruction(target: String, content: String?)
    
    func comment(text: String)
    
    func internalEntityDeclaration(name: String, value: String)
    
    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String)
    
    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String)
    
    func notationDeclaration(name: String, publicID:  String?, systemID: String?)
    
    func parameterEntityDeclaration(name: String, value: String)
    
    func internalEntity(name: String)
    
    func externalEntity(name: String)
    
    func elementDeclaration(name: String, text: String)
    
    func attributeListDeclaration(name: String, text: String)

    func documentEnd()
}

open class DefaultXMLProduction: XMLProduction {
    
    var file: FileHandle
    
    public init() {
        self.file = FileHandle.standardOutput
    }
    
    public init(file: FileHandle) {
        self.file = file
    }
    
    var linebreak = "\n"
    var declarationInInternalSubsetIndentation = " "
    
    public func setLinebreak(linebreak: String) {
        self.linebreak = linebreak
    }
    
    public func setDeclarationInInternalSubsetIndentation(indentation: String) {
        self.declarationInInternalSubsetIndentation = indentation
    }
    
    open func documentStart() {}
    
    open func xmlDeclaration(version: String, encoding: String?, standalone: String?) {
        file.write("<?xml version=\"1.0\" encoding=\"\(encoding ?? "UTF-8")\" standalone=\"\(standalone ?? "yes")\"?>\(linebreak)".data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) {
        file.write("<!DOCTYPE \(type)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "")\(systemID != nil ? "\(publicID == nil ? " SYSTEM" : "") \"\(systemID ?? "")\"" : "")".data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationInternalSubsetStart() {
        file.write(" [\(linebreak)".data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationInternalSubsetEnd() {
        file.write("]".data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) {
        file.write(">\(linebreak)".data(using: .utf8)!)
    }
    
    open func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) {
        file.write("<\(name)".data(using: .utf8)!)
    }
    
    open func attributeValue(value: String) {
        file.write(escapeDoubleQuotedValue(value).data(using: .utf8)!)
    }
    
    open func attribute(name: String, value: String) {
        file.write(" \(name)=\"".data(using: .utf8)!)
        attributeValue(value: value)
        file.write("\"".data(using: .utf8)!)
    }
    
    open func elementStartAfterAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) {
        if isEmpty {
            file.write("/".data(using: .utf8)!)
        }
        file.write(">".data(using: .utf8)!)
    }
    
    open func elementEnd(name: String, hasAttributes: Bool, isEmpty: Bool) {
        if !isEmpty {
            file.write("</\(name)>".data(using: .utf8)!)
        }
    }
    
    open func text(text: String) {
        file.write(escapeText(text).data(using: .utf8)!)
    }
    
    open func cdataSection(text: String) {
        file.write("<![CDATA[\(text)]]>".data(using: .utf8)!)
    }
    
    open func processingInstruction(target: String, content: String?) {
        file.write("<?\(target)\(content != nil ? " \"\(content ?? "")\"" : "")?>".data(using: .utf8)!)
    }
    
    open func comment(text: String) {
        file.write("<!--\(text)-->".data(using: .utf8)!)
    }
    
    open func internalEntityDeclaration(name: String, value: String) {
        file.write("\(declarationInInternalSubsetIndentation)<!ENTITY \(name) \"\(escapeDoubleQuotedValue(value))\">\(linebreak)".data(using: .utf8)!)
    }
    
    open func externalEntityDeclaration(name: String, publicID:  String?, systemID: String) {
        file.write("\(declarationInInternalSubsetIndentation)<!ENTITY \(name)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "SYSTEM") \"\(systemID)\">\(linebreak)".data(using: .utf8)!)
    }
    
    open func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String) {
        file.write("\(declarationInInternalSubsetIndentation)<!ENTITY \(name)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "SYSTEM") \"\(systemID)\" NDATA \(notation)>\(linebreak)".data(using: .utf8)!)
    }
    
    open func notationDeclaration(name: String, publicID:  String?, systemID: String?) {
        file.write("\(declarationInInternalSubsetIndentation)<!NOTATION \(name)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "")\(systemID != nil ? "\(publicID == nil ? " SYSTEM" : "") \"\(systemID ?? "")\"" : "")\(linebreak)>".data(using: .utf8)!)
    }
    
    open func parameterEntityDeclaration(name: String, value: String) {
        file.write("\(declarationInInternalSubsetIndentation)<!ENTITY % \(name) \"\(escapeDoubleQuotedValue(value))\"\(linebreak)>".data(using: .utf8)!)
    }
    
    open func elementDeclaration(name: String, text: String) {
        file.write("\(declarationInInternalSubsetIndentation)\(text)\(linebreak)".data(using: .utf8)!)
    }
    
    open func attributeListDeclaration(name: String, text: String) {
        file.write("\(declarationInInternalSubsetIndentation)\(text)\(linebreak)".data(using: .utf8)!)
    }
    
    open func internalEntity(name: String) {
        file.write("&\(name);".data(using: .utf8)!)
    }
    
    open func externalEntity(name: String) {
        file.write("&\(name);".data(using: .utf8)!)
    }

    open func documentEnd() {}
}
