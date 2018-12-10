//
//  StoreTableViewController.swift
//  DoorDash
//
//  Created by ilyas on 12/09/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var exploreTableView: UITableView!
    var stores = [Store]()

    var annotation: Annotation?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "DoorDash"
        setLeftBarButtonItem()
        fetchDataFromServer((annotation?.location ?? nil)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableview is under tabbar issue fixes
        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.tabBarController!.tabBar.frame.height, right: 0)
        self.exploreTableView.contentInset = adjustForTabbarInsets
        self.exploreTableView.scrollIndicatorInsets = adjustForTabbarInsets
        self.automaticallyAdjustsScrollViewInsets = false
    }

    // custom left bar button item
    func setLeftBarButtonItem()
    {
        let button  = UIButton(type: .custom)
        if let image = UIImage(named:"nav-address@2x.png") {
            button.setImage(image, for: .normal)
        }
        button.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 30, height: 30))
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.tabBarController?.navigationItem.leftBarButtonItem = barButton
    }
    
    // navigate back to MapViewController
    @objc func buttonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stackedcell") as! ExploreTableViewCell
    
        cell.storeName.text = stores[indexPath.row].business.name
        cell.storeDescription.text = stores[indexPath.row].description
        cell.deliveryTime.text = stores[indexPath.row].status
        if stores[indexPath.row].deliveryFee > 0, let deliveryFee = stores[indexPath.row].deliveryFee.currency {
            cell.deliveryFee.text = deliveryFee + " delivery"
        } else {
            cell.deliveryFee.text = "Free delivery"
        }
        if let url = URL(string: stores[indexPath.row].coverImgUrl) {
            cell.storeImage.downloaded(from: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func fetchDataFromServer(_ location : Location)
    {
        let service = StoreSearchService(location: Observer(Location(lat: annotation?.location.lat ?? 0.0, lng: annotation?.location.lng ?? 0.0)))
        
        // service call
        service.getData() {result in
            switch result {
            case .success(let storeSearchData):
                // response data to refresh tableview
                self.stores = storeSearchData
            DispatchQueue.main.async {
                self.exploreTableView.reloadData()
            }
            case .failure(let error):
                DispatchQueue.main.async(execute: {
                    // issue an alert
                    self.showAlert(heading: "Found an Issue", message: error as? String ?? "Error", buttonTitle: "OK")
                })
            }
        }
    }
}
