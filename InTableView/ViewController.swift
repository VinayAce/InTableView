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

struct dataHolder1 {
    let employee_name:String!
    let employee_salary:Int!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var commentsTableView: UITableView!
    
   // var tableData:[dataHolder] = []
    
    var tableData:[dataHolder1] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://jsonplaceholder.typicode.com/comments"
        
        let url1 = "http://dummy.restapiexample.com/api/v1/employees"
        
        AF.request(url1).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                //SwiftyJSON DH
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
                
                   // SwiftyJSON DH1
                let json = JSON(value)
                for (_, object) in json["data"] {
                let name = object["employee_name"].stringValue
                let email = object["employee_salary"].int
                let dataHold = dataHolder1(employee_name: name, employee_salary: email)
                self.tableData.append(dataHold)
                DispatchQueue.main.async {
                    self.commentsTableView.reloadData()
                }
            }
                
                //My Parse DH
                
//                if let fullData = value as? [[String:Any]] {
//                    print(fullData, "Actual")
//                    fullData.forEach({ (key) in
//                        let name = key["name"] as? String
//                        let email = key["email"] as? String
//
//                        let dataHold = dataHolder(name: name, email: email)
//
//                        self.tableData.append(dataHold)
//                    })
//                    DispatchQueue.main.async {
//                        self.commentsTableView.reloadData()
//                    }
//                }
                
                
                //My Parse DH1
                
//                if let fullData = value as? [String:Any] {
//                print(fullData, "Actual")
//                if let dataModel = fullData["data"] as? [[String:Any]] {
//
//                    dataModel.forEach({ (key) in
//                    let name = key["employee_name"] as? String
//                    let salary = key["employee_salary"] as? Int
//
//                    let dataHold = dataHolder1(employee_name: name, employee_salary: salary)
//
//                    self.tableData.append(dataHold)
//                })
//
//                    DispatchQueue.main.async {
//
//                    self.commentsTableView.reloadData()
//
//                    }
//                }
//            }
                
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
        cell.title.text = allTableData.employee_name //name
        cell.descriptionComments.text = String(allTableData.employee_salary) //email
        }
        return cell
    }
    
    
    
}

class commentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var descriptionComments: UILabel!
    
}
