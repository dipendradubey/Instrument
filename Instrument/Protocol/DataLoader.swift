//
//  DataLoader.swift
//  Instrument
//
//  Created by Dipendra Dubey on 24/09/23.
//

import Foundation

protocol DataProtocol:AnyObject{
    //var array:[String]{get set}
    func updateView(_ array:[String])->Void
}

class DataFetcher{
    var completion: (_ arrayData:[String])->Void = {arrayData in} //It's important to initialise else will be compilation error that object is not initialised
    weak var dataProtocol:DataProtocol?
    func getData() {
        let dataArray = ["abc", "def", "ghi", "jkl", "MNO", "PQR", "STU", "VWX", "YZ"]
        dataProtocol?.updateView(dataArray)
    }
    
    func fetchData(){
        let dataArray = Array(repeating: "Sun", count: 500)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1){[unowned self] in
            self.completion(dataArray)
        }
    }
}
