//
//  ViewController.swift
//  Api net
//
//  Created by Yasir Hakami on 24/11/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")
        
    }
    func getData(with endPoint:String){
        let baseURL = "https://digimon-api.vercel.app/api"
        if let url = URL(string: baseURL + endPoint){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("ERROR", error.localizedDescription)
                } else {
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                            print("DECODED DATA", decodedData[0])
                        } catch  {
                            print("SOMTHING WENT WRRONG!", error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
        
        
    }
    
}



