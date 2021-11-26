//
//  ViewController.swift
//  MaramFaqih_Lab22_NetWorking_Digimon
//
//  Created by meme f on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var digimonTV: UITableView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    var digmon = [Digmon]()
    
    var arrr = ["m"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //pass end point as argument to function that will get data
        digimonTV.delegate = self
        digimonTV.dataSource = self
        getaData(with:"/digimon")
        
        
         
    }
    //req Method
    //1.get:
    func getaData(with endPoint:String){
        //1.1 Create url req
        let baseURL = "https://digimon-api.vercel.app/api"
       if let url = URL(string: baseURL+endPoint) {
        //1.2 Create session req
        let session = URLSession(configuration: .default)
        //1.3 creat task
        //task create to get data from url and call closuer "completion Handler"
        let task = session.dataTask(with: url){ data, respons, error in
            if let error = error {
                print("error",error.localizedDescription)
            }else{
                if let safeData = data {
                    do{
                        //-Object decode data type from jeson-
                        let decoder = JSONDecoder()
                        //-decode() return value from jeson object as type "decoder"
                        let decoderData = try decoder.decode([Digmon].self, from: safeData)
                        //print the firest json object from json array
                        print("decode data:",decoderData[0])
                        
                            DispatchQueue.main.async {

                        self.nameLabel.text = decoderData[0].name
                        self.levelLabel.text = decoderData[0].level
                                self.digmon = decoderData
                                self.digimonTV.reloadData()
                             
          
                        
                                  if let imageURL = URL(string: decoderData[0].img){
                                   let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                            self.imageView1.image = image
                                        
                                    }
                                      
                                  }
                                
                             
                            
                            }
                         
                        
                    }
                    
                    catch{
                        print("error",error.localizedDescription)
                        
                    }
                }
                
            }
            
        }
           //call task if task
            task.resume()
        }
        
        
        
        
    }
    

}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
        
        var content = cell.defaultContentConfiguration()
        content.text = digmon[indexPath.row].name
        content.secondaryText = digmon[indexPath.row].name
        //content.image =
        if let imageURL = URL(string: digmon[indexPath.row].img){
            let data = try? Data(contentsOf: imageURL)
             if let data = data {
                 let image = UIImage(data: data)
                 content.image = image
                 
             }
               
           }
       // UIImage(named: "\(digmon[indexPath.row].img)")
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
      
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration=content
        
        return cell
    }
    
    
}
