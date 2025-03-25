//
//  ContentView.swift
//  Pokedex_MVVM
//
//  Created by Developer on 19/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    
    private let adaptativeColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptativeColumns, spacing: 10) {
                    ForEach(vm.filteredPokemon){ pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonView(pokemon: pokemon)
                        }
                        
                    }
                }
                .animation(.easeIn, value: vm.filteredPokemon.count)
                .navigationTitle("Pokedex")
               
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbarBackground(Color.red, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .padding(.vertical)
                
            }
            .searchable(text: $vm.searchText)
            
        }
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
