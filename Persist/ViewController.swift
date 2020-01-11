//
//  ViewController.swift
//  Persist
//
//  Created by user163099 on 1/8/20.
//  Copyright © 2020 user163099. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var t1: UITextField!
    
    @IBOutlet weak var t2: UITextField!
    
    @IBOutlet weak var t3: UITextField!
    
    @IBOutlet weak var t4: UITextField!
    
    @IBOutlet weak var amount: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var data=[Sensor: [Reading]]()
    var rd:[Reading] = []
    var sd :[Sensor] = []

    var   sarr = [Sensor(description: "dddd", name: "nnnnnn"),Sensor(description: "dddd2", name: "nnnnnn2")]

    
    @IBAction func g(_ sender: Any) {
        let n :Int = Int(amount.text!)!
        let s = Array(0...20).map({(v)->Sensor in
  return Sensor(description:"Sensor number " + String(v),name:"S"+String(v))})
   sd = s
        
var m =  s.reduce([Sensor: [Reading]]()) { (dict, s) -> [Sensor: [Reading]] in
    var dict = dict
    dict[s] = []
    return dict
}
let r  = Array(0...n).map({(v)->Reading in
let se = "S" + String(Int.random(in: 0...20))
var  t = Double.random(in:0...31556926)
t.round()
let nr = Reading(timestamp:Double(t),sensor:se,value:Double.random(in:0...100))
m[s.first(where:{$0.name==se})!]!.append(nr)
return nr
})
        rd = r
        data = m
        
        
    }
    
    
    @IBAction func a(_ sender: Any) {
        archive()
    }
    
    
    @IBAction func s(_ sender: Any) {
    }
    
    @IBAction func c(_ sender: Any) {
        coreData()
    }
    
    
    func coreData(){
        
        let s = CoreService()
        s.deleteAll()
        var startTime = NSDate()
        for (se,re) in data{
s.saveSensor(name: se.name, desc: se.desc, readings: re)
    }
        
      //  print(s.loadREadings(name: "S1"))
var finishTime = NSDate()
        var measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t1.text = String(measuredTime)
        startTime = NSDate()
        print(s.findByFunction(queryFun: "max:"))
        print(s.findByFunction(queryFun: "min:"))
        finishTime = NSDate()
        measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t2.text = String(measuredTime)
        startTime = NSDate()

        print(s.findByFunction(queryFun: "average:"))
        finishTime = NSDate()
        measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t3.text = String(measuredTime)
        startTime = NSDate()

        print(s.findByFunctionGroup())
        finishTime = NSDate()
        measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t4.text = String(measuredTime)

        //print(s.loadData(name: se.name))
        
        
    }
    func archive(){
              let st  = ArchiveService.saveSensor(sensor:sd)
        let rt  = ArchiveService.saveReadings(r: rd)
        t1.text = String(st!+rt!)

        let r:[Reading] = ArchiveService.getReadings()!
          var startTime = NSDate()
        var mx = r.map({$0.timestamp}).max()!
        var mi = r.map({$0.timestamp}).min()!
        var finishTime = NSDate()
        var measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t2.text = String(measuredTime)
       print(mx)
        startTime = NSDate()
        ArchiveService.average(nums: r.map({$0.timestamp}))
        finishTime = NSDate()
        measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t3.text = String(measuredTime)

        startTime = NSDate()
        let d = Dictionary(grouping: r, by: { $0.sensor })
        var nd :[String:[Double]] = Dictionary()
        for(se,re) in d{
            nd[se] = [Double(re.capacity) ,ArchiveService.average(nums: re.map({$0.timestamp})) ]
            
        }
        
        finishTime = NSDate()
        measuredTime = finishTime.timeIntervalSince(startTime as Date)
        t4.text = String(measuredTime)
        print(nd)

     

    }
    
    
}

