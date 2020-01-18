//
//  LiteService.swift
//  Persist
//
//  Created by user165769 on 1/18/20.
//  Copyright © 2020 user163099. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class LiteService {

    
    init(){
            let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
               .appendingPathComponent("sqlite")
           sqlite3_open(url.path, &db)
           sqlite3_exec(db, "DROP TABLE IF EXISTS Sensors", nil, nil, nil)
           sqlite3_exec(db, "DROP TABLE IF EXISTS Readings", nil, nil, nil)
           sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Sensors (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, desc TEXT)", nil, nil, nil)
           sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Readings (id INTEGER PRIMARY KEY AUTOINCREMENT, timestamp REAL, value REAL, sensorName REFERENCES Sensors(name))", nil, nil, nil)
    }
    
    
    var db: OpaquePointer?


    
    
    func SaveSensor(se: Sensor,  r : [Reading]){
        var stmt: OpaquePointer?
            sqlite3_prepare(db, "INSERT INTO Sensors (name, desc) VALUES (?,?)", -1, &stmt, nil)
            sqlite3_bind_text(stmt, 1, (se.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (se.desc as NSString).utf8String, -1, nil)
            sqlite3_step(stmt)
            for ri in r{
                saveRedaings(r: ri)
        }
        
    
    }
    
    func saveRedaings(r:Reading){
        var pointer: OpaquePointer?
         sqlite3_prepare(db, "INSERT INTO Readings (timestamp, value, sensorName) VALUES (?,?,?)", -1, &pointer, nil)
         sqlite3_bind_double(pointer, 1, r.timestamp)
        sqlite3_bind_double(pointer, 2, r.value)
        sqlite3_bind_text(pointer, 3, (r.sensor as NSString).utf8String, -1, nil)
        sqlite3_step(pointer)
        
    }
    
    
    func findReadings(query:String)->Any{
        var stmt: OpaquePointer?
        sqlite3_prepare(db, query, -1, &stmt, nil)
       sqlite3_step(stmt)
        return String(cString: sqlite3_column_text(stmt, 0)!)
           
        }

    
    func findGroupedAverge(){
        var stmt: OpaquePointer?
        let query =  "SELECT COUNT(1), AVG(value) FROM Readings INNER JOIN Sensors ON Readings.sensorName = Sensors.name GROUP BY name"
       sqlite3_prepare(db, query, -1, &stmt, nil)
           while(sqlite3_step(stmt) == SQLITE_ROW){
            print(String(cString: sqlite3_column_text(stmt, 0)) + " " + String(cString: sqlite3_column_text(stmt, 1)))
        }
    }
    
}
