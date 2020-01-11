//
//  ArchivierService.swift
//  Persist
//
//  Created by user163099 on 1/8/20.
//  Copyright © 2020 user163099. All rights reserved.
//

import Foundation

class ArchiveService{

    
    
   static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
   static  let path = DocumentsDirectory.appendingPathComponent("sensors").path
    static  let pathReadings = DocumentsDirectory.appendingPathComponent("readings4").path

  static  func saveSensor(sensor:[Sensor])->Bool{
    let succes = NSKeyedArchiver.archiveRootObject(sensor,toFile:ArchiveService.path)
    return succes
}

 static  func getSensors()->[Sensor]?{
    return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveService.path) as? [Sensor]
}

    
   static   func saveReadings(r:[Reading])->Bool{
        let succes = NSKeyedArchiver.archiveRootObject(r,toFile:ArchiveService.pathReadings)
        return succes
    }
   static   func getReadings()->[Reading]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveService.pathReadings) as? [Reading]
    }


}
