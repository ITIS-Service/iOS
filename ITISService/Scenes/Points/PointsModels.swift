//
//  PointsModels.swift
//  ITISService
//
//  Created by Timur Shafigullin on 02/12/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Points {
    
    // MARK: - Use cases
    
    enum Fetch {
        struct Response {
            let total: Int
            let points: [Point]
        }
        
        struct ViewModel {
            let totalCount: String
        }
    }
    
    enum Error {
        struct Request {
            
        }
        struct Response {
            let errorMessage: String
        }
        
        struct ViewModel {
            let title: String
            let subtitle: String
            let buttonTitle: String
            let imageName: String
        }
    }
    
    // MARK -
    
    enum TableView {
        struct Model: TableViewCompatible {
            
            let title: String
            let description: String
            let count: Int
            
            var reuseIdentifier: String {
                return PointTableViewCell.identifier()
            }
            
            func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PointTableViewCell
                cell.configure(with: self)
                return cell
            }
        }
    }
}
