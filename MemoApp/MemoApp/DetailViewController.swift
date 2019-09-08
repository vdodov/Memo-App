//
//  DetailViewController.swift
//  MemoApp
//
//  Created by 차수연 on 08/09/2019.
//  Copyright © 2019 차수연. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var memoTableView: UITableView!
  
  let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    formatter.locale = Locale(identifier: "Ko_kr")
    return formatter
  }()
  
  
  var memo: Memo?
  
  @IBAction func share(_ sender: Any) {
    //공유할 메모를 새로운 상수에 바인딩
    guard let memo = memo?.content else { return }
    
    let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
    present(vc, animated: true, completion: nil)
  }
  
  @IBAction func deleteMemo(_ sender: Any) {
    let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제할까요?", preferredStyle: .alert)
    
    let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (action) in
      DataManager.shared.deleteMemo(self.memo)
      //이전화면으로 돌아가기
      self.navigationController?.popViewController(animated: true)
    }
    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    
    alert.addAction(deleteAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination.children.first as? ComposeViewController {
      vc.editTarget = memo
    }
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    memoTableView.reloadData()
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
      
      cell.textLabel?.text = memo?.content
      
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
      
      cell.textLabel?.text = formatter.string(for: memo?.insertDate)
      
      return cell
    default:
      fatalError()
    }
  }
  
  
}
