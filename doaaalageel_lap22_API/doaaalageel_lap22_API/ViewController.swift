//
//  ViewController.swift
//  doaaalageel_lap22_API
//
//  Created by Dua'a ageel on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var lableName: UILabel!
    
    
    @IBOutlet weak var lableLevel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        getData(with: "/digimon")
    }
    func getData(with endPoint:String){
        print("is this colled??")
        let baseURL = "https://digimon-api.vercel.app/api"
        
        if let url = URL(string: baseURL + endPoint) {
            print("was the URL in correct format")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if  let error = error {
                    print("error",error.localizedDescription)
                    
                }else {
                    print("do we have data",data)
                    if let safeData = data{
                        do {
                        let decorder = JSONDecoder()
                        let decodedData = try decorder.decode([Digmon].self, from: safeData)
                        print("decoded data",decodedData[0])
                            DispatchQueue.main.async {
                            
                        self.lableName.text = decodedData[0].name
                                self.lableLevel.text = decodedData[0].level
                                
                                if let imageURL = URL(string: decodedData[0].img){
                                    let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        self.myImageView.image = image}
                                    }
                                }
                                
                            
                        } catch {
                            print("something went wronr",error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
