//
//  InfoViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private lazy var todoTitile: UILabel = {
        let label = UILabel()
        label.text = "none"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.isHidden = true
        return label
    }()
    
    private lazy var planetTitle: UILabel = {
        let label = UILabel()
        label.text = "none"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.isHidden = true
        return label
    }()
    var coordinator: FeedFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url) {data , response, error in
            if let error {return}
            
            if let httpResponse = response as? HTTPURLResponse {}
            guard let data else {return}
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data)
                if let dictionary = jsonData as? [String: Any]{
                    DispatchQueue.main.async {
                        self.todoTitile.text = dictionary["title"] as? String ?? ""
                        self.todoTitile.isHidden = false
                    }
                }
            }catch {
            }
        }
        task.resume()
        
        guard let urlPlanet = URL(string: "https://swapi.dev/api/planets/1") else {return}
        let sessionPlanet = URLSession.shared
        let taskPlanet = sessionPlanet.dataTask(with: urlPlanet) {data , response, error in
            if let error {return}
            
            if let httpResponse = response as? HTTPURLResponse {}
            guard let data else {return}
            do{
                let planet = try JSONDecoder().decode(PlanetModel.self, from: data)
                DispatchQueue.main.async {
                    self.planetTitle.text = "Orbital period is \(planet.orbitalPeriod)"
                    self.planetTitle.isHidden = false
                }
            }catch {
            }
        }
        taskPlanet.resume()
        
        view.addSubview(actionButton)
        view.addSubview(todoTitile)
        view.addSubview(planetTitle)
       
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            todoTitile.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todoTitile.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            todoTitile.heightAnchor.constraint(equalToConstant: 40.0),
            todoTitile.widthAnchor.constraint(equalToConstant: 200.0),
            
            planetTitle.topAnchor.constraint(equalTo: todoTitile.bottomAnchor,constant: 30),
            planetTitle.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            planetTitle.heightAnchor.constraint(equalToConstant: 40.0),
            planetTitle.widthAnchor.constraint(equalToConstant: 200.0)
        ])
        
        actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }
 
    @objc func buttonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("What's wrong", comment: "Something went wrong"), style: .default, handler: { _ in
            NSLog("The \"Something went wrong\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }    /*
          /*
           // MARK: - Navigation
           
           // In a storyboard-based application, you will often want to do a little preparation before navigation
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           }
           */
          */
}
