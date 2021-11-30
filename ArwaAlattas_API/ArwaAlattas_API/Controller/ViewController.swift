//
//  ViewController.swift
//  ArwaAlattas_API
//
//  Created by Arwa Alattas on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var digimonTableView: UITableView!{
        didSet{
            digimonTableView.delegate = self
            digimonTableView.dataSource = self
        }

    }
//    @IBOutlet weak var digimonImage: UIImageView!
//    @IBOutlet weak var digimonLevelLabel: UILabel!
//    @IBOutlet weak var nameDigimonLabel: UILabel!
    var digimonArray:[Digemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gitData(with: "/digimon")
       
        
    }

    let imageCach = NSCache<AnyObject, AnyObject>()
    func gitData(with endPoint:String){
        let baseURL = "https://digimon-api.vercel.app/api"
            // step 1
        if let url = URL(string: baseURL + endPoint){
          print("we creat url")
            
       // step 2
let session = URLSession(configuration: .default)
            
    // step 3
let task = session.dataTask(with: url) { data, response, error in
 if let error = error {
    print("ERROR",error.localizedDescription)
}else{
    if let safeData = data{
        do {
        let decoder = JSONDecoder()
    let decoderData = try decoder.decode([Digemon].self, from: safeData)
        self.digimonArray = decoderData
    DispatchQueue.main.async {
            self.digimonTableView.reloadData()
                            }
               
                        } catch  {
                            print("SOMTHING WRONG",error.localizedDescription)
                        }
                    }
                }
            }
            
            task.resume()
        }
        
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digimonArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! digimonDetailCell
            DispatchQueue.main.async {
                cell.digimonName .text = self.digimonArray[indexPath.row].name
                cell.digimonLevel.text = self.digimonArray[indexPath.row].level
                cell.digimonimage.image = nil
                
                    let imgURL = URL(string: self.digimonArray[indexPath.row].img)!
                DispatchQueue.global().async {
                    if  let dataa = try? Data(contentsOf: imgURL){
                        DispatchQueue.main.async {
                            if tableView.cellForRow(at: indexPath) != nil {
                            cell.digimonimage.image = UIImage(data: dataa)
                            }
                        }
                    }
                }
                   
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
}
