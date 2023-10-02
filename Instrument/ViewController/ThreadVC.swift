//
//  ViewController.swift
//  Instrument
//
//  Created by Dipendra Dubey on 23/09/23.
//

import UIKit

class ThreadVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "Thread Sanitiser"
        sanitiser()
    }
    
    //This issue creates sanitiser
    /*func sanitiser(){
        var array:[String] = []
        DispatchQueue.global().async {
            for index in 0...10000{
                array.append("\(index)")
            }
        }
        print(array.count)

    }
    */
    
    func sanitiser(){
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
    
    @IBAction func tapMeButtonClicked(){
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "HomeDetailVC")
        navigationController?.pushViewController(detailVC!, animated: true)
    }
}

