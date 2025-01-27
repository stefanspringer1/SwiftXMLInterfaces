//===--- Parser.swift -----------------------------------------------------===//
//
// This source file is part of the SwiftXML.org open source project
//
// Copyright (c) 2021-2023 Stefan Springer (https://stefanspringer.com)
// and the SwiftXML project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
//===----------------------------------------------------------------------===//

import Foundation
import AutoreleasepoolShim

public protocol Parser {
    func parse(
        fromData: Data,
        sourceInfo: String?,
        eventHandlers: [XEventHandler],
        internalEntityEventHandlers: [XInternalEntityEventHandler]?,
        externalEntityEventHandlers: [XInternalEntityEventHandler]?
    ) throws
}

public enum XDocumentSource {
    case url(_: URL); case path(_: String); case text(_: String); case data(_: Data)
}

public class ConvenienceParser {
    
    let parser: Parser
    let mainEventHandler: XEventHandler
    
    public init(parser: Parser, mainEventHandler: XEventHandler) {
        self.parser = parser
        self.mainEventHandler = mainEventHandler
    }
    
    public func parse(
        from documentSource: XDocumentSource,
        sourceInfo: String? = nil,
        eventHandlers: [XEventHandler]? = nil,
        internalEntityEventHandlers: [XInternalEntityEventHandler]? = nil,
        externalEntityEventHandlers: [XInternalEntityEventHandler]? = nil
    ) throws {
        switch documentSource {
        case .url(let url):
            try parse(
                fromURL: url,
                sourceInfo: sourceInfo ?? url.osPath,
                eventHandlers: eventHandlers,
                internalEntityEventHandlers: internalEntityEventHandlers,
                externalEntityEventHandlers: externalEntityEventHandlers
            )
        case .path(let path):
            try parse(
                fromPath: path,
                sourceInfo: sourceInfo ?? path,
                eventHandlers: eventHandlers,
                internalEntityEventHandlers: internalEntityEventHandlers,
                externalEntityEventHandlers: externalEntityEventHandlers
            )
        case .text(let text):
            try parse(
                fromText: text,
                sourceInfo: sourceInfo,
                eventHandlers: eventHandlers,
                internalEntityEventHandlers: internalEntityEventHandlers,
                externalEntityEventHandlers: externalEntityEventHandlers
            )
        case .data(let data):
            try parse(
                fromData: data,
                sourceInfo: sourceInfo,
                eventHandlers: eventHandlers,
                internalEntityEventHandlers: internalEntityEventHandlers,
                externalEntityEventHandlers: externalEntityEventHandlers
            )
        }
    }
    
    public func parse(
        fromPath path: String,
        sourceInfo: String? = nil,
        eventHandlers: [XEventHandler]? = nil,
        internalEntityEventHandlers: [XInternalEntityEventHandler]? = nil,
        externalEntityEventHandlers: [XInternalEntityEventHandler]? = nil
    ) throws {
        try parse(
            fromURL: URL(fileURLWithPath: path),
            sourceInfo: sourceInfo ?? path,
            eventHandlers: eventHandlers,
            internalEntityEventHandlers: internalEntityEventHandlers,
            externalEntityEventHandlers: externalEntityEventHandlers
        )
    }
    
    public func parse(
        fromURL url: URL,
        sourceInfo: String? = nil,
        eventHandlers: [XEventHandler]? = nil,
        internalEntityEventHandlers: [XInternalEntityEventHandler]? = nil,
        externalEntityEventHandlers: [XInternalEntityEventHandler]? = nil
    ) throws {
        try autoreleasepool {
            let data: Data = try Data(contentsOf: url/*, options: [.alwaysMapped]*/)
            try parse(
                fromData: data,
                sourceInfo: sourceInfo ?? url.osPath,
                eventHandlers: eventHandlers,
                internalEntityEventHandlers: internalEntityEventHandlers,
                externalEntityEventHandlers: externalEntityEventHandlers
            )
        }
    }
    
    public func parse(
        fromText text: String,
        sourceInfo: String? = nil,
        eventHandlers: [XEventHandler]? = nil,
        internalEntityEventHandlers: [XInternalEntityEventHandler]? = nil,
        externalEntityEventHandlers: [XInternalEntityEventHandler]? = nil
    ) throws {
        let _data = text.data(using: .utf8)
        if let data = _data {
            try parse(
                fromData: data,
                sourceInfo: sourceInfo,
                eventHandlers: eventHandlers,
                internalEntityEventHandlers: internalEntityEventHandlers,
                externalEntityEventHandlers: externalEntityEventHandlers
            )
        }
        else {
            throw ParseError("fatal error: could not get binary data from text") // should never happen
        }
    }
    
    public func parse(
        fromData data: Data,
        sourceInfo: String? = nil,
        eventHandlers: [XEventHandler]? = nil,
        internalEntityEventHandlers: [XInternalEntityEventHandler]? = nil,
        externalEntityEventHandlers: [XInternalEntityEventHandler]? = nil
    ) throws {
        let handlers: [XEventHandler]
        if let theEventHandlers = eventHandlers {
            handlers = [mainEventHandler] + theEventHandlers
        }
        else {
            handlers = [mainEventHandler]
        }
        try parser.parse(
            fromData: data,
            sourceInfo: sourceInfo,
            eventHandlers: handlers,
            internalEntityEventHandlers: internalEntityEventHandlers,
            externalEntityEventHandlers: externalEntityEventHandlers
        )
    }

}
