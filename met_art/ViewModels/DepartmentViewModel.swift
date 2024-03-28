//
//  DepartmentViewModel.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import Foundation
import Combine

@Observable
class DepartmentViewModel {
    var departments: [Department] = []
    
    let decoder = JSONDecoder()
    var subscriptions = Set<AnyCancellable>()
    
    func fetchAndDecodeDepartments() async throws  {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/departments")!)
            .map { $0.data }
            .decode(type: DepartmentsData.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(
               receiveCompletion: { completion in
                   if case .failure(let error) = completion {
                       print(error)
                   }
               },
               receiveValue: { departmentData in
                   self.departments = departmentData.departments
               })
             .store(in: &subscriptions)
    }
}
