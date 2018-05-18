//
//  ViewController.swift
//  F1Project
//
//  Created by T1aluno09 on 16/05/18.
//  Copyright © 2018 T1aluno09. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, BeautifulChartDelegate {
    let numberOfRows = 2019-1950
    @IBOutlet var beautifulChart: BeautifulBarChart!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(numberOfRows-1, inComponent: 0, animated: false)
        beautifulChart.delegate = self
        indicator.hidesWhenStopped = true
        getStandingsFor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStandingsFor(yearOfSeason year: String = "current") {
        indicator.startAnimating()
        let address = "http://ergast.com/api/f1/\(year)/driverStandings.json"
        let url = URL(string: address)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let dateReturned = data {
                let decoder = JSONDecoder()
                do {
                    let obj = try decoder.decode(BaseObject.self, from: dateReturned)
                    
                    if let driverStandings = obj.MRData?.StandingsTable.StandingsLists?.first?.DriverStandings {
                        let barEntries = self.generateData(driverStandings: driverStandings)
                        OperationQueue.main.addOperation {
                            self.beautifulChart.dataEntries = barEntries
                            self.indicator.stopAnimating()
                        }
                    }
                    
                }catch let error {
                    print("Erro \(error)")
                }
            }
        }
        task.resume()
    }
    func generateData(driverStandings: [DriverStanding]) -> [BarEntry]{
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [BarEntry] = []
        let maxHeigth = Float(driverStandings.first?.points ?? "0") ?? 0
        
        for driverStanding in driverStandings {
            let value = driverStanding.points ?? "0"
            let points = Float(value) ?? 0
            let height = Float(points / maxHeigth)
            let driverName = driverStanding.Driver?.familyName ?? ""
            let url = driverStanding.Driver?.url ?? ""
            let randomIndex = arc4random_uniform(UInt32(colors.count))
            result.append(BarEntry(color: colors[Int(randomIndex)], height: height, textValue: value, title: driverName, url: url))
        }
        return result
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getYear(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = getYear(row: row)
        getStandingsFor(yearOfSeason: year)
    }
    
    func getYear(row: Int) -> String {
        let year = 1950 + row
        if(year < 2018)  {
            let yearConverted = String(year)
            return yearConverted
        }else {
            return "Current"
        }
    }
    
    func chartItemSelected(keyElement: String) {
        performSegue(withIdentifier: "webviewSegue", sender: keyElement)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webviewViewController = segue.destination as! WebviewViewController
        webviewViewController.url = sender as! String
    }
}

