//
//  ResultViewController.swift
//  Warikang
//
//  Created by 이승기 on 2020/08/14.
//

import UIKit

class ResultViewController: UIViewController{
    
    @IBOutlet weak var resultContentView: UIView!
    
    @IBOutlet weak var drunkenDinoImg: UIImageView!
    @IBOutlet weak var resultDrunkenPayLabel: UILabel!
    @IBOutlet weak var drunkenPeopleCntLabel: UILabel!
    var receivedDrunkenPeopleCnt = 0
    var receivedDrunkenPay = 0
    
    @IBOutlet weak var soberDinoImg: UIImageView!
    @IBOutlet weak var resultSoberPayLabel: UILabel!
    @IBOutlet weak var soberPeopleCntLabel: UILabel!
    var receivedSoberPeopleCnt = 0
    var receivedSoberPay = 0
    
    @IBOutlet weak var changeImg: UIImageView!
    @IBOutlet weak var resultChangeLabel: UILabel!
    var receivedChange = 0
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrunkenResultContent()
        setSoberResultContent()
        setChangeResultContent()
        
        setShareButton()
    }
    
    
    func setDrunkenResultContent(){
        setImageShadow(drunkenDinoImg)
        drunkenPeopleCntLabel.text = "\(receivedDrunkenPeopleCnt)"
        resultDrunkenPayLabel.text = "\(receivedDrunkenPay)"
    }
    
    func setSoberResultContent(){
        setImageShadow(soberDinoImg)
        soberPeopleCntLabel.text = "\(receivedSoberPeopleCnt)"
        resultSoberPayLabel.text = "\(receivedSoberPay)"
    }
    
    func setChangeResultContent(){
        setImageShadow(changeImg)
        resultChangeLabel.text = "\(receivedChange)"
    }
    
    func setShareButton(){
        // layout
        shareButton.layer.cornerRadius = 15
        shareButton.layer.shadowColor = UIColor(named: "shareButtonBackgroundColor")?.cgColor
        shareButton.layer.shadowOffset = .zero
        shareButton.layer.shadowRadius = 10
        shareButton.layer.shadowOpacity = 0.5
        
        // functions
        shareButton.addTarget(self, action: #selector(shareButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc
    func shareButtonAction(_ sender: UIButton){
        UIGraphicsBeginImageContextWithOptions(self.resultContentView.bounds.size, false, UIScreen.main.scale)
        self.view?.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        let resultTxt = "술 마신 사람 \(receivedDrunkenPeopleCnt)명\n내야할 돈 : \(receivedDrunkenPay) 원\n\n술 안 마신 사람 \(receivedSoberPeopleCnt)명\n내야할 돈: \(receivedSoberPay)원\n\n나머지 : \(receivedChange)원"
        let textToShare = [resultTxt, screenshot] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func setImageShadow(_ image: UIImageView){
        image.clipsToBounds = false
        image.layer.shadowColor =  UIColor.gray.cgColor
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 5
        image.layer.shadowOpacity = 0.5
    }
    
}
