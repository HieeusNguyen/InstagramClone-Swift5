//
//  EditProfileViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 15/1/25.
//

import UIKit

struct EditProfileFormModel{
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController, UITableViewDataSource{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configreModels()
        view.backgroundColor = .systemBackground
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    private func configreModels(){
        //Name, Username, Website, Bio
        let section1Label = ["Name", "Username","Website", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Label {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section1.append(model)
        }
        models.append(section1)
        //Email, Phone, Gender
        let section2Label = ["Email", "Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Label {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView
    private func createTableHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Private Infomation"
    }
    
    //MARK: - Action
    
    @objc private func didTapSave(){
        //Save info to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            //
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            //
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        actionSheet.popoverPresentationController?.sourceView = view
        
        present(actionSheet, animated: true)
    }
}

extension EditProfileViewController: FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel?) {
        //Update the model
        print("Form update to: \(updateModel?.value ?? "nil")")
    }
}
