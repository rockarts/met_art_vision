//
//  DepartmentRowView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-28.
//

import SwiftUI

struct DepartmentRowView: View {
    
    var department: Department
    
    var body: some View {
        Text(department.displayName).font(.title).tag(department)
    }
    
    init(department: Department) {
        self.department = department
    }
}

#Preview {
    DepartmentRowView(department: .example)
}
