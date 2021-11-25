//
//  ViewController.swift
//  Api net
//
//  Created by Yasir Hakami on 24/11/2021.
//

import UIKit

class ViewController: UIViewController {
    var digmonApi = [Digmon]() // call the struct
    @IBOutlet weak var digmonImag: UIImageView!
    
    @IBOutlet weak var levelOfDigmon: UILabel!
    @IBOutlet weak var nameOfDigmon: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")

    }
    func getData(with endPoint:String){
        let baseURL = "https://digimon-api.vercel.app/api" // make constens for baseUrl "link url"
        if let url = URL(string: baseURL + endPoint){ // make - if let - for (URL) to compine baseURL + prameter
            let session = URLSession(configuration: .default) // make - let session - URLSession contin (configurtion: .dufult)
            let task = session.dataTask(with: url) { data, response, error in // make Task contin sessio.dataTask
                if let error = error { // if for handling the error
                    print("ERROR", error.localizedDescription)
                } else { // else for bulid the task
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digmon].self, from: safeData) // [Digmon] becuse the jeson in array!!
                            print("DECODED DATA", decodedData[0])
                            
                            self.digmonApi = decodedData
                            DispatchQueue.main.async {
                                self.nameOfDigmon.text = self.digmonApi[0].name
                                self.levelOfDigmon.text = self.digmonApi[0].level
                            }
                        } catch {
                            print("SOMTHING WENT WRRONG!", error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
        
        
    }
    
}



