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
    lazy var dateFormate : DateFormatter = {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "dd-MMM-yyyy hh:mm:ss a"
        return dateFormate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        dataFetcher.dataProtocol = self
        dataFetcher.getData()
        
        //Taking reference of self inside closure causes memory leak
        /*
        dataFetcher.completion = {dataArray in
            self.dataArray += dataArray
            self.tblView.reloadData()
        }
         */
        
        //This can be fixed by taking weak references or using unknowned reference
        dataFetcher.completion = {[weak self] dataArray in
            self?.dataArray += dataArray
            self?.tblView.reloadData()
            print("weak called")
        }
        
        //This can be fixed by taking weak references or using unknowned reference
        dataFetcher.completion = {[unowned self] dataArray in
            self.dataArray += dataArray
            self.tblView.reloadData()
            print("unowned called")
        }
        dataFetcher.fetchData()
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
        cell.updateImageView()
        
        cell.lblDate.text = dateFormate.string(from: Date())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

