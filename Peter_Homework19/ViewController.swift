//
//  ViewController.swift
//  Peter_Homework19
//
//  Created by 陳庭楷 on 2019/1/2.
//  Copyright © 2019 TingKai. All rights reserved.
//

import UIKit

struct JSONData: Codable {
    
    var result: Result
    
}

struct Result: Codable {
    
    var limit: Int
    
    var offset: Int
    
    var count: Int
    
    var sort: String
    
    var results: [Results]
    
}

struct Results: Codable {
    
    var stitle: String
    
    var xAddress: String
    
    var xbody: String
    
}

class ViewController: UIViewController {

    @IBOutlet weak var marketTableView: UITableView!
    
    var superMarkets: [Results]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.marketTableView.dataSource = self
        
        self.marketTableView.delegate = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.getJSON()

    }
    
    func getJSON() {
        
        guard let url = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=44441899-7d26-462a-a672-5cb8a60091b6")
            else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            let jsonData = try! JSONDecoder().decode(JSONData.self, from: data)
            
            self.superMarkets = jsonData.result.results
        
            DispatchQueue.main.async {
                
                self.marketTableView.reloadData()
                
            }
            
        }
        
        task.resume()
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell", for: indexPath)
        
//        IndexPath(row: 0, section: 0)
//        IndexPath(row: 1, section: 0)
//        IndexPath(row: 2, section: 0)
//        IndexPath(row: 3, section: 0)
//        IndexPath(row: 4, section: 0)
        
        guard let superMarket = self.superMarkets else { return cell }
        
        cell.textLabel?.text = superMarket[indexPath.row].stitle
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let superMarket = self.superMarkets {
            
            return superMarket.count
            
        }
            
        else {
            
            return 0
            
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "marketSegue", sender: self.superMarkets![indexPath.row])

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)

        if let superMarketDetailViewController = segue.destination as? SuperMarketDetailViewController {

            superMarketDetailViewController.superMarket = sender as? Results

        }

    }

}
