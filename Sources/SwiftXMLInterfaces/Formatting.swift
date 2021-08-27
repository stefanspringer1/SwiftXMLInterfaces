//
//  Formatting.swift
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

public protocol XMLFormatter {
    
    func documentStart() -> String
    
    func xmlDeclaration(version: String, encoding: String?, standalone: String?) -> String
    
    func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) -> String
    
    func documentTypeDeclarationInternalSubsetStart() -> String
    
    func documentTypeDeclarationInternalSubsetEnd() -> String
    
    func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) -> String
    
    func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) -> String
    
    func sortedAttributeNames(attributeNames: [String]) -> [String]
    
    func attribute(name: String, value: String) -> String
    
    func elementStartAfterAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) -> String
    
    func elementEnd(name: String, hasAttributes: Bool, isEmpty: Bool) -> String
    
    func text(text: String) -> String
    
    func cdataSection(text: String) -> String
    
    func processingInstruction(target: String, content: String?) -> String
    
    func comment(text: String) -> String
    
    func internalEntityDeclaration(name: String, value: String) -> String
    
    func externalEntityDeclaration(name: String, publicID:  String?, systemID: String) -> String
    
    func unparsedEntityDeclaration(name: String, publicID:  String?, systemID: String, notation: String) -> String
    
    func notationDeclaration(name: String, publicID:  String?, systemID: String?) -> String
    
    func parameterEntityDeclaration(name: String, value: String) -> String
    
    func internalEntity(name: String) -> String
    
    func externalEntity(name: String) -> String
    
    func elementDeclaration(name: String, text: String) -> String
    
    func attributeListDeclaration(name: String, text: String) -> String

    func documentEnd() -> String
}

open class DefaultXMLFormatter: XMLFormatter {
    
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
    
    public init() {}
    
    public func setLinebreak(linebreak: String) {
        self.linebreak = linebreak
    }
    
    public func setDeclarationInInternalSubsetIndentation(indentation: String) {
        self.declarationInInternalSubsetIndentation = indentation
    }
    
    open func documentStart() -> String {
        return ""
    }
    
    open func xmlDeclaration(version: String, encoding: String?, standalone: String?) -> String {
        return "<?xml version=\"1.0\"\(encoding != nil ? " encoding=\"\(encoding ?? "?")\"" : "")\(standalone != nil ? " standalone=\"\(standalone ?? "?")\"" : "")?>\(linebreak)"
    }
    
    open func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) -> String {
        return "<!DOCTYPE \(type)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "")\(systemID != nil ? "\(publicID == nil ? " SYSTEM" : "") \"\(systemID ?? "")\"" : "")"
    }
    
    open func documentTypeDeclarationInternalSubsetStart() -> String {
        return "\(linebreak)[\(linebreak)"
    }
    
    open func documentTypeDeclarationInternalSubsetEnd() -> String {
        return "]"
    }
    
    open func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) -> String {
        return ">\(linebreak)"
    }
    
    open func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) -> String {
        return "<\(name)"
    }
    
    open func attributeValue(value: String) -> String {
        return escapeDoubleQuotedValue(value)
    }
    
    open func sortedAttributeNames(attributeNames: [String]) -> [String] {
        return attributeNames.sorted()
    }
    
    open func attribute(name: String, value: String) -> String {
        return " \(name)=\"\(attributeValue(value: value))\""
    }
    
    open func elementStartAfterAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) -> String {
        if isEmpty {
            return "/>"
        }
        else {
            return ">"
        }
    }
    
    open func elementEnd(name: String, hasAttributes: Bool, isEmpty: Bool) -> String {
        if isEmpty {
            return ""
        }
        else {
            return "</\(name)>"
        }
    }

    open func text(text: String) -> String {
        return escapeText(text)
    }
    
    open func cdataSection(text: String) -> String {
        return "<![CDATA[\(text)]]>"
    }
    
    open func processingInstruction(target: String, content: String?) -> String {
        return "<?\(target)\(content != nil ? " \"\(content ?? "")\"" : "")?>"
    }
    
    open func comment(text: String) -> String {
        return "<!--\(text)-->"
    }
    
    open func internalEntityDeclaration(name: String, value: String) -> String {
        return "\(declarationInInternalSubsetIndentation)<!ENTITY \(name) \"\(escapeDoubleQuotedValue(value))\">\(linebreak)"
    }
    
    open func externalEntityDeclaration(name: String, publicID: String?, systemID: String) -> String {
        return "\(declarationInInternalSubsetIndentation)<!ENTITY \(name)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "SYSTEM") \"\(systemID)\">\(linebreak)"
    }
    
    open func unparsedEntityDeclaration(name: String, publicID: String?, systemID: String, notation: String) -> String {
        return "\(declarationInInternalSubsetIndentation)<!ENTITY \(name)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "SYSTEM") \"\(systemID)\" NDATA \(notation)>\(linebreak)"
    }
    
    open func notationDeclaration(name: String, publicID: String?, systemID: String?) -> String {
        return "\(declarationInInternalSubsetIndentation)<!NOTATION \(name)\(publicID != nil ? " PUBLIC \"\(publicID ?? "")\"" : "")\(systemID != nil ? "\(publicID == nil ? " SYSTEM" : "") \"\(systemID ?? "")\"" : "")\(linebreak)>"
    }
    
    open func parameterEntityDeclaration(name: String, value: String) -> String {
        return "\(declarationInInternalSubsetIndentation)<!ENTITY % \(name) \"\(escapeDoubleQuotedValue(value))\"\(linebreak)>"
    }
    
    open func elementDeclaration(name: String, text: String) -> String {
        return "\(declarationInInternalSubsetIndentation)\(text)\(linebreak)"
    }
    
    open func attributeListDeclaration(name: String, text: String) -> String {
        return "\(declarationInInternalSubsetIndentation)\(text)\(linebreak)"
    }
    
    open func internalEntity(name: String) -> String {
        return "&\(name);"
    }
    
    open func externalEntity(name: String) -> String {
        return "&\(name);"
    }

    open func documentEnd() -> String {
        return ""
    }
}
