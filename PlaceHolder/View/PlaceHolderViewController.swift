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
    var users: [User] = []
    var filteredUsers: [User] = []
    var publications: [Publications] = []
    let cellHeight: CGFloat = 130
    weak var delegate: PlaceHolderPresenterDelegate?
    private let presenter = PlaceHolderPresenter()
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    let items = [
           ("Título 1", "Contenido 1"),
           ("Título 2", "Contenido 2"),
           ("Título 3", "Contenido 3")
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        presenter.setViewDelegate(delegate: self)
        super.viewDidLoad()
        let nib = UINib(nibName: "placeHolderCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "placeHolderCellTableViewCell")
        presenter.getuserFromService()
        presenter.getPostFromService()
        self.filteredUsers = users
        self.tableView.reloadData()
    }

    func configureView() {
        title="PlaceHolder"
        //self.searchBar.inputTextUnderline(color: GlobalConstants.Colors.base)
    }
    
    func getPresenterUser(users: [User]) {
        self.users = users
            DispatchQueue.main.async {
                self.tableView.isUserInteractionEnabled = true
                self.filteredUsers = users
            self.tableView.reloadData()
        }
    }
    
    func getPresenterPost(publication: [Publications]) {
        self.publications = publication
        DispatchQueue.main.async {
            self.tableView.isUserInteractionEnabled = true
        self.tableView.reloadData()
        }
    }
    
    func getPresenterPostById(publication: [Publications]) {
        
    }
        
    func showPublications(index: Int) {
        
    }

    func searchUsersByName(_ searchText: String) -> [User] {
        return users.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
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

extension UIView {
    
    func inputTextUnderline(color: UIColor){
        let bottomLine = CALayer()
        bottomLine.backgroundColor = color.cgColor
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(bottomLine)
    }
}

extension PlaceHolderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var user = filteredUsers[indexPath.row]
            let customCell = tableView.dequeueReusableCell(withIdentifier: "placeHolderCellTableViewCell", for: indexPath) as! placeHolderCellTableViewCell
            user.index = indexPath.row
     
        customCell.configure(users: user, content: user.email ?? "a")
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return self.filteredUsers.count
        
     
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension PlaceHolderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
}

