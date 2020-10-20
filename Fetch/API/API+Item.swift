//
//  API+Item.swift
//  Fetch
//
//  Created by Andrew Garcia on 10/20/20.
//

import Foundation

extension API {
    struct Items {
        /**
         Obtains all the items.

         - parameters:
            - completion: A callback executed when the API request succeeds returning the fetched `Item` array.
            - failure: A callback that includes an `Error` if this call fails.
            - error: The error indicating why fetching the items failed.
        */
        static func getAll(completion: @escaping([Item]) -> (), failure: @escaping(Error) -> ()) {
            guard let url = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json") else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    failure(error)
                    return
                }
                
                guard let itemData = data else {
                    failure(NSError(domain: "Unable to obtain items.", code: 404, userInfo: nil))
                    return
                }
                
                do {
                    let itemsArray = try JSONDecoder().decode([Item].self, from: itemData)
                    completion(itemsArray)
                } catch (let error) {
                    failure(error)
                    return
                }
            }.resume()
        }
    }
}
