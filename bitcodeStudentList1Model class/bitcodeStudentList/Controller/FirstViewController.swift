
import UIKit
class FirstViewController: UIViewController, UITableViewDelegate{
    //MARK: Outlet
    @IBOutlet weak var studentList: UITableView!
    //MARK: Array Declaration
    var studentArray: [StudentModel] = []
    //MARK: Life cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentList.dataSource = self
        let nibFile = UINib(nibName: "StudentTableViewCell", bundle: nil)
        self.studentList.register(nibFile, forCellReuseIdentifier: "StudentTableViewCell")
    }
    //MARK: Button Action-RightBarButton Acion
    @IBAction func addStudent(_ sender: Any) {
        if let secondVc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController{
            secondVc.delegeteSVC = self
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}

//MARK: DataSource Method Protocol
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studentArray.count == 0     {
            let label: UILabel = UILabel()
            label.text = "Data Is not available"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .red
            label.textAlignment = .center
            label.numberOfLines = 1
            studentList.backgroundView = label
            return 0
        } else {
            studentList.backgroundView = nil
            return studentArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.studentList.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as?  StudentTableViewCell else{
            return UITableViewCell()
        }
        let students = studentArray[indexPath.row]
        cell.nameLabel.text = students.name
        cell.ageLabel.text = String(students.age)
        cell.phoneLabel.text = students.phoneNumber
        cell.technologyLabel.text = students.technology
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            studentList.beginUpdates()
            studentArray.remove(at: indexPath.row)
            studentList.deleteRows(at: [indexPath], with: .fade)
            studentList.endUpdates()
        }
    }
}

//MARK: BackWard Data Passing Protocol
extension FirstViewController: BackwardDataPassingProtocol
{
    func passData(student: StudentModel)  {
        let student = StudentModel(
            name: student.name, age: student.age, phoneNumber: student.phoneNumber, technology: student.technology)
        studentArray.append(student)
        studentList.reloadData()
    }
}





