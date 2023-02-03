//
//  ViewController.swift
//  CartListCoreData
//
//  Created by Abul Kashem on 1/2/23.
//

import UIKit
import SDWebImage

protocol ProductViewPresentor {
    func displayView()
}

class ProductViewController: UIViewController, ProductView {

    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var addToCartViewButton: UIButton!
    
    var allProducts : [ShoppingModel]?
    var cartModel = DatabaseHelper()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpTableView()
        fetchData()
        cartModel.cartView = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       _ =  cartModel.fetchCart()
    }

    
    @IBAction func onTapCartView(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else{return}
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setUpTableView(){
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    func saveOnCart(_ index: Int) {
        guard let item = allProducts?[index] else { return }
        cartModel.addToCart(item: item)
    }
    
    func onTapAddCart(index: Int) {
        saveOnCart(index)
    }

    
    func fetchData(){
        let service = WebService()
        service.call(with: "https://fakestoreapi.com/products", httpMethod: "GET", httpBody: nil) { data in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if let data = data {
                    do {
                        self.allProducts = try JSONDecoder().decode([ShoppingModel].self, from: data)
                        self.productTableView.reloadData()
                    }
                    catch _ {
                        //show error alert
                    }
                }
            }
        }
    }
  
    
}

extension ProductViewController: UITableViewDelegate,UITableViewDataSource,CartViewModelDelegate,ProductViewPresentor{
    
    func displayView() {
        productTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.Configure(product: allProducts![indexPath.row])
        cell.delegate = self
        cell.btnAddToCart?.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func displayCartCount(number: Int) {
      addToCartViewButton?.setTitle("\(number)", for: .normal)
    }
    
    
}
