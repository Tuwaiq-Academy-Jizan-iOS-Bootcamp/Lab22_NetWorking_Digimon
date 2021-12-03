//
//  ViewController.swift
//  Dahma_Digimon
//
//  Created by dahma alwani on 21/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewDigimon: UIImageView!
    @IBOutlet weak var nameDigimon: UILabel!
    @IBOutlet weak var levelDigimon: UILabel!
    @IBOutlet weak var tableViewDigimon: UITableView!
    var digimon:[Digimon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDigimon.dataSource = self
        tableViewDigimon.delegate = self
        getData("/digimon")
    }
    func getData (_ endPoint:String) {
         let urlFirst = "https://digimon-api.vercel.app/api"
//  URL
        if let url = URL(string: urlFirst + endPoint) {
//  URL SESSION
            let session = URLSession(configuration: .default)
//  TASK
            let task = session.dataTask(with: url) { data , response, error in
                if let error = error {
                    print("errooor" ,error.localizedDescription)
                }else{
                    if let data = data {
                        print(String(data: data , encoding: .utf8)!)
                        do {
                            let decoder = JSONDecoder()
                            let decoderData = try
                            decoder.decode([Digimon].self, from: data)
                            DispatchQueue.main.async {
                                self.digimon = decoderData
                                self.tableViewDigimon.reloadData()
                            }
                            let nameOfDigimon = decoderData[0].name
                            let levelOfDigimon = decoderData[0].level
                            DispatchQueue.main.async { [self] in
                            nameDigimon.text = nameOfDigimon
                            levelDigimon.text = levelOfDigimon
                                if let imageURL = URL(string: decoderData[0].img) {
                                    DispatchQueue.global().async {
                                        let data = try? Data(contentsOf: imageURL)
                                        if let data = data {
                                            let image = UIImage(data: data)
                                            DispatchQueue.main.async {
                                                self.imageViewDigimon.image = image
                                            }
                                        }
                                    }
                                }
                            }
//                            decoder.decode([Digimon].self, from:data)
                        } catch {
                            print("errooorr", error.localizedDescription)
                        }
                    }
                }
            }
//  RESUM TASK
            task.resume()
        }
    }
}
    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return digimon.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableViewDigimon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DigimonCell
           
            let imageURL = URL(string: digimon[indexPath.row].img)!
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageURL){
                        DispatchQueue.main.async {
                            cell.imageCellDigiman.image = UIImage(data: data)
                        }
                    }
                }
            
        
               cell.labelNameDigimon.text = self.digimon [indexPath.row].name
               cell.labelLevelDigimon.text = self.digimon [indexPath.row].level

            return cell

            
        }
        func tableView(_ tableView: UITableView, hieghtForRowAt indexPath: IndexPath) -> CGFloat{
            return 250
        }
        
                                 }

