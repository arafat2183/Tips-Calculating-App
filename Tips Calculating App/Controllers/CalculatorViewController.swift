
import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberIfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        billTextField.endEditing(true)
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        
        let buttonTitleMinusParcentSign = String(buttonTitle.dropLast())
        
        let buttonTitleAsAnswer = Double(buttonTitleMinusParcentSign)!
        
        tip = buttonTitleAsAnswer / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberIfPeople = Int(sender.value)
        print(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
//        print(tip)
//        print(billTextField.text!)
        
        let bill = billTextField.text!
        
        if bill != "" {
            billTotal = Double(bill)!
            
            let result = billTotal * (1 + tip) / Double(numberIfPeople)
            
            finalResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberIfPeople
        }
    }
}

