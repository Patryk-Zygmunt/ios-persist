//
//  CoreService.swift
//  Persist
//
//  Created by Student on 10/01/2020.
//  Copyright © 2020 user163099. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreService{


private var context: NSManagedObjectContext {
    
        let appDelegate =
           UIApplication.shared.delegate as? AppDelegate
    return appDelegate!.persistentContainer.viewContext
}



func saveSensor(name: String, desc:String, readings: [Reading]) {
 
    let sensor  = SensorEntity(context:context)
    sensor.name = name
    sensor.desc = "sdsdsds"
    for r in readings{
        let re  = ReadingsEntity(context: context)
        re.sensor = sensor
        re.timestamp = r.timestamp
        re.value = r.value
    }

    do {
        try context.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
    }
    
    
  func loadREadings(name:String)->[ReadingsEntity]{
        let fr = NSFetchRequest<ReadingsEntity>(entityName: "ReadingsEntity")
    do {
          let sensor = try self.context.fetch(fr)
        return sensor
      } catch let error as NSError {
          print("Could not read. \(error), \(error.userInfo)")
      }
    return []
    }
    
    
    
    
    func findByFunction(queryFun:String)->Double?{
let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
request.entity = NSEntityDescription.entity(forEntityName: "ReadingsEntity", in: self.context)
request.resultType = NSFetchRequestResultType.dictionaryResultType



//4.
request.propertiesToFetch = [expressionForFun(queryFun: queryFun)]
let key = queryFun

var maxTimestamp: Double? = nil

do {
    //5.
    if let result = try self.context.fetch(request) as? [[String: Double]], let dict = result.first {
       maxTimestamp = dict[key]
    }

} catch {
    assertionFailure("Failed to fetch max timestamp with error = \(error)")
    return nil
}

return maxTimestamp
    }
    
    
   private func expressionForFun(queryFun:String)->NSExpressionDescription{
        let keypathExpression = NSExpression(forKeyPath: "timestamp")
        let expression = NSExpression(forFunction: queryFun, arguments: [keypathExpression])

        let key = queryFun

        //3.
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = key
        expressionDescription.expression = expression
        expressionDescription.expressionResultType = .doubleAttributeType
        return expressionDescription;
        
    }
    
    
        func findByFunctionGroup()->[[String: Double]]?{
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
    request.entity = NSEntityDescription.entity(forEntityName: "ReadingsEntity", in: self.context)
    request.resultType = NSFetchRequestResultType.dictionaryResultType
            request.propertiesToGroupBy = ["sensor"]
            
    request.propertiesToFetch = [expressionForFun(queryFun: "average:"),expressionForFun(queryFun: "count:")]


    do {
        if let result = try self.context.fetch(request) as? [[String: Double]] {
            return result
        }

    } catch {
        assertionFailure("Failed to fetch max timestamp with error = \(error)")
        return nil
    }

    return nil
        }
        
    
    
    
    
    
    
    
    
    
    
    
        
        func deleteAll(){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SensorEntity")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            let fetchRequestr = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadingsEntity")
               let deleteRequestr = NSBatchDeleteRequest(fetchRequest: fetchRequestr)

    do {
        try self.context.execute(deleteRequest)
        try self.context.execute(deleteRequestr)
    } catch let error as NSError {
        // TODO: handle the error
    }
        }

    
}


