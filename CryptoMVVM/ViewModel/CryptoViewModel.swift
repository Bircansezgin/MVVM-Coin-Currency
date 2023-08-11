//
//  CryptoViewModel.swift
//  CryptoMVVM
//
//  Created by Bircan Sezgin on 11.08.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel{
    
    
    let cryptos: PublishSubject<[CryptoModel]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject() // Loading Ekran
    
    
    func requestData(){
        self.loading.onNext(true)
        let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadAPi(url: url) { resuls in
            self.loading.onNext(false)
            switch resuls{
            case .success(let cryptoS):
                self.cryptos.onNext(cryptoS)
            case .failure(let error):
                switch error{
                case .parsingError:
                    self.error.onNext("parsingError")
                case .serverError:
                    self.error.onNext("ServerError")
                }
            }
        }
    }
}
