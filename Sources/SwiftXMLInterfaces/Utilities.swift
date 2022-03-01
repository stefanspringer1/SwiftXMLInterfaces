//
//  Utilities.swift
//
//  Created 2022 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation

enum Platform {
    case macOSIntel
    case macOSARM
    case LinuxIntel
    case WindowsIntel
    case Unknown
    public var description: String? {
        switch self {
        case .macOSARM: return "macOS.ARM"
        case .macOSIntel: return "macOS.Intel"
        case .LinuxIntel: return "RedHat7.Intel" //TODO: Fix mismatch.
        case .WindowsIntel: return "Windows.Intel"
        case .Unknown: return nil
        }
    }
}

func platform() -> Platform {
    #if os(macOS)
        #if arch(x86_64)
            return Platform.macOSIntel
        #else
            return Platform.macOSARM
        #endif
    #elseif os(Linux)
        #if arch(x86_64)
            return Platform.LinuxIntel
        #else
            return Platform.Unknown
        #endif
    #else
        #if arch(x86_64)
            return Platform.WindowsIntel
        #else
            return Platform.Unknown
        #endif
    #endif
}

func pathSeparator() -> String {
    return platform() == Platform.WindowsIntel ? "\\" : "/"
}

extension URL {
    var osPath: String {
        get {
            self.path.replacingOccurrences(of: "/", with: pathSeparator())
        }
    }
}
