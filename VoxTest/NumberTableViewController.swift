//
//  NumberTableViewController.swift
//  VoxTest
//
//  Created by Josh Motley on 9/17/18.
//  Copyright © 2018 Motley. All rights reserved.
//

import UIKit
import Alamofire
import Vox

class NumberTableViewController: UITableViewController {

    var numbersArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request("https://app.superdupertext.com/api/numbers?zip_code=94523", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                print("SUCCESS \(value)")
                
                let deserializer = Deserializer.Collection<PhoneNumber>()
                
                do {
                    
                    let document = try deserializer.deserialize(data: data.data!)
                    if let numbers = document.data {
                        
                        var numbersArr = [String]()
                        for numberObject in numbers{
                            numbersArr.append(numberObject.number ?? "missing number")
                        }
                        self.numbersArray = numbersArr
                        self.tableView.reloadData()
                        
                    }
                    
                } catch JSONAPIError.API(let errors) {
                    // API response is valid JSONAPI error document
                    errors.forEach { error in
                        print(error.title, error.detail)
                    }
                } catch JSONAPIError.serialization {
                    print("Given data is not valid JSONAPI document")
                } catch {
                    print("Something went wrong. Maybe `data` does not contain valid JSON?")
                }
                
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = numbersArray[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numbersArray.count
    }
}
