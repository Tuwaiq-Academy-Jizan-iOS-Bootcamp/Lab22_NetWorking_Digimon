

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewDigimon: UITableView!
    
    var alldigimon = [Digmon] ()
    
    override func viewDidLoad() {
        getdata(with: "/digimon")
        super.viewDidLoad()
      
        tableViewDigimon.delegate = self
        tableViewDigimon.dataSource = self
        
    }
    func getdata(with endPoint : String){
        print ("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        
       
        if let url = URL (string: baseURL + endPoint) {
            print("WAS THE URL IN CORRECT FORMAT")
            
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data , response, error in
                
                if let error = error {
                    
                    print ("ERROR", error .localizedDescription)
                }else {
                    print ("DO WE HAVE DATA", data!)
                    
                    if let safeData = data {
                     //   print(String(data:safeData,encoding: utf8 ))
                        
                    
                        do {
                            let decoder = JSONDecoder()
                            let decodeData = try decoder.decode([Digmon].self , from: safeData)
                            self.alldigimon = decodeData
                            
                          //  imageDigimon.image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.tableViewDigimon.reloadData()
                            }}
                        catch{
                            print("SOMETHING WENT WRONG",error.localizedDescription)
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
     return alldigimon.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as! DigimonCell
     cell.nameDigimon.text = alldigimon[indexPath.row].name
     cell.levelDigimon.text = alldigimon[indexPath.row].level
     cell.imageDigimon.image = nil
       
       
     let urlImage = URL(string: alldigimon[indexPath.row].img)
     if let urlImage = urlImage {
       DispatchQueue.global().async {
         if let data = try? Data(contentsOf: urlImage){
           DispatchQueue.main.async {
            
             if tableView.cellForRow(at: indexPath) != nil {
               cell.imageDigimon.image = UIImage(data: data)
             }
           }
         }
       }
     }
     return cell
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 100
   }
 }






