//
//  ViewController.swift
//  Instrument
//
//  Created by Dipendra Dubey on 23/09/23.
//

import UIKit

class HomeVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Screen"
    }
    
    @IBAction func leakTimeProfileClicked(){
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "HomeDetailVC")
        navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    @IBAction func threadSanitiserClicked(){
        //Shortcut to navigation
        show(ThreadVC(), sender: self)
    }
}

