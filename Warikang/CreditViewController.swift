//
//  CreditViewController.swift
//  WarikangMon
//
//  Created by 이승기 on 2020/08/15.
//

import UIKit

class CreditViewController: UIViewController{
    
    @IBOutlet weak var appIconDinoImg: UIImageView!
    @IBOutlet weak var drunkenDinoImg: UIImageView!
    @IBOutlet weak var soberDinoImg: UIImageView!
    @IBOutlet weak var sojuImg: UIImageView!
    @IBOutlet weak var chickenImg: UIImageView!
    @IBOutlet weak var coinImg: UIImageView!
    @IBOutlet weak var forbidImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImages()
    }
    
    func setImages(){
        setImageShadow(appIconDinoImg)
        setImageShadow(drunkenDinoImg)
        setImageShadow(soberDinoImg)
        setImageShadow(sojuImg)
        setImageShadow(chickenImg)
        setImageShadow(coinImg)
        setImageShadow(forbidImg)
    }
    
    func setImageShadow(_ image: UIImageView){
        image.clipsToBounds = false
        image.layer.shadowOpacity = 0.5
        image.layer.shadowRadius = 10
        image.layer.shadowOffset = .zero
        image.layer.shadowColor = UIColor.gray.cgColor
    }
}
