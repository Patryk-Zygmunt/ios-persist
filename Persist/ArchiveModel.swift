//
//  ArchiveModel.swift
//  Persist
//
//  Created by user163099 on 1/8/20.
//  Copyright © 2020 user163099. All rights reserved.
//

import Foundation


struct SensorKey{
   static let description = "desc"
   static let  name = "name"
}

struct ReadingKey{
   static let timestamp = "timestamp"
   static let  value = "value"
    static let sensor = "sensor"
}
class Sensor:NSObject,NSCoding{
    var desc: String
    var name:String
    
    init(description:String,name:String){
        self.name = name
        self.desc = description
    }
 
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey:SensorKey.name)
        coder.encode(desc, forKey:SensorKey.description)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let desc = aDecoder.decodeObject(forKey:SensorKey.description) as! String
         let name = aDecoder.decodeObject(forKey:SensorKey.name) as! String
        
         

        // now (we must) call the designated initializer
        self.init(description: desc,name: name)
    }

}

class Reading:NSObject,NSCoding{
    var timestamp: Double
    var sensor:String
    var value:Double
    
    init(timestamp:Double,sensor:String,value:Double){
        self.timestamp = timestamp
        self.sensor = sensor
        self.value = value
    }
 
    
    func encode(with coder: NSCoder) {
        coder.encode(timestamp, forKey:ReadingKey.timestamp)
        coder.encode(sensor, forKey:ReadingKey.sensor)
        coder.encode(value, forKey: ReadingKey.value)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let sensor = aDecoder.decodeObject(forKey:ReadingKey.sensor) as! String
        let timestamp = aDecoder.decodeDouble(forKey:ReadingKey.timestamp)
         let value = aDecoder.decodeDouble(forKey:ReadingKey.value)
         

        // now (we must) call the designated initializer
        self.init(timestamp: timestamp,sensor: sensor,value: value)
    }

}
