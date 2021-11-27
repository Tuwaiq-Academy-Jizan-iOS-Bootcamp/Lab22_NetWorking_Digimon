//
//  ViewController.swift
//  API
//
//  Created by Abdulrahman Gazwani on 20/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameDigimon: UILabel!
    @IBOutlet weak var levelDigimon: UILabel!
    @IBOutlet weak var imageDigimon: UIImageView!
    
    override func viewDidLoad() {
        getdata(with: "/digimon")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
        
    
        
    }
    func getdata(with endPoint : String){
        print ("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        
       
        if let url = URL (string: baseURL + endPoint) {
            print("WAS THE URL IN CORRECT FORMAT")
            
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data , response, error in
                
                if let error = error {
                    
                    print ("ERROR", error .localizedDescription)
                }else {
                    print ("DO WE HAVE DATA", data!)
                    
                    if let safeData = data {
                     //   print(String(data:safeData,encoding: utf8 ))
                        
                    
                        do {
                            let decoder = JSONDecoder()
                            let decodeData = try decoder.decode([Digmon].self , from: safeData)
                          //  imageDigimon.image = UIImage(data: data)
                            DispatchQueue.main.async {
                                
                            self.nameDigimon.text = decodeData[11].name
                            self.levelDigimon.text = "\(decodeData[11].level)"
                                if let imageD = URL (string: decodeData[11].img) {
                                    let data = try? Data (contentsOf: imageD)
                                    if let data = data {
                                        let image = UIImage (data: data)
                                        self.imageDigimon.image = image
                                    }
                                }
                            
                         //   print("DECODED DATA",decodeData[0])
                            
                            }}
                        catch{
                            print("SOMETHING WENT WRONG",error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }

}







