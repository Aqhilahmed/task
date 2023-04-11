//
//  CountryDisplayVC.swift
//  TayseerCompanyProject
//
//  Created by mohammed aqhil ahmed  on 10/04/23.
//

import UIKit



struct SearchResult: Codable {
    let countryName: String
}
    
class CountryDisplayVC: UIViewController {
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countryListTV: UITableView!
    
    var countryList = [String]()
    var results: [Result] = [Result]()
    var searchResult: [Result] = [Result]()
//    var searchResult : [[String: Any]] = []
    var searchedCountry = [String]()
   
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        searchResult = (results as? [[String : Any]])!
        self.countrySearchBar.delegate = self
//        self.countrySearchBar.barTintColor = UIColor.colorFromHex("#BC214B")
        self.countrySearchBar.tintColor = UIColor.white
        self.countrySearchBar.keyboardAppearance = .dark
    }

    
    func getApiData(pCountryId: Int, sCountryId: Int, systemId: Int){
        var urlRequest = URLRequest(url: URL(string :ApiPoint.apidata)!)
        urlRequest.httpMethod = "POST"
        let dict = ["payload":["pCountryId":pCountryId,"sCountryId":sCountryId,"systemId":systemId]]
//        let dict = ["payload":["systemId":19]]
        do {
            let jsonData = try? JSONSerialization.data(withJSONObject: dict)
            urlRequest.httpBody = jsonData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { datas, response, error in
            debugPrint(datas!)
            
            guard let data = datas else {
                print(String(describing: error))
                return
            }
            
            if (data != nil && data.count != 0){
                let response = String(data: data, encoding: .utf8)
                debugPrint(response!)
                do {
//                    let vehicleRes = try JSONDecoder().decode(DataClass.self, from: data)
//                    debugPrint("res", vehicleRes)
//                    self.results = vehicleRes.payload.result
                    
//                    DispatchQueue.main.asyncAfter(deadline: 2.0, execute: .) {
//                        self.countryListTV.reloadData()
//                    }
                    
                }
                catch {
                    debugPrint("error", error)
                }
            }
            
        }.resume()
    }
    
}
 
extension CountryDisplayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return results.count
        
//        if searching {
//            return searchResult.count
//        } else {
//            return results.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrylistTVC", for: indexPath) as!CountrylistTVC
                let productInfo = results[indexPath.row]
                cell.countryNameLbl.text = productInfo.countryName
                cell.countryImgView.loadFrom(URLAddress: productInfo.flagURL)
        cell.selectionStyle = .none
        
//        if searching {
//        cell.countryNameLbl.text = searchResult[indexPath.row] as? String
//            cell.countryImgView.loadFrom(URLAddress: searchResult[indexPath.row].flagURL)
//        } else {
//            let productInfo = results[indexPath.row]
//            cell.countryNameLbl.text = productInfo.countryName
//            cell.countryImgView.loadFrom(URLAddress: productInfo.flagURL)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productInfo = results[indexPath.row]
        debugPrint(productInfo)
                    let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "SendMoneyVC") as! SendMoneyVC
        //            let projectInfo:NSDictionary = ProdictsList.object(at: indexPath.row) as! NSDictionary
        //            vc.productDict = projectInfo
        //            vc.productID = projectInfo.value(forKey: "_id") as? String
        //            vc.modalPresentationStyle = .fullScreen
        //            self.present(vc, animated: true, completion: nil)
        
        
    }
}


extension CountryDisplayVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchResult = results.filter { item in
////                   guard let title = item["countryName"] as? String else { return false }
////                   return title.lowercased().contains(searchText.lowercased())
//               }
        countryListTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        countrySearchBar.text = ""
        countryListTV.reloadData()
    }
}



