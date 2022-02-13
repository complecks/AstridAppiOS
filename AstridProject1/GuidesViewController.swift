//
//  GuidesViewController.swift
//  AstridProject1
//
//  Created by Harshith Sadhu on 1/30/22.
//

import UIKit

class GuidesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let disasters = ["Flood", "Blizzard", "Earthquake", "Tornado", "Volcano", "Lightning Storm"]
    
    
    func collectionView(_ collectionView: UICollectionView,
      didSelectItemAt indexPath: IndexPath) {
        
            performSegue(withIdentifier: disasters[indexPath.row], sender: self)
        
      }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return disasters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "GuidesCell", for: indexPath) as! CV2
        
        cell2.img.layer.cornerRadius = 15
        cell2.img.clipsToBounds = true
        var num = indexPath.row
        cell2.img.image = UIImage(named: disasters[num])
        cell2.lbl.text = disasters[num]
        
        return cell2
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var guidesVC: UICollectionView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
