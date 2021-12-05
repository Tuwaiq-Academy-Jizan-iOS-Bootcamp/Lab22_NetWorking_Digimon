//
//  ViewController.swift
//  workAPI
//
//  Created by NoON .. on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var digimonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var digmonTableView: UITableView!
    {
        didSet {
            digmonTableView.delegate = self
            digmonTableView.dataSource = self
        }
    }
    var degimons = [Degimon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(with: "/digimon")
    }
    func getData(with endPoint:String){
        // step 1 crreat a URL
        // يتغير
        let baseURL = "https://digimon-api.vercel.app/api"
        print("is thes colled??")
        if let url = URL(string: baseURL + endPoint){
            print("WAS THE URL IN CORRECT FORMAT")
            // step 2 create URLSession
            //ثابته
            let session = URLSession(configuration: .default)
            //step 3 give URLSession a task
            // لها خيارين ي url or url requst/ثابته الا فيها
            //كلوجر
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("ERROR",error.localizedDescription)
                }else{
                    print("DOWE HAVE DATA",data!)
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Degimon].self, from: safeData)
                            DispatchQueue.main.async {
                                self.degimons = decodedData
                                self.digmonTableView.reloadData()
                            }
                            print("DECODED DATA",decodedData[0])
                            DispatchQueue.main.async {
                                self.nameLabel.text = decodedData[0].name
                                self.levelLabel.text = decodedData[0].level
                                
                                if let imageURL = URL(string: decodedData[0].img){
                                    let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        self.digimonImage.image = image}
                                    }
                                }
                            
                        } catch {
                            print("SOMETHING WENT WRONG", error.localizedDescription)
                        }
                    }
                }
            }
            //4. start/resume the task
            // ثابته
            task.resume()
        }
    }
}
    extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return degimons.count
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! DigemonTableViewCell
        cell.nameCellLabel.text = degimons[indexPath.row].name
        cell.levelCellLabel.text = degimons[indexPath.row].level
            cell.cellImage.image = nil
        if let image = URL(string: degimons[indexPath.row].img)
        {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: image)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        if tableView.cellForRow(at: indexPath) != nil{
                        cell.cellImage.image = image
                    }
                }
            }
        }
        }
      return cell
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return 150
        }
    }
