
    import UIKit
class ViewController: UIViewController {

@IBOutlet weak var imageViewApi: UIImageView!
@IBOutlet weak var firdtDigimonLabel: UILabel!
@IBOutlet weak var secendDigimon: UILabel!
@IBOutlet weak var tabelView: UITableView! {
didSet{
           tabelView.delegate = self
            tabelView.dataSource = self
        }
    }
    var dig: [Digimon] = []
   override func viewDidLoad() {
        super.viewDidLoad()
// call func getData
     getData(with: "/digimon")
        }
        
        func getData(with endPoint:String){
            print("Is this called")
          let baseURl = "https://digimon-api.vercel.app/api"
            
            
            //step 1
            if let url1 = URL(string: baseURl + endPoint) {
                print("step1")
            //step 2
                let session = URLSession(configuration: .default)
            //step 3
        let task = session.dataTask(with: url1){ data, response, error in
           if let error = error {
               print("step3",error.localizedDescription)
                    }else{
                       // print("....." ,data)
                        if let safeData = data {
        //1 do ....// decode => thrawine
                            do {
            let decord = JSONDecoder()
         //2 try
    let decordededData = try decord.decode([Digimon].self, from: safeData)
        DispatchQueue.main.async {
            self.dig = decordededData
            self.tabelView.reloadData()
                                    
                                }
    print("DECODE DATA", decordededData[0])
    DispatchQueue.main.async {
        self.tabelView.reloadData()
    }
                         
           //3 catch
                            }catch {
            print ("error", error.localizedDescription)
                            }
                        }
                      }
                    }
            
            task.resume()
           
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dig.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell")as! DatilesTabelViewCell
        DispatchQueue.main.async {
            cell.labelFirstTabelViewCell.text = self.dig[indexPath.row].name
            cell.labelSecendTabelViewCell.text = self.dig[indexPath.row].level
            let imgURL = URL(string: self.dig[indexPath.row].img)!
            DispatchQueue.global().async {
                if let datta = try? Data(contentsOf: imgURL){
                    DispatchQueue.main.async {
                        cell.imageTabelViewCell.image = UIImage(data: datta)

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

