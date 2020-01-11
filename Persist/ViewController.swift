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
coreData()
    }


    var   sarr = [Sensor(description: "dddd", name: "nnnnnn"),Sensor(description: "dddd2", name: "nnnnnn2")]

    
    @IBAction func g(_ sender: Any) {
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
        
        var   rarr = [Reading(timestamp: Double(21312312), sensor:sarr[0].name, value: Double(2334)),
        Reading(timestamp: Double(2112), sensor:sarr[1].name, value: Double(234)),Reading(timestamp: Double(12), sensor:sarr[1].name, value: Double(234)) ]
        let s = CoreService()
        s.deleteAll()
        let se = sarr[0]
        let se1 = sarr[1]
        let startTime = NSDate()
s.saveSensor(name: se.name, desc: se.desc, readings: [rarr[0]])
s.saveSensor(name: se1.name, desc: se1.desc, readings: [rarr[1],rarr[2]])
let finishTime = NSDate()
        let measuredTime = finishTime.timeIntervalSince(startTime as Date)
        print(measuredTime)
        t1.text = String(measuredTime)
       // print(s.loadREadings(name: "sdsd"))
      //  print(s.findByFunction(queryFun: "average:"))
        print(s.findByFunctionGroup())

        //print(s.loadData(name: se.name))
        
        
    }
    func archive(){
              let s  = ArchiveService.saveSensor(sensor:sarr)
              print(s)
              print(ArchiveService.getSensors()![0].desc)
              var   rarr = [Reading(timestamp: Double(21312312), sensor:sarr[0].name, value: Double(234)),
                            Reading(timestamp: Double(2112), sensor:sarr[0].name, value: Double(234))        ]

              let r  = ArchiveService.saveReadings(r: rarr)
              print(r)
              print(ArchiveService.getReadings()![0].timestamp)
    }
    
    
}

