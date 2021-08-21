//
//  XMLInterfaces.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

public protocol XMLProduction {
    
    func set(file: FileHandle)
    
    func documentStart()
    
    func xmlDeclaration(version: String, encoding: String?, standalone: String?)
    
    func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool)
    
    func documentTypeDeclarationInternalSubsetStart()
    
    func documentTypeDeclarationInternalSubsetEnd()
    
    func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool)
    
    func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool)
    
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

open class DefaultXMLProduction: XMLProduction {

    private var formatter: XMLFormatter
    
    private var file: FileHandle

    public func set(formatter: XMLFormatter) {
        self.formatter = formatter
    }
    
    public func set(file: FileHandle) {
        self.file = file
    }
    
    public init(formatter: XMLFormatter = DefaultXMLFormatter(), file: FileHandle = FileHandle.standardOutput) {
        self.formatter = formatter
        self.file = file
    }
    
    open func documentStart() {
        file.write(formatter.documentStart().data(using: .utf8)!)
    }
    
    open func xmlDeclaration(version: String, encoding: String?, standalone: String?) {
        file.write(formatter.xmlDeclaration(version: version, encoding: encoding, standalone: standalone).data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationBeforeInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) {
        file.write(formatter.documentTypeDeclarationBeforeInternalSubset(type: type, publicID: publicID, systemID: systemID, hasInternalSubset: hasInternalSubset).data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationInternalSubsetStart() {
        file.write(formatter.documentTypeDeclarationInternalSubsetStart().data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationInternalSubsetEnd() {
        file.write(formatter.documentTypeDeclarationInternalSubsetEnd().data(using: .utf8)!)
    }
    
    open func documentTypeDeclarationAfterInternalSubset(type: String, publicID: String?, systemID: String?, hasInternalSubset: Bool) {
        file.write(formatter.documentTypeDeclarationAfterInternalSubset(type: type, publicID: publicID, systemID: systemID, hasInternalSubset: hasInternalSubset).data(using: .utf8)!)
    }
    
    open func elementStartBeforeAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) {
        file.write(formatter.elementStartBeforeAttributes(name: name, hasAttributes: hasAttributes, isEmpty: isEmpty).data(using: .utf8)!)
    }
    
    open func attribute(name: String, value: String) {
        file.write(formatter.attribute(name: name, value: value).data(using: .utf8)!)
    }
    
    open func elementStartAfterAttributes(name: String, hasAttributes: Bool, isEmpty: Bool) {
        file.write(formatter.elementStartAfterAttributes(name: name, hasAttributes: hasAttributes, isEmpty: isEmpty).data(using: .utf8)!)
    }
    
    open func elementEnd(name: String, hasAttributes: Bool, isEmpty: Bool) {
        file.write(formatter.elementEnd(name: name, hasAttributes: hasAttributes, isEmpty: isEmpty).data(using: .utf8)!)
    }
    
    open func text(text: String) {
        file.write(formatter.text(text: text).data(using: .utf8)!)
    }
    
    open func cdataSection(text: String) {
        file.write(formatter.cdataSection(text: text).data(using: .utf8)!)
    }
    
    open func processingInstruction(target: String, content: String?) {
        file.write(formatter.processingInstruction(target: target, content: content).data(using: .utf8)!)
    }
    
    open func comment(text: String) {
        file.write(formatter.comment(text: text).data(using: .utf8)!)
    }
    
    open func internalEntityDeclaration(name: String, value: String) {
        file.write(formatter.internalEntityDeclaration(name: name, value: value).data(using: .utf8)!)
    }
    
    open func externalEntityDeclaration(name: String, publicID: String?, systemID: String) {
        file.write(formatter.externalEntityDeclaration(name: name, publicID: publicID, systemID: systemID).data(using: .utf8)!)
    }
    
    open func unparsedEntityDeclaration(name: String, publicID: String?, systemID: String, notation: String) {
        file.write(formatter.unparsedEntityDeclaration(name: name, publicID: publicID, systemID: systemID, notation: notation).data(using: .utf8)!)
    }
    
    open func notationDeclaration(name: String, publicID: String?, systemID: String?) {
        file.write(formatter.notationDeclaration(name: name, publicID: publicID, systemID: systemID).data(using: .utf8)!)
    }
    
    open func parameterEntityDeclaration(name: String, value: String) {
        file.write(formatter.parameterEntityDeclaration(name: name, value: value).data(using: .utf8)!)
    }
    
    open func elementDeclaration(name: String, text: String) {
        file.write(formatter.elementDeclaration(name: name, text: text).data(using: .utf8)!)
    }
    
    open func attributeListDeclaration(name: String, text: String) {
        file.write(formatter.attributeListDeclaration(name: name, text: text).data(using: .utf8)!)
    }
    
    open func internalEntity(name: String) {
        file.write(formatter.internalEntity(name: name).data(using: .utf8)!)
    }
    
    open func externalEntity(name: String) {
        file.write(formatter.externalEntity(name: name).data(using: .utf8)!)
    }

    open func documentEnd() {
        file.write(formatter.documentEnd().data(using: .utf8)!)
    }
}
