//
//  SortViewController.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 8.05.2024.
//

import UIKit

protocol SortTypeDelegate {
    func sendType(_ text: String)
}

class SortViewController: UIViewController {
    
    let sortingTypes = ["Price ▼","Price ▲", "Market Cap ▼", "Market Cap ▲", "24h Volume ▼", "24h Volume ▲", "Change ▼", "Change ▲"]
    var delegate: SortTypeDelegate?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Constants.sortCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.sortCellIdentifier)
    }
}

extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortingTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.sortCellIdentifier, for: indexPath) as? SortCell else { return UITableViewCell()}
        cell.configure(with: sortingTypes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sendType(sortingTypes[indexPath.row])
        dismiss(animated: true)
    }
}
