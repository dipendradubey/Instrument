# Instrument
# We are going to check the code responsible for retaining cycles

Observation
Created memory retain cycle through protocol
1)Checked by using memory leaks but it didn't find the solution.
2)So checked with "Debug Memory Graph" and then get to know which object is not getting deallocated.

Initially the code was defined as below

1)
class DataFetcher{
    var dataProtocol:DataProtocol? //So culprit is hear & now fixing this to weak fixed the issue
    func getData() {
        let dataArray = ["abc", "def", "ghi", "jkl", "MNO", "PQR", "STU", "VWX", "YZ"]
        dataProtocol?.updateView(dataArray)
    }
    
}

class HomeDetailVC: UIViewController, DataProtocol, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tblView: UITableView!
    var dataArray = [String]()
    var dataFetcher = DataFetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        dataFetcher.dataProtocol = self
        dataFetcher.getData()
        // Do any additional setup after loading the view.
    }

2)Tried with Notification & it doesn't cause the memory leaks
  1)Added the observer on VC
  2)But didn't remove that observer but didn't cause the memory leak
  
  
3)checked with closure and it causes the leak 
  1)This could be avoided by using unowned or weak references
  
4)Use symbolic breakpoint to check whether memory is deallocated




