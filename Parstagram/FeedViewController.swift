//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Annas Waheed on 10/3/22.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var totalposts: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func increasePost(){
        totalposts = totalposts + 5
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        //totalposts = 10
        query.limit = totalposts
        
        query.findObjectsInBackground { (posts,error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
            else{
                print("Here is the error")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        totalposts = 10
        query.limit = totalposts
        
        query.findObjectsInBackground { (posts,error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
            else{
                print("Here is the error")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af.setImage(withURL: url)
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

            if indexPath.row + 1 == posts.count {

                increasePost()

            }

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
