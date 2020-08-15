//
//  ViewController.swift
//  Warikang
//
//  Created by 이승기 on 2020/08/13.
//

import UIKit

class ViewController: UIViewController {

    
    let toolBarKeyboard = UIToolbar()
    
    @IBOutlet weak var mainContentScrollView: UIScrollView!
    
    @IBOutlet weak var creditImg: UIImageView!
    
    
    @IBOutlet weak var alcholImg: UIImageView!
    @IBOutlet weak var alcholCntLabel: UILabel!
    @IBOutlet weak var alcholCntStpr: UIStepper!
    
    @IBOutlet weak var nonAlcholImg: UIImageView!
    @IBOutlet weak var nonAlcholCntLabel: UILabel!
    @IBOutlet weak var nonAlcholStpr: UIStepper!
    
    @IBOutlet weak var foodBillImg: UIImageView!
    @IBOutlet weak var foodBillTF: UITextField!
    
    @IBOutlet weak var drinkBillImg: UIImageView!
    @IBOutlet weak var drinkBillTF: UITextField!
    
    @IBOutlet weak var coinImg: UIImageView!
    @IBOutlet weak var unitBy100WonSwitch: UISwitch!
    
    
    @IBOutlet weak var calculateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButtonOnKeyboard()
        
        setMainContentScrollView()
        
        setAlcholContent()
        setNonAlcholContent()
        setFoodBillContent()
        setDrinkBillContent()
        
        setUnitContent()
        
        setCalculateButton()
    }
    
    
    func addDoneButtonOnKeyboard(){
        toolBarKeyboard.sizeToFit()
        let btnDoneBar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnClicked(_:)))
        toolBarKeyboard.items = [btnDoneBar]
        toolBarKeyboard.tintColor = UIColor(named: "basicButtonBackgroundColor")
    }
    
    @objc
    func doneBtnClicked(_ sender: Any){
        self.view.endEditing(true)
    }

    func setMainContentScrollView(){
        mainContentScrollView.keyboardDismissMode = .onDrag
    }
    
    func setAlcholContent(){
        setImageShadow(alcholImg)
        alcholCntStpr.autorepeat = true
        alcholCntStpr.maximumValue = 99
        alcholCntStpr.wraps = true
    }
    
    func setNonAlcholContent(){
        setImageShadow(nonAlcholImg)
        nonAlcholStpr.autorepeat = true
        nonAlcholStpr.maximumValue = 99
        nonAlcholStpr.wraps = true
    }
    
    func setFoodBillContent(){
        setImageShadow(foodBillImg)
        foodBillTF.inputAccessoryView = toolBarKeyboard
        foodBillTF.keyboardType = .numberPad
        foodBillTF.layer.cornerRadius = 15
        foodBillTF.backgroundColor = UIColor(named: "basicTextFieldBackgroundColor")
    }
    
    func setDrinkBillContent(){
        setImageShadow(drinkBillImg)
        drinkBillTF.inputAccessoryView = toolBarKeyboard
        drinkBillTF.keyboardType = .numberPad
        drinkBillTF.layer.cornerRadius = 15
        drinkBillTF.backgroundColor = UIColor(named: "basicTextFieldBackgroundColor")
    }

    
    func setUnitContent(){
        unitBy100WonSwitch.isOn = UserDefaults.standard.bool(forKey: "unitSwitchState")
        setImageShadow(coinImg)
    }
    
    func setCalculateButton(){
        calculateButton.layer.cornerRadius = 15
        calculateButton.layer.shadowOpacity = 0.8
        calculateButton.layer.shadowColor = UIColor(named: "basicButtonBackgroundColor")?.cgColor
        calculateButton.layer.shadowOffset = .zero
        calculateButton.layer.shadowRadius = 10
    }
    
    func setCreditButton(){
        setImageShadow(creditImg)
        
    }
    
    
    @IBAction func alcholCntStprValueChanged(_ sender: UIStepper) {
        alcholCntLabel.text = Int(sender.value).description
    }
    
    @IBAction func nonAlcholCntStprValueChanged(_ sender: UIStepper) {
        nonAlcholCntLabel.text = Int(sender.value).description
    }
    

    @IBAction func unitSwitchAction(_ sender: Any) {
        UserDefaults.standard.set(unitBy100WonSwitch.isOn, forKey: "unitSwitchState")
    }
    
    @IBAction func creditButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "CreditSegue", sender: nil)
    }
    
    @IBAction func startCalculateButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "ResultSegue", sender: nil)
    }
    
    
    

    func setImageShadow(_ image: UIImageView){
        image.clipsToBounds = false
        image.layer.shadowColor =  UIColor.gray.cgColor
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 5
        image.layer.shadowOpacity = 0.5
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ResultSegue":
            guard let rvc = segue.destination as? ResultViewController else {return}
            
            let foodBill = Int(foodBillTF.text!) ?? 0
            let drinkBill = Int(drinkBillTF.text!) ?? 0
            let drunkPeopleCnt = Int(alcholCntLabel.text!) ?? 0
            let soberPeopleCnt = Int(nonAlcholCntLabel.text!) ?? 0
            
            
            if (soberPeopleCnt + drunkPeopleCnt != 0){
                var soberPay = (foodBill / (soberPeopleCnt + drunkPeopleCnt))
                var drunkenPay = 0
                
                if drunkPeopleCnt != 0 {
                    drunkenPay = (soberPay + (drinkBill / drunkPeopleCnt))
                }
                
                if(unitBy100WonSwitch.isOn){
                    soberPay = Int(round(Double(soberPay/100)) * 100)
                    drunkenPay = Int(round(Double(drunkenPay/100))*100)
                }else{
                    soberPay = Int(round(Double(soberPay/10)) * 10)
                    drunkenPay = Int(round(Double(drunkenPay/10))*10)
                }
                
                let change = (foodBill + drinkBill) - (soberPay * soberPeopleCnt) - (drunkenPay * drunkPeopleCnt)
                
                // SET RESULT
                if drunkPeopleCnt != 0 {
                    rvc.receivedDrunkenPeopleCnt = drunkPeopleCnt
                    rvc.receivedDrunkenPay = drunkenPay
                }
                
                if soberPeopleCnt != 0 {
                    rvc.receivedSoberPay = soberPay
                    rvc.receivedSoberPeopleCnt = soberPeopleCnt
                }
                
                rvc.receivedChange = change
                // END
                
                mainContentScrollView.scrollToTop()
            }else{
                print("정확한 값을 입력해 주세요")
            }
        case "CreditSegue":
            guard let rvc = segue.destination as? CreditViewController else {return}
            
            
        default:
            return
        }
        
           
    }
}


extension UIScrollView{
    func scrollToTop(){
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
               setContentOffset(desiredOffset, animated: true)
        
    }
}

