//
//  ViewController.swift
//  ContactsPicker
//
//  Created by Adaps on 04/12/19.
//  Copyright © 2019 CrazyTricks. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    /// Mark :- storyboard outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnDone: CustomizedBtn!
    @IBOutlet weak var baseView: CustomizedView!
    
    /// Mark :- custom variables

    var contacts = [Contact]()
    var filteredContacts = [Contact]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.getContacts()
    }
    
    override func viewWillLayoutSubviews() {
        self.baseView.setTopShadow(view: self.baseView)
        self.btnDone.setCircularCornerRadius(getView: self.btnDone)
    }
    
    /// Mark :- setup Tableview

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.searchBar.text = nil
        self.searchBar.showsCancelButton = false
        self.searchBar.endEditing(true)
        self.clearArrays()
    }
    
    func clearArrays(){
        self.contacts = [Contact]()
        self.filteredContacts =  [Contact]()
    }
    
    func getContacts(){
        
        let contactStore = CNContactStore()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
            ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                for phoneNumber in contact.phoneNumbers {
                    let phoneNumberValue = phoneNumber.value
                    
                    let name = contact.givenName + " " + contact.familyName
                    let number = phoneNumberValue.stringValue
                    let contactObj = Contact.init(name: name, number: number, isSelected: false)
                    self.contacts.append(contactObj)
                    
                }
                
            }
        } catch {
            print("unable to fetch contacts")
            
        }
        
        self.filteredContacts = self.contacts
        self.tableView.reloadData()
        
    }
    
    @IBAction func onDone(_ sender: Any) {
        
    }
    
}

/// Mark : - UITableViewDelegate Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.item = self.filteredContacts[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let flag = self.filteredContacts[indexPath.row].isSelected
        
        if flag == false{
            self.filteredContacts[indexPath.row].isSelected = true
            
        }else{
            self.filteredContacts[indexPath.row].isSelected = false
            
        }
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

///    Mark:- UISearchBarDelegate

extension ViewController:UISearchBarDelegate, UISearchDisplayDelegate{
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterSelectedObjects()
        self.filteredContacts = searchText.isEmpty ? self.contacts : self.contacts.filter({(contact: Contact) -> Bool in
                        
            let contactNameStr = contact.name
            
            return contactNameStr!.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.filterSelectedObjects()
        self.filteredContacts = self.contacts
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func filterSelectedObjects(){
        
        for filteredContact in self.filteredContacts {
            
            for index in 0..<self.contacts.count {
                
                if filteredContact.number == self.contacts[index].number {
                    self.contacts[index].isSelected = filteredContact.isSelected
                }
                
            }
        }
        
    }
    
}
