//
//  FileManager+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

import Foundation

extension FileManager {
    
    public static let localCachePath: URL? = FileManager.default.urls(for: .cachesDirectory,
                                                               in: .userDomainMask)[0]
}
