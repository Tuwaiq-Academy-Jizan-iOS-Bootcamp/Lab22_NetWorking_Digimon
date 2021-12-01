//
//  ViewControllerTwo.swift
//  Bushra Barakat_22
//
//  Created by Bushra Barakat on 23/04/1443 AH.
//

import Foundation
import UIKit
class ViewControllerTWO: UIViewController {
    var image = ""
    @IBOutlet weak var digmonFirstNameLabel: UILabel!
    @IBOutlet weak var digmonFirstLevelLabel: UILabel!
    @IBOutlet weak var digmonFirstImageView: UIImageView!
    
    override func viewDidLoad() {
        getData(with: "/digimon")
        
    }
    func getData(with endPoint: String){
        print ("is this work??")
        let baseURL = "https://digimon-api.vercel.app/api"
//        1- creat url
        if let url = URL(string: baseURL + endPoint) {
            print("was the URL in correct formate")
//        2- creat a URL Session
            let session = URLSession(configuration: .default)
//        3- creat a task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("ERROR", error.localizedDescription)
                }else {
                    print("do we have data",data)
                    if let safeData = data {
                        print(String(data: safeData, encoding: .utf8))
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                            DispatchQueue.main.async {
                                self.digmonFirstNameLabel.text = decodedData[0].name
                                self.digmonFirstLevelLabel.text = decodedData[0].level
                                if let urlImage = URL(string:decodedData[0].img){
                                    let data = try? Data(contentsOf:urlImage)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        self.digmonFirstImageView.image = image
                                    }
                                    }
                                }
                                
                        }catch{
                            print("somthing went wrong",String(describing: error))
                        }
                    }
                }
            }
//          4 -
            task.resume()
        }
        
    }
 
}
