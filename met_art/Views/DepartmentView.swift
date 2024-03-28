//
//  DepartmentView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-22.
//

import SwiftUI

struct DepartmentView: View {
    
    let departmentVM = DepartmentViewModel()
    @State private var departmentIds: Set<Department.ID> = []
    
    var body: some View {
        NavigationSplitView {
            List(departmentVM.departments, selection: $departmentIds) { department in
                Text("\(department.displayName)")
                    .font(.title)
            }
            
        } detail: {
            if let departmentId = departmentIds.first {
                ArtworkListView(department: departmentVM.departments.first {
                    $0.id == departmentId
                }!)
            } else {
                Text("Select a department to see art pieces")
                    .font(.title)
            }
        }.task {
            do {
                try await departmentVM.fetchAndDecodeDepartments()
            } catch {
                print("Error loading data: \(error)")
            }
        }
    }
}

#Preview {
    DepartmentView()
}
