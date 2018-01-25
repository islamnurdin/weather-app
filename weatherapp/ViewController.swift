//
//  ViewController.swift
//  weatherapp
//
//  Created by MacBook Pro on 12/13/17.
//  Copyright © 2017 Islam & Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityName: UITextField!

    @IBOutlet var resultLable: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/"+cityName.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest"){
            let request = NSMutableURLRequest(url: url)
            
            var message = ""
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, request, error in
                
                if let error = error{
                    
                    print(error)
                } else{
                    if let unwrapped = data{
                        let dataString = NSString(data: unwrapped, encoding: String.Encoding.utf8.rawValue)
                        
                        var resultString = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: resultString){
                            
                            if contentArray.count > 1 {
                                
                                resultString = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: resultString)
                                
                                if newContentArray.count > 1{
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    
                                    print(message)
                                }
                            }
                        }
                    }
                }
                
                if message == ""{
                    
                    message = "Please enter a city name"
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.resultLable.text = message
                })
            }
            task.resume()
        } else{
            
            resultLable.text = "The weather there could not be found, please try again!"
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let url = URL(string: "https://www.stackoverflow.com")!llyh
//
//        webview.loadRequest(URLRequest(url: url))

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

