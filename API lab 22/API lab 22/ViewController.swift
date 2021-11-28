//
//  ViewController.swift
//  API lab 22
//
//  Created by grand ahmad on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewData: UITableView!
    @IBOutlet weak var imgData: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var descriplabel: UILabel!
    
    var listArr = [Digmon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(with: "/digimon")
    }
    func getData(with endPoint:String){
        let baseURL = "https://digimon-api.vercel.app/api"
        if let ur1 = URL(string: baseURL + endPoint) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: ur1) { data, response, error in
                if let error = error {
                    print("Error", error.localizedDescription)
                } else {
                    if let safeDate = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digmon].self, from: safeDate)
                            print("decord data",decodedData[0])
                            self.listArr = decodedData
                            
                            DispatchQueue.main.async {
                                self.tableViewData.reloadData()
                            }
                        } catch {
                            print("SOMETHING WENT WRONG", error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text =  listArr[indexPath.row].name
        content.secondaryText = listArr[indexPath.row].level
        content.image = nil
        
        //        speed image
        let url = URL(string: listArr[indexPath.row].img)
        if let url = url{
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        
                        if tableView.cellForRow(at: indexPath) != nil {
                            content.image = UIImage(data: data)
                            
                        }
                        
                    }
                }
            }
        }
        let data = try? Data(contentsOf: url!)
        content.image = UIImage(data: data!)
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
