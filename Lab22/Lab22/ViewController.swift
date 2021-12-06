//
//  ViewController.swift
//  Lab22
//
//  Created by زهور حسين on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imagedigimon: UIImageView!
    
    @IBOutlet weak var namedigimon: UILabel!
    @IBOutlet weak var leveldigimon: UILabel!
    @IBOutlet weak var tableviewdigimon: UITableView!
    var arraydigimon : [Digimon] = []
    var content = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewdigimon.dataSource = self
        tableviewdigimon.delegate = self
        // Do any additional setup after loading the view.
       getData(with: "/digimon")
    }
    func getData(with endpoint:String){
        print("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        
        if let ur1 = URL(string: baseURL + endpoint) {
            print("WAS THE IN CORRECT FORMAT")
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: ur1) { data, response, error in
                if let error = error {
                    print("ERROR" , error.localizedDescription)
                }else{
                 //  print("DO WE HAVE DATA",data)
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digimon].self,from: safeData)
                        
                            DispatchQueue.main.async {
                               let namelable = decodedData [0].name
                                let levellable = decodedData [0].level
                                self.arraydigimon = decodedData
                                self.tableviewdigimon.reloadData()
                             //   self.namedigimon.text = namelable
                              //  self.leveldigimon.text = levellable
                                DispatchQueue.global().sync {
                                 
                                if let imageURL = URL(string: decodedData[0].img){
                                    let data = try? Data (contentsOf: imageURL)
                                    if let data = data{
                                        let img = UIImage(data: data)
                                      self.imagedigimon.image = img }
                                    }
                                }
                            }
                          //  print("DECOD DATA", decodedData[0])
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraydigimon.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ,for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = arraydigimon[indexPath.row].name
        content.secondaryText = arraydigimon[indexPath.row].level
        DispatchQueue.global().sync {
            if let imagedigmon = URL(string: self.arraydigimon[indexPath.row].img){
                let data = try? Data(contentsOf: imagedigmon)
                if let data = data {
                    let image = UIImage(data: data)
                    content.image = image
                }
            }
            content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        }
       // content.image = UIImage(named: arraydigimon[indexPath.row].img)
        cell.contentConfiguration = content
        return cell
        
    }
    
}

