import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var digmonLevel: UILabel!
    @IBOutlet weak var digmonName: UILabel!
    @IBOutlet weak var digmonImage: UIImageView!
    @IBOutlet weak var digmonTabel: UITableView!
    var digmonDataAPI = [Digmon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadDigmonData()
        digmonTabel.delegate = self
        digmonTabel.dataSource = self
    }
    //download: @escaping () -> ())
    func downloadDigmonData() {
        if let urlResponce = URL(string:"https://digimon-api.vercel.app/api/digimon") {
            let urlSession = URLSession(configuration: .default)
            let urlTask = urlSession.dataTask(with: urlResponce) { data, response, error in
                if let error = error {
                    print("Error in the begening | The URL is bad",error.localizedDescription)
                }else {
                    if let digmoData = data {
                        do {
                            let decorder = JSONDecoder()
                            self.digmonDataAPI = try decorder.decode([Digmon].self, from: digmoData)
                            DispatchQueue.main.async {
                                self.digmonTabel.reloadData()
                                if let digoImageData = URL(string: self.digmonDataAPI[0].img) {
                                    if let imageData = try? Data(contentsOf: digoImageData) {
                                        self.digmonImage.image = UIImage(data: imageData)
                                    }
                                }
                                self.digmonName.text = self.digmonDataAPI[0].name
                                self.digmonLevel.text = self.digmonDataAPI[0].level
                            }
                        } catch {
                            print("Somthing wrong at end | The data not the same", error.localizedDescription)
                        }
                    }
                }
            }
            urlTask.resume()
        }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonDataAPI.count
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let digmonCell = digmonTabel.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var digmonCellContain = digmonCell.defaultContentConfiguration()
        digmonCellContain.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        digmonCellContain.text = digmonDataAPI[indexPath.row].name
        digmonCellContain.secondaryText = digmonDataAPI[indexPath.row].level
        if let digoImageURL = URL(string: self.digmonDataAPI[indexPath.row].img) {
            DispatchQueue.global().async {
                if let digmoImageData = try? Data(contentsOf: digoImageURL) {
                    let digmoaImage = UIImage(data: digmoImageData)
                    DispatchQueue.main.async {
                        digmonCellContain.image = digmoaImage
                        digmonCell.contentConfiguration = digmonCellContain
                    }
                }
            }
        }
        return digmonCell
    }
}
// digmonCellContain.image = UIImage(systemName: "person")
