//
//  CartViewController.swift
//  CartListCoreData
//
//  Created by Abul Kashem on 3/2/23.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    var viewModel = DatabaseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel.setupView(view: self)
    }
        
    func setUpTableView(){
        let nib = UINib(nibName: "AddCartTableViewCell", bundle: nil)
        cartTableView.register(nib, forCellReuseIdentifier: "AddCartTableViewCell")
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }

}
extension CartViewController: UITableViewDelegate,UITableViewDataSource,ProductViewPresentor{
    
    func displayCartCount(number: Int) {
        
    }
    
    func displayView() {
        self.cartTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCartTableViewCell", for: indexPath) as! AddCartTableViewCell
        cell.title?.text = viewModel.cartItems?[indexPath.row].itemTitle ?? ""
        let url = viewModel.cartItems?[indexPath.row].url ?? ""
        cell.iconImage?.sd_setImage(with: URL(string: url)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
         return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          if let id = viewModel.cartItems?[indexPath.row] {
            viewModel.deleteToCart(identifer: id)
            }
        }
    }
}
