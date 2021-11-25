//
//  ViewController.swift
//  API lab 22
//
//  Created by grand ahmad on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(with: "/digimon")
    }
    func getData(with endPoint:String){
                print("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        if let ur1 = URL(string: baseURL + endPoint) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: ur1) { data, response, error in
                
                if let error = error {
                    print(" Error", error.localizedDescription)
                }else{
                    print("DO WE HAVE DATA", data!)
                    if let safeDate = data {
                        do{
                            let decoder = JSONDecoder()
                            let decoderData = try decoder.decode([Digmon].self, from: safeDate)
                            print("decord data", decoderData[0])
                        } catch {
                            print("SOMETHING WENT WRONG", error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

