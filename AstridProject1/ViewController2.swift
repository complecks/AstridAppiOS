//
//  ViewController2.swift
//  AstridProject1
//
//  Created by Harshith Sadhu on 12/27/21.
//

import FirebaseDatabase
import UIKit
import SwiftSoup
import WebKit

class ViewController2: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var webview: WKWebView!
    
    private let database = Database.database().reference()
   
    var test = [String: String]()
    
    var text: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (text != nil){
            webview.load(URLRequest(url: URL(string: text!)!))
        }
        
        
        
       /* let myURLString = "https://www.usnews.com/topics/subjects/safety"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }

        
        do{
            
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            
            let doc: Document = try SwiftSoup.parse(myHTMLString)
           
            let head: Element = try doc.select("a").first()!
            let a: [Element] = try doc.select("a").array()
            
            
            //var i = 0;
            //for val in a{
            //    print(try String(i) + val.text())
            //   i = i + 1
           // }
            print(try a[17].text())
            let link: String  = try a[17].attr("href")
            print(link)
            
            
            //print("didn't work")
        }
        catch Exception.Error(type: let type, Message: let message){
            print(type)
            print(message)
        }
        catch{
            print("Did not work as intended")
        }
    */
    }
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
