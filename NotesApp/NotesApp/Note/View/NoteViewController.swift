//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Darina Kovtun on 12.05.2024.
//

import UIKit

final class NoteViewController: UIViewController {
    // MARK: - GUI Variables
    private let attachmentView: UIImageView = {
       let view = UIImageView()
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
    
        return view
    }()
    
    // MARK: - Properties
    var viewModel: NoteViewModelProtocol?
    var textObserver: NSKeyValueObservation?
    private var isTextChanged: Bool = false
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: textView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        updateSaveButton()
        setupBars()
    }

    // MARK: - Methods
    private func configure() {
        textView.text = viewModel?.text
//        guard let imageData = note.image,
//              let image = UIImage(data: imageData) else { return }
//        attachmentView.image = image
    }
    
    // MARK: - Private methods
    @objc func textDidChange() {
        isTextChanged = true
        updateSaveButton()
        setupBars()
    }

    @objc
    private func saveAction() {
        viewModel?.save(with: textView.text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func deleteAction() {
        viewModel?.delete()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func photoAction() {
        
    }
    
    @objc
    private func categoryAction() {
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(attachmentView)
        view.addSubview(textView)
        
        setupConstraints()
        setImageHeight()
        
        let recognizer = UITapGestureRecognizer(target: self, 
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-10)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentView.image != nil ? 200 : 0
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    @objc
    private func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    private func setupBars() {
        let spacing = UIBarButtonItem(systemItem: .flexibleSpace)
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                          target: self,
                                          action: #selector(deleteAction))
        let photoButton = UIBarButtonItem(barButtonSystemItem: .camera,
                                          target: self,
                                          action: #selector(photoAction))
        let categoryButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(categoryAction))
        if !textView.text.isEmpty {
            setToolbarItems([trashButton, spacing, photoButton, spacing, categoryButton], animated: true)
        } else {
            navigationItem.rightBarButtonItem = nil
            setToolbarItems([photoButton, spacing, categoryButton], animated: true)
        }
    }
    
    private func updateSaveButton() {
        if  textView.text.isEmpty || isTextChanged {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                target: self,
                                                                action: #selector(saveAction))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
