//
//  HomeDetailViewController.swift
//  Instrument
//
//  Created by Dipendra Dubey on 24/09/23.
//

import UIKit

class HomeDetailVC: UIViewController, DataProtocol, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tblView: UITableView!
    var dataArray = [String]()
    var dataFetcher = DataFetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        dataFetcher.dataProtocol = self
        dataFetcher.getData()
        // Do any additional setup after loading the view.
    }

    func updateView(_ array: [String]) {
        self.dataArray = array
        self.tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lblName.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

