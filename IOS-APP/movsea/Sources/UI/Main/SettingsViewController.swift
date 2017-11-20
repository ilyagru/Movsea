//
//  SettingsViewController.swift
//  movsea
//
//  Created by Movsea Team on 10/12/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit

let SettingsCellIdentifer = "SettingsCellIdentifer"

class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
 
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SettingsCellIdentifer)
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: SettingsCellIdentifer)
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.textLabel?.text = "Write to us / report a bug"
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: Hardcoded for one row
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: R.segue.settingsViewController.showFeedbackScreen, sender: self)
    }

}
