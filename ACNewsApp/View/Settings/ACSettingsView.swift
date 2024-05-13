//
//  SettingsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 10.05.2024.
//

import SwiftUI

struct ACSettingsView: View {
    let viewModel : ACSettingsViewViewModel
    
    init(viewModel: ACSettingsViewViewModel){ //dependency injection
        self.viewModel = viewModel
    }
  
    var body: some View {
      
            List(viewModel.cellViewModels){ viewModel in
                HStack{
                    if let image = viewModel.image{
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .padding(5)
                            .frame(width: 30, height: 30)
                            .background(Color(viewModel.iconContainerColor))
                            .cornerRadius(6)
                            
                    }
                    Text(viewModel.title)
                        .padding(.leading, 10)
                    
                    Spacer()
                }.padding(5)
                    .onTapGesture {
                        viewModel.onTapHandler(viewModel.type) //hücreye dokununca onTapHandler() çalışır.
                    }
            }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ACSettingsView(viewModel: .init(cellViewModels: ACSettingsOption.allCases.compactMap({ //her bir ayar seçeneği için
            return ACSettingsCellViewModel(type: $0) { option in //nesnesi oluşturulur.
            }
        })))
    }
}

