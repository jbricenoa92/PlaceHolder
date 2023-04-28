//
//  PotsViewController.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 27/04/23.
//

import UIKit

class PotsViewController: UIViewController , PostPresenterDelegate{

    

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    var filterPosts: [Post] = []
    var id: User?
    weak var delegate: PostPresenterDelegate?
    private let presenter = PostPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        tableView.dataSource = self
        tableView.delegate = self
        presenter.setViewDelegate(delegate: self)
        let nibs = UINib(nibName: "SpostCellTableViewCell", bundle: nil)
        tableView.register(nibs, forCellReuseIdentifier: "SpostCellTableViewCell")
        presenter.getPostFromService()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        self.filterPosts = posts
        self.tableView.reloadData()
    }
    func configureView() {
        title="PUBLICACIONES"
    }

    func getPresenterPost(post: [Post]) {
        self.posts = post
        DispatchQueue.main.async {
            self.tableView.isUserInteractionEnabled = true
            self.posts = post
            self.getPPostById(id: (self.id?.id)!)
            self.tableView.reloadData()
            
        }
    }
    
    func getPresenterPostById(post: [Post]) {
   
        self.filterPosts = post
        DispatchQueue.main.async {
            self.tableView.isUserInteractionEnabled = true
            self.filterPosts = post
            self.tableView.reloadData()
        }
    }
    
    func getPPostById(id: Int) {
        presenter.getPostByIdFromService(id: id)
    }
 
}
extension PotsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var post = filterPosts[indexPath.row]
            let customCell = tableView.dequeueReusableCell(withIdentifier: "SpostCellTableViewCell", for: indexPath) as! SpostCellTableViewCell
            post.index = indexPath.row
     
        customCell.configure(post: post)
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPosts.count;
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
}

extension PotsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
