//
//  ViewController.swift
//  Fetch
//
//  Created by Andrew Garcia on 10/20/20.
//

import UIKit

class HomeTableViewController: UITableViewController, ErrorPresenter {
    
    struct Section {
        let header: String
        let items: [Item]
    }
    
    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.Items.getAll { (items) in
            let filteredItems = items.filter({ $0.name != nil && $0.name != "" })
            let groups = Dictionary(grouping: filteredItems, by: { $0.listId }).sorted(by: { $0.0 < $1.0 })
            self.sections = groups.map({ (key, values) in
                let sortedValues = values.sorted(by: { Int.parse(string: $0.name!) < Int.parse(string: $1.name!) })
                return Section(header: "\(key)", items: sortedValues)
            })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } failure: { (error) in
            self.presentError(error)
        }
    }
    
    // MARK: - UITableView Delegate && DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        return section.header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self)) as! HomeTableViewCell
        
        let item = self.sections[indexPath.section].items[indexPath.row]
        cell.titleLabel.text = item.name
        
        return cell
    }
}
