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
   static  let path = DocumentsDirectory.appendingPathComponent("sensors")
    
    static  let pathReadings = DocumentsDirectory.appendingPathComponent("readings4")

  static  func saveSensor(sensor:[Sensor])->Double?{

    do {
    let startTime = NSDate()

let data = try NSKeyedArchiver.archivedData(withRootObject: sensor,
requiringSecureCoding: false)
        let finishTime = NSDate()
        let measuredTime = finishTime.timeIntervalSince(startTime as Date)


try data.write(to: path)
        return measuredTime
} catch {
print("Couldn't write file")
}
    return nil
}

 static  func getSensors()->[Sensor]?{
    
    return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveService.path.path) as? [Sensor]
}

    
   static   func saveReadings(r:[Reading])->Double?{
       
            do {
                let startTim:NSDate = NSDate()

        let data = try NSKeyedArchiver.archivedData(withRootObject: r,requiringSecureCoding: false)
                let finishTime = NSDate()
                let measuredTime = finishTime.timeIntervalSince(startTim as Date)


        try data.write(to: pathReadings)
                return measuredTime
        } catch {
        print("Couldn't write file")
        }
            return nil
    }
    
   static   func getReadings()->[Reading]?{
    return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveService.pathReadings.path) as? [Reading]
    }





static func average(nums: [Double]) -> Double {

    var total = 0.0
    for vote in nums{
        total += Double(vote)
    }

    let votesTotal = Double(nums.count)
    var average = total/votesTotal
    return average
}
}

