//
//  NewsPage.swift
//  AstridProject1
//
//  Created by Harshith Sadhu on 1/6/22.
//
import FirebaseDatabase
import UIKit
import SwiftSoup
import WebKit
import SDWebImage
class NewsPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionV: UICollectionView!
    let disasters = ["Flood", "Blizzard", "Earthquake", "Tornado", "Volcano", "Lightning Storm"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        
            
            
        if (collectionView == collectionV){
            if(titleArr.count == 0){
                return 5
            }
            return titleArr.count
        }
        
        
        return disasters.count
    }
    
    
    var titleArr = [String]()
    var imgArr = [String]()
    var linkArr = [String]()
    
    
    func collectionView(_ collectionView: UICollectionView,
      didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionV {
            
        
        
        if (defaults.value(forKey: "linkArrDef") != nil) {
        
            let linkArrDef: [String] = defaults.value(forKey: "linkArrDef") as! [String]
            
            
            let controller = storyboard?.instantiateViewController(identifier: "SecondVC") as! ViewController2
            
            controller.newstrue = true
            
            controller.text = linkArrDef[indexPath.row]
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
            
        }
        }
      }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == collectionV){
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        //let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "GuidesCell", for: indexPath) as! GuidesCell
        
        
        
        //if (defaults.value(forKey: "imgArrDef") != nil && defaults.value(forKey: "linkArrDef") != nil && defaults.value(forKey: "titleArrDef") != nil) {
          //  let imgArrDef: [String] = defaults.value(forKey: "imgArrDef") as! [String]
            
           // let linkArrDef: [String] = defaults.value(forKey: "linkArrDef") as! [String]
            
          //  let titleArrDef: [String] = defaults.value(forKey: "titleArrDef") as! [String]
            
         //   if(imgArrDef.count == 5 && linkArrDef.count == 5 && titleArrDef.count == 5){
                
               // cell.lbl.text = titleArr[indexPath.item]
                
          //      let url = URL(string: imgArrDef[indexPath.item])
           //     let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
              //  cell.img.layer.cornerRadius = 30
             //   cell.img.clipsToBounds = true
             //   cell.img.image =  UIImage(data: data!)
                
            //    cell.lbl.text = titleArrDef[indexPath.item]
          //  }
    //    }
        
        
        
        
        
        
        if(titleArr.count > 0)
        {
            cell.lbl.text = titleArr[indexPath.item]
            
            
            //cell.img.sd_setImage(with: URL(string: linkArr[indexPath.section]), placeholderImage: UIImage(named: "Loading.png"))
            
            let url = URL(string: imgArr[indexPath.item])
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.img.layer.cornerRadius = 30
            cell.img.clipsToBounds = true
            cell.img.image =  UIImage(data: data!)
            
            self.defaults.setValue(imgArr, forKey: "imgArrDef")
            self.defaults.setValue(linkArr, forKey: "linkArrDef")
            self.defaults.setValue(titleArr, forKey: "titleArrDef")
            
            
        }
        
        
        
        return cell
        }
        
        
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "GuidesCell", for: indexPath) as! CV2
        
        cell2.img.layer.cornerRadius = 15
        cell2.img.clipsToBounds = true
        var num = indexPath.row
        cell2.img.image = UIImage(named: disasters[num])
        cell2.lbl.text = disasters[num]
        
        return cell2
        
    }
    
    
    
   
    
    
    
    private let database = Database.database().reference()
   
    var test = [String: String]()
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    
    let defaults = UserDefaults.standard


    
    

      // Printing the value
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database.child("Articles").observeSingleEvent(of: .value, with: {snapshot in
            
            for case let child as DataSnapshot in snapshot.children {
                    guard let value = child.value as? [String:Any] else {
                        print("Error")
                        return
                    }
                
                self.defaults.setValue(value, forKey: "DictValue") //Saved the Dictionary in user default
                    
                print(value["title"]! as! String);
                print("Aight")
                self.titleArr.append(value["title"]! as! String)
                self.imgArr.append(value["image"]! as! String)
                self.linkArr.append(value["link"]! as! String)
                
             
                }
            
            self.collectionV.reloadData()
        })
        
        
    }
   
    
    
   
    
    
}

