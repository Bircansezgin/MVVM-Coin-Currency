//
//  ViewController.swift
//  CryptoMVVM
//
//  Created by Bircan Sezgin on 11.08.2023.
//

import UIKit
import RxCocoa
import RxSwift

// Yorum Satirina alinan 1. yazan ifadeler!
//TableView otomatik bir sekilde dolduruken kullanila bilir.


class HomePage: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var cryptoList = [CryptoModel]()
    let cryptoViewModel = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
// 1       tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        cryptoViewModel.requestData()
    }
    
    private func setupBindings(){
        
        cryptoViewModel
            .loading
            .bind(to: self.loading.rx.isAnimating)
            .disposed(by: disposeBag)
        
        cryptoViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
                
            }
            .disposed(by: disposeBag)
        
        cryptoViewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance) //Threads Katman
            .subscribe { cryptoList in
                self.cryptoList =  cryptoList
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
//       1 cryptoViewModel.cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .bind(to: tableView.rx.items(cellIdentifier: "cell",cellType: CryptoTableViewCell.self)) {row,item,cell in
//                cell.item = item
//            }
//            .disposed(by: disposeBag)
//
        
        
    }

    

}

extension HomePage: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cryptoInfo = cryptoList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CryptoTableViewCell
        
        cell.cryptoNameLabel.text = cryptoInfo.currency
        cell.cryptoPrice.text = cryptoInfo.price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cryptoInfoSelected = cryptoList[indexPath.row]
        print("Currency : \(cryptoInfoSelected.currency) \nPrice : \(cryptoInfoSelected.price)\n")
    }
}
