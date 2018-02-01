#!/usr/bin/env xcrun swift
//
//  main.swift
//  AbandonedStrings
//
//  Created by Joshua Smith on 2/1/16.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//

/*
 For overview and usage information refer to https://github.com/ijoshsmith/abandoned-strings
 */

import Foundation

func findFilesIn(_ directories: [String], withExtensions extensions: [String]) -> [String] {
    
    let fileManager = FileManager.default
    var files = [String]()
    for directory in directories {
        
        guard let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: directory) else {
            print("Failed to create enumerator for directory: \(directory)")
            return []
        }
        while let path = enumerator.nextObject() as? String {
            
            let fileExtension = (path as NSString).pathExtension.lowercased()
            if extensions.contains(fileExtension) {
                
                let fullPath = (directory as NSString).appendingPathComponent(path)
                files.append(fullPath)
            }
        }
    }
    return files
}

func contentsOfFile(_ filePath: String) -> String {
    
    do {
        return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    }
    catch { return "" }
}

func concatenateAllSourceCodeIn(_ directories: [String]) -> String {
    
    let extensions = ["m", "swift"]
    let sourceFiles = findFilesIn(directories, withExtensions: extensions)
    print("Looking in \(sourceFiles.count) source files ...")
    
    return sourceFiles.reduce("") { (accumulator, sourceFile) -> String in
        
        return accumulator + contentsOfFile(sourceFile)
    }
}

func extractStringIdentifiersFrom(_ stringsFile: String) -> [String] {
    
    return contentsOfFile(stringsFile).components(separatedBy: "\n").map    { $0.trimmingCharacters(in: CharacterSet.whitespaces) }.map{ extractStringIdentifierFromTrimmedLine($0) }.filter { $0 != nil } as! [String]
}

func extractStringIdentifierFromTrimmedLine(_ line: String) -> String? {
    
    if let i = line.index(of: "*") {
        
        let indexAfterFirstQuote = line.index(i, offsetBy: " const ".count + 1)
        let lineWithoutFirstQuote = line[indexAfterFirstQuote...]
        if let equalIndex = lineWithoutFirstQuote.index(of:"=") {
            
            let lastIndex = line.index(before: equalIndex)
            let identifier = lineWithoutFirstQuote[..<lastIndex]
            
            return String(identifier)
        }
    }
    return nil
}

func findStringIdentifiersIn(_ stringsFile: String, abandonedBySourceCode sourceCode: String) -> [String]? {
    
    return extractStringIdentifiersFrom(stringsFile).filter { identifier in
        
        return sourceCode.contains("\(identifier)") == false
    }
}

func findAbandonedIdentifiersIn(_ rootDirectories: [String]) ->
    [String] {
        
        var unusedStrings = [String]()
        let sourceCode = concatenateAllSourceCodeIn(rootDirectories)
        
        if let abandonedIdentifiers = findStringIdentifiersIn(file, abandonedBySourceCode: sourceCode) {
            
            if abandonedIdentifiers.isEmpty == false {
                
                unusedStrings = abandonedIdentifiers
                print("---------- Found \(abandonedIdentifiers.count) unused strings ------")
                print(abandonedIdentifiers)
                print("---------- Found \(abandonedIdentifiers.count) unused strings ------")
                
            } else {
                print("All strings are used")
            }
        }
        
        return unusedStrings
}

func getRootDirectories() -> [String]? {
    
    var c = [String]()
    for arg in CommandLine.arguments {
        c.append(arg)
    }
    c.remove(at: 0)
    
    if c.count > 1 {
        
        file = c[1]
    }
    return c
}

var file = ""

if let rootDirectories = getRootDirectories() {
    
    print("Searching for abandoned resource strings…")
    
    let map = findAbandonedIdentifiersIn(rootDirectories)
    if map.isEmpty {
        
        print("No abandoned resource strings were detected.")
    }
    
} else {
    
    print("Please provide the root directory for the project files as a command line argument.")
}

