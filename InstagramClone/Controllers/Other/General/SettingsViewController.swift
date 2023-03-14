//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by macbook pro on 7.03.2023.
//

import UIKit
import SafariServices

struct SettingCellModal {
    let title: String
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [[SettingCellModal]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        data.append([
            SettingCellModal(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModal(title: "Invite Friends") { [weak self] in
                self?.didTapinviteFriends()
            },
            SettingCellModal(title: "Save Original Posts") { [weak self] in
                self?.didTapsaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingCellModal(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModal(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModal(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])

        data.append([
            SettingCellModal(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
        
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
            switch type {
            case .help: urlString = "https://help.instagram.com/"
            case .privacy: urlString = "https://help.instagram.com/196883487377501"
            case .terms: urlString = "https://help.instagram.com/581066165581870"
            }
        
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        }
    
    private func didTapHelp() {
        
    }
    
    private func didTapTerms() {
        
    }
    
    private func didTapsaveOriginalPosts() {
        
    }
    
    private func didTapinviteFriends() {
        
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapPrivacy() {
        
    }
    
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure to want log out?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        fatalError("Could not log out user")
                    }
                }
            }
        }))
        
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        actionSheet.popoverPresentationController?.sourceView = tableView
        present(actionSheet, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
