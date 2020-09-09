//
//  ViewController.swift
//  InTableView
//
//  Created by Apple on 09/09/20.
//  Copyright © 2020 Software Cafe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct dataHolder {
    let name:String!
    let email:String!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    var tableData:[dataHolder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AF.request("https://jsonplaceholder.typicode.com/comments").responseJSON { (response) in
           
            switch response.result {
            case .success(let value):
                //SwiftyJson
//               let json = JSON(value)
//               for (_, object) in json {
//                let name = object["name"].stringValue
//                let email = object["email"].stringValue
//                let dataHold = dataHolder(name: name, email: email)
//                self.tableData.append(dataHold)
//                DispatchQueue.main.async {
//                    self.commentsTableView.reloadData()
//                }
//
//               }
                if let fullData = value as? [[String:Any]] {
                    print(fullData, "Actual")
                    fullData.forEach({ (key) in
                        let name = key["name"] as? String
                        let email = key["email"] as? String

                        let dataHold = dataHolder(name: name, email: email)

                        self.tableData.append(dataHold)
                    })
                    DispatchQueue.main.async {
                        self.commentsTableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }

    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:commentsTableViewCell = self.commentsTableView.dequeueReusableCell(withIdentifier: "commentsCell") as! commentsTableViewCell
        
        let allTableData = tableData[indexPath.row]
        
        DispatchQueue.main.async {
        cell.title.text = allTableData.name
        cell.descriptionComments.text = allTableData.email
        }
        return cell
    }
    
    
    
}

class commentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var descriptionComments: UILabel!
    
}
