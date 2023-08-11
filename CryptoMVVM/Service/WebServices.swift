//
//  WebServices.swift
//  CryptoMVVM
//
//  Created by Bircan Sezgin on 11.08.2023.
//

import Foundation

enum CryptoError : Error{
    case serverError
    case parsingError
}

class WebService{
    func downloadAPi(url: URL, completion: @escaping (Result<[CryptoModel],CryptoError>) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                completion(.failure(CryptoError.serverError))
            }else if let data = data {
                let cryptoList = try? JSONDecoder().decode([CryptoModel].self, from: data)
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }else{
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
