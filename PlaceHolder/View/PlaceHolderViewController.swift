//
//  ViewController.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 24/04/23.
//

import UIKit

class PlaceHolderViewController: UIViewController, PlaceHolderPresenterDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var empty: UILabel!
    
    var users: [User] = []
    var filteredUsers: [User] = []
    var send: User?
    let cellHeight: CGFloat = 130
    weak var delegate: PlaceHolderPresenterDelegate?
    private let presenter = PlaceHolderPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        presenter.setViewDelegate(delegate: self)
        let nib = UINib(nibName: "placeHolderCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "placeHolderCellTableViewCell")
        self.isSaved()
        self.filteredUsers = users
        self.tableView.reloadData()
    }

    func configureView() {
        title="PlaceHolder"
        self.empty.isHidden = true
    }
    
    func getPresenterUser(users: [User]) {
        self.users = users
            DispatchQueue.main.async {
                self.tableView.isUserInteractionEnabled = true
                SessionManager.saveUser(codable: self.encodeToString(users: users))
                self.filteredUsers = users
                self.tableView.reloadData()
        }
    }
        

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPost" {
            let send = segue.destination as! PotsViewController
            send.id = self.send!
        }
    }
    
    func encodeToString(users:[User]) -> String{
        var value:String = ""
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(users)
            if let jsonString = String(data: jsonData, encoding: .utf8){
                value = jsonString
            }
          
        } catch {
            print("Error al serializar los usuarios: \(error.localizedDescription)")
        }
        return value
    }
    
    func encodeFromString(users:String) -> [User]{
        var value:[User] = []
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = users.data(using: .utf8)!
            value = try jsonDecoder.decode([User].self, from: jsonData)
        } catch {
            print("Error al deserializar los usuarios: \(error.localizedDescription)")
        }
        return value
    }
    
    func isSaved(){
        if(SessionManager.getUser() != nil){
            var getUSers:String = SessionManager.getUser()!
            self.users = encodeFromString(users:getUSers)
            self.filteredUsers = encodeFromString(users:getUSers)
        } else {
            presenter.getuserFromService()
        }
    }
    
    func searchUsersByName(_ searchText: String) -> [User] {
        var result = users.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        if(result.count < 1 && searchText.count > 0){
            self.empty.isHidden = false
        } else{
            self.empty.isHidden = true
        }
        return result
    }

}


extension PlaceHolderViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = []
        if searchText == "" {
            filteredUsers = users
        } else {
            filteredUsers = searchUsersByName(searchText)
        }
        self.tableView.reloadData()
        
    }
}


extension PlaceHolderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var user = filteredUsers[indexPath.row]
            let customCell = tableView.dequeueReusableCell(withIdentifier: "placeHolderCellTableViewCell", for: indexPath) as! placeHolderCellTableViewCell
            user.index = indexPath.row
        customCell.configure(users: user)
        return customCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count;
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
}

extension PlaceHolderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: false)
        self.send = users[indexPath.row]
        performSegue(withIdentifier: "showPost", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
}

