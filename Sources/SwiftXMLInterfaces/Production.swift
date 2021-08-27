//
//  XMLInterfaces.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public func escapeAll(_ text: String) -> String {
    return text
        .replacingOccurrences(of: "&", with: "&amp;")
        .replacingOccurrences(of: "<", with: "&lt;")
        .replacingOccurrences(of: ">", with: "&gt;")
        .replacingOccurrences(of: "\"", with: "&quot;")
        .replacingOccurrences(of: "'", with: "&apos;")
}

public func escapeText(_ text: String) -> String {
    return text
        .replacingOccurrences(of: "&", with: "&amp;")
        .replacingOccurrences(of: "<", with: "&lt;")
}

public func escapeDoubleQuotedValue(_ text: String) -> String {
    return text
        .replacingOccurrences(of: "&", with: "&amp;")
        .replacingOccurrences(of: "<", with: "&lt;")
        .replacingOccurrences(of: "\"", with: "&quot;")
}

public func escapeSimpleQuotedValue(_ text: String) -> String {
    return text
        .replacingOccurrences(of: "&", with: "&amp;")
        .replacingOccurrences(of: "<", with: "&lt;")
        .replacingOccurrences(of: "'", with: "&apos;")
}

public protocol XMLProduction {
    
    func set(file: FileHandle)
    
    func documentStart()
    
    func xmlDeclaration(version: String, encoding: String?, standalone: String?)
    
    func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool)
    
    func documentTypeDeclarationInternalSubsetStart()
    
    func documentTypeDeclarationInternalSubsetEnd()
    
    func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool)
    
    func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool)
    
    func attributeValue(value: String)
    
    func sortedAttributeNames(attributeNames: [String]) -> [String]
    
    func attribute(name: String, value: String)
    
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

protocol InitializableWithFile {
    init(file: FileHandle)
}

open class DefaultXMLProduction: XMLProduction, InitializableWithFile {
    
    private var file: FileHandle

    public func set(file: FileHandle) {
        self.file = file
    }
    
    private var _linebreak = "\n"
    
    public var linebreak: String {
            set {
                _linebreak = newValue
            }
            get {
                return _linebreak
            }
        }
    
    private var _declarationInInternalSubsetIndentation = " "
    
    public var declarationInInternalSubsetIndentation: String {
            set {
                _declarationInInternalSubsetIndentation = newValue
            }
            get {
                return _declarationInInternalSubsetIndentation
            }
        }
    
    required public init(file: FileHandle) {
        self.file = file
    }
    
    open func write(_ s: String) {
        file.write(s.data(using: .utf8)!)
    }
    
    open func documentStart() {
        // -
    }
    
    open func xmlDeclaration(version: String, encoding: String?, standalone: String?) {
        write("<?xml version=\"1.0\"")
        if let theEncoding = encoding {
            write(" encoding=\"")
            write(theEncoding)
            write("\"")
        }
        if let theStandalone = standalone {
            write(" standalone=\"")
            write(theStandalone)
            write("\"")
        }
        write("?>")
        write(linebreak)
    }
    
    open func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) {
        write("<!DOCTYPE ")
        write(type)
        if let thePublicID = publicID {
            write(" PUBLIC \"")
            write(thePublicID)
            write("\"")
        }
        if let theSystemID = systemID {
            if publicID == nil {
                write(" SYSTEM")
            }
            write(" \"")
            write(theSystemID)
            write("\"")
        }
    }
    
    open func documentTypeDeclarationInternalSubsetStart() {
        write(linebreak)
        write("[")
        write(linebreak)
    }
    
    open func documentTypeDeclarationInternalSubsetEnd() {
        write("]")
    }
    
    open func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) {
        write(">")
        write(linebreak)
    }
    
    open func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) {
        write("<")
        write(name)
    }
    
    
    open func attributeValue(value: String) {
        write(escapeDoubleQuotedValue(value))
    }
    
    open func sortedAttributeNames(attributeNames: [String]) -> [String] {
        return attributeNames.sorted()
    }
    
    open func attribute(name: String, value: String) {
        write(" ")
        write(name)
        write("\"")
        attributeValue(value: value)
        write("\"")
    }
    
    open func elementStartAfterAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) {
        if isEmpty {
            write("/>")
        }
        else {
            write(">")
        }
    }
    
    open func elementEnd(name: String, hasAttributes: Bool, isEmpty: Bool) {
        if !isEmpty {
            write("</")
            write(name)
            write(">")
        }
    }
    
    open func text(text: String) {
        write(escapeText(text))
    }
    
    open func cdataSection(text: String) {
        write("<![CDATA[")
        write(text)
        write("]]>")
    }
    
    open func processingInstruction(target: String, content: String?) {
        write("<?")
        write(target)
        if let theContent = content {
            write(" \"")
            write(theContent)
            write("\"")
        }
        write("?>")
    }
    
    open func comment(text: String) {
      write("<!--")
      write(text)
      write("-->")
    }
    
    open func internalEntityDeclaration(name: String, value: String) {
        write(declarationInInternalSubsetIndentation)
        write("<!ENTITY ")
        write(name)
        write(" \"")
        write(escapeDoubleQuotedValue(value))
        write(">")
        write(linebreak)
    }
    
    open func externalEntityDeclaration(name: String, publicID: String?, systemID: String) {
        write(declarationInInternalSubsetIndentation)
        write("<!ENTITY ")
        write(name)
        if let thePublicID = publicID {
            write("PUBLIC \"")
            write(thePublicID)
            write("\" \"")
        }
        else {
            write("SYSTEM \"")
        }
        write(systemID)
        write("\">")
        write(linebreak)
    }
    
    open func unparsedEntityDeclaration(name: String, publicID: String?, systemID: String, notation: String) {
        write(declarationInInternalSubsetIndentation)
        write("<!ENTITY ")
        write(name)
        if let thePublicID = publicID {
            write("PUBLIC \"")
            write(thePublicID)
            write("\" \"")
        }
        else {
            write("SYSTEM \"")
        }
        write(systemID)
        write("\" NDATA ")
        write(notation)
        write(">")
        write(linebreak)
    }
    
    open func notationDeclaration(name: String, publicID: String?, systemID: String?) {
        write(declarationInInternalSubsetIndentation)
        write("<!NOTATION ")
        write(name)
        if let thePublicID = publicID {
            write("PUBLIC \"")
            write(thePublicID)
            write("\"")
        }
        if let theSystemID = systemID {
            if publicID == nil {
                write(" SYSTEM")
            }
            write(" \"")
            write(theSystemID)
            write("\"")
        }
        write(">")
        write(linebreak)
    }
    
    open func parameterEntityDeclaration(name: String, value: String) {
        write(declarationInInternalSubsetIndentation)
        write("<!ENTITY % ")
        write(name)
        write(" \"")
        write(escapeDoubleQuotedValue(value))
        write("\">")
        write(linebreak)
    }
    
    open func elementDeclaration(name: String, text: String) {
        write(declarationInInternalSubsetIndentation)
        write(text)
        write(linebreak)
    }
    
    open func attributeListDeclaration(name: String, text: String) {
        write(declarationInInternalSubsetIndentation)
        write(text)
        write(linebreak)
    }
    
    open func internalEntity(name: String) {
        write("&")
        write(name)
        write(";")
    }
    
    open func externalEntity(name: String) {
        write("&")
        write(name)
        write(";")
    }

    open func documentEnd() {
        // -
    }
}
