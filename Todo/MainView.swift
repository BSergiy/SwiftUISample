//
//  MainView.swift
//  Todo
//
//  Created by Сергей Бородин on 26.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var menuOpen = false
    
    var body: some View {
        ZStack{
            DashboardView()
                .environmentObject(g_todoList)
                .gesture(DragGesture(minimumDistance: 100)
                    .onEnded{_ in self.openMenu()})
    
//            SideMenuView(width: 270,
//                         isOpen: self.menuOpen,
//                         menuClose: self.openMenu)
        }
    }
    
    func openMenu(){
        menuOpen.toggle()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
