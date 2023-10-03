//
//  ViewController.swift
//  Instrument
//
//  Created by Dipendra Dubey on 23/09/23.
//

import UIKit

class ThreadVC: UIViewController{
    
    let threadHandler = ThreadHandler()
    @IBOutlet var lblCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "Thread Sanitiser"
        //fixRaceBySerialQueue()
        fixRaceByActor()
        //print (lblCount.text)
        getUpdateValue()
    }
    
    //This issue creates Race condition can be detected by Thread Sanitizer
    /*func createRace(){
        var array:[String] = []
        DispatchQueue.global().async {
            for index in 0...10000{
                array.append("\(index)")
            }
        }
        print(array.count)

    }
    */
    
    //Fixed the race condition by serial queue
    func fixRaceBySerialQueue(){
        var array:[String] = []
        let queue  = DispatchQueue(label: "com.abc.def")
        //DispatchQueue.global().async {
            queue.async {
                for index in 0...10000{
                    array.append("\(index)")
                }
            }
            
        //}
        queue.async {
            print(array.count)
        }
        

    }
    
    //Fixed the race condition by using Actor
    
    func fixRaceByActor(){
        DispatchQueue.global(qos: .userInitiated).async{[self] in
            Task{await self.threadHandler.getUpdateValue()}
        }
        
    }
    
    @MainActor
    func getUpdateValue(){
        Task{
            lblCount.text = "\(await self.threadHandler.getCount())"
        }
    }
    
}

