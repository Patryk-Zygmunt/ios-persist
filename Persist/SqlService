//
//  SQLiteService.swift
//  tomada2
//
//  Created by Tomek on 13/01/2020.
//  Copyright © 2020 Tomek. All rights reserved.
//

import UIKit
import SQLite3

class SQLiteService {

    var db: OpaquePointer?

    func initDb(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("database.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Sensors", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Readings", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Sensors (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, desc TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Readings (id INTEGER PRIMARY KEY AUTOINCREMENT, timestamp REAL, value REAL, sensorName REFERENCES Sensors(name))", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        print("init")
    }
    
    func insertValues(values: [Sensor: [Reading]]){
        var stmt: OpaquePointer?
        let insertSensorsString = "INSERT INTO Sensors (name, desc) VALUES (?,?)"
        let insertReadingsString = "INSERT INTO Readings (timestamp, value, sensorName) VALUES (?,?,?)"
        for (se,re) in values{
            //sensor
            if sqlite3_prepare(db, insertSensorsString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            if sqlite3_bind_text(stmt, 1, (se.name as NSString).utf8String, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding 1: \(errmsg)")
                return
            }
            if sqlite3_bind_text(stmt, 2, (se.desc as NSString).utf8String, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding 2: \(errmsg)")
                return
            }
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting hero: \(errmsg)")
                return
            }
            
            for i in 0..<re.count{
                //readingi dla sensora
                if sqlite3_prepare(db, insertReadingsString, -1, &stmt, nil) != SQLITE_OK{
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("error preparing insert: \(errmsg)")
                    return
                }
                if sqlite3_bind_double(stmt, 1, re[i].timestamp) != SQLITE_OK{
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("failure binding 1: \(errmsg)")
                    return
                }
                if sqlite3_bind_double(stmt, 2, re[i].value) != SQLITE_OK{
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("failure binding 2: \(errmsg)")
                    return
                }
                
                if sqlite3_bind_text(stmt, 3, (re[i].sensor as NSString).utf8String, -1, nil) != SQLITE_OK{
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("failure binding 2: \(errmsg)")
                    return
                }
                if sqlite3_step(stmt) != SQLITE_DONE {
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("failure inserting hero: \(errmsg)")
                    return
                }
            }
            print("insert")
        }
        
    
    }
    
    func findLargestAndSmallestTimestamp(){
        var stmt: OpaquePointer?
        let queryString1 = "SELECT MIN(timestamp), MAX(timestamp) FROM Readings"
        if sqlite3_prepare(db, queryString1, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let min = String(cString: sqlite3_column_text(stmt, 0))
            let max = String(cString: sqlite3_column_text(stmt, 1))
            print(min)
            print(max)
        }
    }
    
    func getAverage(){
        var stmt: OpaquePointer?
        let queryString = "SELECT AVG(value) FROM Readings"
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let max = String(cString: sqlite3_column_text(stmt, 0))
            print(max)
        }
    }
    
    func getAverageGrouped(){
        var stmt: OpaquePointer?
        let queryString = "SELECT name, COUNT(*), AVG(value) FROM Readings INNER JOIN Sensors ON Readings.sensorName = Sensors.name GROUP BY name"
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let a = String(cString: sqlite3_column_text(stmt, 0))
            let b = String(cString: sqlite3_column_text(stmt, 1))
            let c = String(cString: sqlite3_column_text(stmt, 2))
            print(a)
            print(b)
            print(c)
        }
    }
    
//    func getSensors(){
//        var stmt: OpaquePointer?
//        let queryString = "SELECT * FROM Sensors"
//        let readingsQueryString = "SELECT * FROM Readings"
//
//        if sqlite3_prepare(db, readingsQueryString, -1, &stmt, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errmsg)")
//            return
//        }
//
//        print("READINGI")
//        while(sqlite3_step(stmt) == SQLITE_ROW){
//            let a = String(cString: sqlite3_column_text(stmt, 2))
//            let b = String(cString: sqlite3_column_text(stmt, 3))
//            print(a)
//            print(b)
//        }
//        print("KONIEC READINGOW")
//    }
    
}
