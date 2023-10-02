//
//  TableViewCell.swift
//  Instrument
//
//  Created by Dipendra Dubey on 24/09/23.
//

import UIKit

class TableViewCell: UITableViewCell,URLSessionDelegate {

    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var imgView: UIImageView!
    let session = URLSession.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateImageView(){
        if let url = URL(string: "https://images.pexels.com/lib/api/pexels.png"){
            session.dataTask(with: url){[weak self]data, response, error in
                if let data = data{
                    DispatchQueue.main.async{
                        self?.imgView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
    }

}
