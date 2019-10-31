//
//  SideMenuContentView.swift
//  Todo
//
//  Created by Сергей Бородин on 26.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import SwiftUI

struct SideMenuContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Список задач")
                .padding(.bottom)
            Divider()
            Text("Настройки")
            Spacer()
        }
        .padding()
    }
}

struct SideMenuContentView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuContentView()
    }
}
