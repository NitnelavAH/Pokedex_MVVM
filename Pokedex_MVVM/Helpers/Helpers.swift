//
//  Helpers.swift
//  Pokedex_MVVM
//
//  Created by Developer on 19/03/25.
//

import Foundation
extension Bundle {
    
    //Este método permite cargar y decodificar un archivo JSON almacenado en el bundle de la aplicación.
    func decode<T:Decodable>(file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
    
    //Este método realiza una solicitud HTTP para obtener y decodificar un JSON desde una URL remota.
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (),
failure:@escaping(Error) -> ()) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
            
        }
        .resume()
    }
}
