//
//  ViewController.swift
//  Afaf-Alqahtani-LLab22
//
//  Created by Afaf Yahya on 21/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var digimonName: UILabel!
    @IBOutlet weak var digemonLevle: UILabel!
    @IBOutlet weak var digimonImage: UIImageView!
    @IBOutlet weak var digimoneTabelView: UITableView!
    var digimon = [Digmon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        digimoneTabelView.delegate = self
        digimoneTabelView.dataSource = self
        
        getData(with: "/digimon")
    func getData(with endPoint:String){
        let baseURL = "https://digimon-api.vercel.app/api"
        // 1.  url
        if let url = URL(string: baseURL + endPoint) {
            //2 Session
            let session = URLSession(configuration: .default)
            //3  task
            let task = session.dataTask(with: url) { data, response, error in
//                4 to chick error
                if let error = error {
                    print("ERROR",error.localizedDescription)
                }else {
                    print("DO WE HAVE DATA",data)
                    if let safeData = data {
                        print(String(data: safeData, encoding: .utf8)!)
                        
                        let decoder = JSONDecoder()
                        do {
                           
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)

                            DispatchQueue.main.async {
                               
                                self.digimonName.text =  decodedData[0].name
                                self.digemonLevle.text = decodedData[0].level
                                if let imageURL = URL(string: decodedData[0].img) {

                                        let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                            let image = UIImage(data: data)
                                        
                                        self.digimonImage.image = image
                                        self.digimon = decodedData
                                        self.digimoneTabelView.reloadData()
                                        
                                            
                                            }
                                    }
                                }
                            print("DECODET DATA", decodedData[0])
                            DispatchQueue.main.async {
                                self.digimoneTabelView.reloadData()
                            }
                        } catch {
                            print("SOMETHING WENT WRONG",error.localizedDescription)
                        }
                        
                    }
                }
            }
            task.resume()
        }
      }
        
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digimon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellViewController
        DispatchQueue.main.async {
            cell.viewCellName.text = self.digimon[indexPath.row].name
            cell.viewCellLevel.text = self.digimon[indexPath.row].level
            let imageURL = URL(string: self.digimon[indexPath.row].img)!
            DispatchQueue.global().async {
                if let datta = try? Data(contentsOf: imageURL){
                    DispatchQueue.main.async {
                        cell.viewCellImage.image = UIImage(data: datta)
                    }
                }
            }
        }        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 140
        }
       
    }
