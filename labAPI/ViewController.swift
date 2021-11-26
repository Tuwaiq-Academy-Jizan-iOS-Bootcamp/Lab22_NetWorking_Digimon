//
//  ViewController.swift
//  labAPI
//
//  Created by Ahlam Ahlam on 20/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelone: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getData(with: "/digimon")
    }
    
    func getData(with endPoint:String){
        print("is this called")
        let baseURL = "https://digimon-api.vercel.app/api"
        
        // s1
       
        if let url = URL(string: baseURL + endPoint) {
            print("Got Data")
            //s2
    
            let session = URLSession(configuration: .default)
        
            //s3
            
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("☠️")
                }else {
                    if let safeData = data {

                        do {
                            let decoder = JSONDecoder()
                            
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                            print("Decode Data",decodedData[0])
                            DispatchQueue.main.async {
                                self.labelone.text = decodedData[0].name
                                self.labelTwo.text = decodedData[0].level
                                if let imageURL = URL (string: decodedData[0].img){
                                    let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        self.image.image = image }
                                }
                            }
                           
                         
                        }
                        catch {
                            
                            print("Error ☠️",error.localizedDescription)
                        }
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
}

