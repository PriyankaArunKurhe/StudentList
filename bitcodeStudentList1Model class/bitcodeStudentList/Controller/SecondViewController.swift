
import UIKit
class SecondViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var technologyTF: UITextField!
    //MARK: Link Protocol via delegate Property
    weak var delegeteSVC: BackwardDataPassingProtocol?
    //MARK: Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: Button Action - RightBar Button Action
    @IBAction func saveData(_ sender: Any) {
        guard let delegate = delegeteSVC else
        {
            return
        }
        if(nameTF.text != "" && phoneTF.text != "" && ageTF.text != "" && technologyTF.text != "")  {
            if(Int(ageTF.text!) != nil)
            {
                let dataToPassL1 = self.nameTF.text ?? ""
                let dataToPassL2 = self.phoneTF.text ?? ""
                let myAge = ageTF.text ?? ""
                let dataToPassL3 = Int(myAge) ?? 0
                let dataToPassL4 = self.technologyTF.text ?? ""
                let student1 = StudentModel(name: dataToPassL1, age: dataToPassL3, phoneNumber: dataToPassL2, technology: dataToPassL4)
                var total = delegate.passData(student: student1)
                let alert = UIAlertController(title: "Succeeded", message: "Data Save Successfully...", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { action in
                    self.navigationController?.popViewController(animated: true)}))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Cancelled", message: "Age must be Int", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)    }
        }
        else {
            let alert = UIAlertController(title: "Cancelled", message: "Fill the data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)    }
    }
}
