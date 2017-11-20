//
//  FileProcessing.swift
//  movsea
//
//  Created by Movsea Team on 5/4/16.
//  Copyright © 2017 Movsea Team.
//

import Foundation

extension FileManager {
    class func getOutputFile(_ fileName: String! = "output.mov") -> URL! {
        let destanationURL = self.getSavedOutput(fileName)
        let path = destanationURL?.path
        let fileManager = self.default
        
        if fileManager.fileExists(atPath: path!) {
            try! fileManager.removeItem(atPath: path!)
        }

        return destanationURL
    }
    
    class func getSavedOutput(_ fileName: String! = "output.mov") -> URL! {

        let fileManager = self.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory:URL = urls.first!
        let destanationURL = documentDirectory.appendingPathComponent(fileName)
        
        #if arch(i386) || arch(x86_64)
            return Bundle.main.url(forResource: "Test", withExtension: "txt")!
        #else
            return destanationURL
        #endif
    }
}


let dateFormatter = DateFormatter()

extension DateFormatter {
    
    class func getSyncString(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm, dd.MM"
        return dateFormatter.string(from: date)
    }
    
}
