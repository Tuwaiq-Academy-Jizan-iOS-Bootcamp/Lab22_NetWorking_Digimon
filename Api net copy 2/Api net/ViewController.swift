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
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var levelOfDigmon: UILabel!
    @IBOutlet weak var nameOfDigmon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")
        myTableView.delegate = self
        myTableView.dataSource = self
        
       
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
                            self.digmonApi = try decoder.decode([Digmon].self, from: safeData) // [Digmon] becuse the jeson in array!!

                            DispatchQueue.main.async {
                                self.nameOfDigmon.text = self.digmonApi[0].name
                                self.levelOfDigmon.text = self.digmonApi[0].level
                                self.digmonImag.image = UIImage(data: data!)
                                self.myTableView.reloadData()
                                if let digoImageData = URL(string: self.digmonApi[0].img){
                                    if let imageData = try? Data(contentsOf: digoImageData) {
                                        self.digmonImag.image = UIImage(data: imageData)
                                        
                                    }
                                
                                }
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
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonApi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = digmonApi[indexPath.row].name
        content.secondaryText = digmonApi[indexPath.row].level
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        
        
        // stap for the image
        if let digoImageURL = URL(string: self.digmonApi[indexPath.row].img){
            DispatchQueue.global().async {
                if let digmoImageData = try? Data(contentsOf: digoImageURL) {
                    let digmoaImage = UIImage(data: digmoImageData)
                DispatchQueue.main.sync {
                    content.image = digmoaImage
                    cell.contentConfiguration = content
                        
                    }
                }
            }
          
        }
        
        
      
        return cell
    }
    
}


