//
//  ViewController.swift
//  ScrollviewExample
//
//  Created by Ángel González on 10/11/23.
//

import UIKit

class ViewController: UIViewController {
    let textos = ["Lorem ipsum", "dolor sit", "amet, consectetur", "adipiscing elit.", "In vitae", "ultrices ligula,", "id rhoncus", "orci. Mauris", "odio lorem,", "consectetur et", "blandit nec,", "lacinia sed", "ante. Proin", "iaculis elit", "ac accumsan", "porttitor. In", "hac habitasse", "platea dictumst.", "In sollicitudin", "orci risus."]
    let newview = UIScrollView()
    
    @IBOutlet weak var boton: UIButton!
    
    func addLabels() {
        let sView = UIStackView()
        sView.axis = .vertical
        sView.spacing = 2
        sView.translatesAutoresizingMaskIntoConstraints = false
        for texto in textos {
            let lbl = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.text = texto
            lbl.textColor = .white
            lbl.font = UIFont.systemFont(ofSize: 20, weight:.bold)
            lbl.heightAnchor.constraint(equalToConstant:50).isActive = true
            lbl.sizeToFit()
            sView.addArrangedSubview(lbl)
            let icon = UIImage(named: "life")
            let iconContainer = UIImageView(image: icon)
            iconContainer.translatesAutoresizingMaskIntoConstraints = false
            sView.addArrangedSubview(iconContainer)
            iconContainer.heightAnchor.constraint(equalToConstant:50).isActive = true
            iconContainer.leadingAnchor.constraint(equalTo: sView.leadingAnchor, constant: 50).isActive = true
            iconContainer.trailingAnchor.constraint(equalTo: sView.trailingAnchor, constant: -50).isActive = true
        }
        newview.addSubview(sView)
        sView.leadingAnchor.constraint(equalTo:newview.leadingAnchor, constant:0).isActive = true
        sView.trailingAnchor.constraint(equalTo:newview.trailingAnchor, constant:0).isActive = true
        sView.topAnchor.constraint(equalTo:newview.topAnchor, constant:0).isActive = true
        sView.bottomAnchor.constraint(equalTo:newview.bottomAnchor, constant:0).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print ("ya apareció")
        newview.translatesAutoresizingMaskIntoConstraints = false
        newview.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 25).isActive = true
        newview.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: -25).isActive = true
        newview.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        newview.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant: -250).isActive = true
        addLabels()
        // creamos un botón programaticamente
        //let boton = UIButton(type:.custom)
        // lo configuramos
        boton.backgroundColor = .red
        boton.setTitleColor(.yellow, for:.normal)
        boton.setTitle("puch-me", for:.normal)
        boton.layer.cornerRadius = 7.5
        // lo agregamos a la vista padre
        self.view.addSubview(boton)
        // configuramos sus constraints
        boton.translatesAutoresizingMaskIntoConstraints = false
        boton.widthAnchor.constraint(equalToConstant:150).isActive = true
        boton.heightAnchor.constraint(equalToConstant:45).isActive = true
        boton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        boton.topAnchor.constraint(equalTo:newview.bottomAnchor, constant: 15).isActive = true
        // le asignamos un action para cuando el usuario lo toque
        boton.addTarget(self, action:#selector(botonTouch), for:.touchUpInside)
    }
      
    @objc func botonTouch () {
        var msg = "Todo OK"
        if InternetMonitor.shared.internetStatus {
            msg = "No disponible"
        }
        let ac = UIAlertController(title: "hola", message:"conexion a Internet \(msg)", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style:.destructive){
            alertaction in
            print ("El usuario tocó el botón \(alertaction.title!)")
        }
        ac.addAction(action)
        self.present(ac, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("se cargó en memoria")
        // forma1.- establecer la propiedad frame de los objetos
        // let newview = UIView(frame: self.view.bounds.insetBy(dx: 25, dy: 50))
        // forma2.- crear el objeto
        newview.backgroundColor = .blue
        self.view.addSubview(newview)
    }



    
    
    /*
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print ("otra vez layout")
        // este método se manda llamar cada vez que se cambia la geometría de la vista
        // según las orientaciones soportadas
        // y asignarle constraints
        newview.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            newview.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 25).isActive = true
            newview.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:(self.view.bounds.width / 2) * -1).isActive = true
            newview.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
            // newview.heightAnchor.constraint(equalToConstant:self.view.bounds.height).isActive = true
        }
        else {
            newview.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 25).isActive = true
            newview.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: -25).isActive = true
            newview.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
            newview.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant: -50).isActive = true
        }
        /*
        let constraint1 = NSLayoutConstraint(item: newview, attribute: NSLayoutConstraint.Attribute.left, relatedBy:.equal, toItem:self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier:1, constant:25)
        constraint1.isActive=true
        let constraint2 = NSLayoutConstraint(item:self.view, attribute: NSLayoutConstraint.Attribute.right, relatedBy:.equal, toItem:newview, attribute: NSLayoutConstraint.Attribute.right, multiplier:1, constant:25)
        constraint2.isActive=true
        let constraint3 = NSLayoutConstraint(item: newview, attribute: NSLayoutConstraint.Attribute.top, relatedBy:.equal, toItem:self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier:1, constant:50)
        constraint3.isActive=true
        let constraint4 = NSLayoutConstraint(item:self.view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy:.equal, toItem:newview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier:1, constant:50)
        constraint4.isActive=true
        view.addConstraints([constraint1, constraint2, constraint3, constraint4])
        NSLayoutConstraint.activate([constraint1, constraint2, constraint3, constraint4])
         let leftConstraint = NSLayoutConstraint(item: newview, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 25)
           leftConstraint.isActive = true
           //let rightConstraint = NSLayoutConstraint(item: self.view!, attribute: .right, relatedBy: .equal, toItem:newview, attribute: .right, multiplier: 1.0, constant: 25)
           //rightConstraint.isActive = true
        let wConstraint = NSLayoutConstraint(item: newview, attribute: .width, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 300)
        wConstraint.isActive = true
        let hConstraint = NSLayoutConstraint(item: newview, attribute: .height, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 200)
        hConstraint.isActive = true
        let topConstraint = NSLayoutConstraint(item: newview, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 50)
           topConstraint.isActive = true
           //let bottomConstraint = NSLayoutConstraint(item:self.view!, attribute: .bottom, relatedBy: .equal, toItem:newview, attribute: .bottom, multiplier: 1.0, constant: 50)
           //bottomConstraint.isActive = true
           
           
           view.addConstraints([leftConstraint, topConstraint, wConstraint, hConstraint])
                                // rightConstraint, , bottomConstraint])*/
         }
*/
}

