//
//  ViewController.swift
//  HealthKitEdition
//
//  Created by Airi Furukawa on 2022/09/23.
//

import UIKit

class ViewController: UIViewController {

    var img01 :UIImage = UIImage(named:"Helen Keller")!
    var img02 :UIImage = UIImage(named:"Mary Lou Retton")!
    var img03 :UIImage = UIImage(named:"Mother Teresa")!
    var img04 :UIImage = UIImage(named:"Walt Disney")!
    var img05 :UIImage = UIImage(named:"Audrey Hepburn")!
    var img06 :UIImage = UIImage(named:"Albert Einstein")!
    var img07 :UIImage = UIImage(named:"Nelson Mandela")!
    var img08 :UIImage = UIImage(named:"Eleanor Roosevelt")!
    var img09 :UIImage = UIImage(named:"Mark Twain")!
    var img10 :UIImage = UIImage(named:"Bob Marley")!
    var imgArray:[UIImage] = []
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageview.image = [img01, img02, img03, img04, img05, img06, img07, img08, img09, img10].randomElement()!
    }

}

