//
//  ViewController.swift
//  HananSomily_Lab22_NetWorking_Digimon
//
//  Created by Hanan Somily on 24/11/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var digimonViewTabelView: UITableView! {
    didSet {
        digimonViewTabelView.delegate = self
                digimonViewTabelView.dataSource = self
    }
}
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      getDataURL(with: "/digimon")
        
        // Do any additional setup after loading the view.
    }
    var digmonData = [Digmon]()
   // var array = ["  "]

    func getDataURL(with endpoint:String){
        let dataURL = "https://digimon-api.vercel.app/api"
        if let url = URL(string: dataURL + endpoint) {
        let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [self] ( data , response , error ) in
            if let error = error {
                print("ERROR",error.localizedDescription)
            }else {
                print("DO WE HAVE DATA",data)
            if let safeData = data {
                
                do {
                    
                    let decoder = JSONDecoder()
                    //let data = try? Date (contentsOf: dataURL)
                    let decodedData = try decoder.decode([Digmon].self , from: safeData)
                    //nameLabel.text =
                    DispatchQueue.main.async {
                        nameLabel.text  = decodedData[0].name
                        levelLabel.text  = decodedData[0].level
                        self.digmonData = decodedData
                        self.digimonViewTabelView.reloadData()
                        DispatchQueue.global().sync {
                        
                    if let imageDigmon = URL(string:decodedData[0].img){
                       // DispatchQueue.global().async {
                            let data = try? Data(contentsOf: imageDigmon)
                            if let data = data {
                                let image = UIImage(data: data)
                                self.image.image = image
                            }
                            }
                      //  }
                    }
                }
                    print ("Decoded data",decodedData[0])
                } catch {
                    print ("something went wrong ", error.localizedDescription)
                    
                    
                }
              }
            }
          }
            //
            task.resume()
    }
  }
}

extension ViewController : UITableViewDelegate {
    
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DigimonCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = digmonData[indexPath.row].name
        content.secondaryText = digmonData[indexPath.row].level
         DispatchQueue.global().sync {

             if let imageDigm = URL(string:self.digmonData[indexPath.row].img){
                let data = try? Data(contentsOf: imageDigm)
                if let data = data {
                    let image = UIImage(data: data)
                    content.image = image
                }
        }
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
         }
           cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
      return cell
    }
}
