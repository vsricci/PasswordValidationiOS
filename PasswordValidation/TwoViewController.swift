//
//  TwoViewController.swift
//  PasswordValidation
//
//  Created by Joel Sene on 04/10/17.
//  Copyright © 2017 Vinicius Santos Ricci. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var imagem : UIImageView!
    @IBOutlet weak var imagemSenha : UIButton!
    @IBOutlet weak var imagemSenha2 : UIButton!
    @IBOutlet weak var imagemSenha3 : UIButton!
    @IBOutlet weak var forcaSenhaTexto : UILabel!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var confirmarSenhaLabel : UILabel!
    @IBOutlet weak var senhaAtual: FloatLabelTextField!
    @IBOutlet weak var novaSenha : FloatLabelTextField!
    @IBOutlet weak var confirmarSenha: FloatLabelTextField!
    @IBOutlet weak var proguessForcaSenha : UIProgressView!
    
 

    
    var statusVerSenha : Bool = false
    var statusVerSenha2 : Bool = false
    var statusVerSenha3 : Bool = false
    var forca = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        nomeUsuario.text = "Teste"
        forcaSenhaTexto.isHidden = true
        proguessForcaSenha.isHidden = true
        self.navigationItem.title = "Alterar Senha"
        
        
        novaSenha.delegate = self
        
        forcaSenhaTexto.textColor = (UIColor.green)
        confirmarSenhaLabel.textColor = (UIColor.green)
        
        senhaAtual.titleActiveTextColour = (UIColor.green)
        novaSenha.titleActiveTextColour = (UIColor.green)
        confirmarSenha.titleActiveTextColour = (UIColor.green)
        
        trocaCorBorda(senhaAtual)
        trocaCorBorda(confirmarSenha)
        trocaCorBorda(novaSenha)
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 25
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        
        
        if textField == novaSenha {
            
            
            
             verificaForcaSenha(senha: textField.text!)
        }
        
        
        
       
            return newString.length <= maxLength
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == novaSenha {
            
            if textField.text?.characters.count == 0 {
                
                proguessForcaSenha.progress = 0
            }
        }
        
    }
    
    
    //Buttons
    
    @IBAction func verSenha1(sender : UIButton) {
        
        statusVerSenha = !statusVerSenha
        
        if statusVerSenha == true {
            
            imagemSenha.setImage(UIImage(named: "eye"), for: .normal)
            senhaAtual.isSecureTextEntry = false
            
            
        }else {
            imagemSenha.setImage(UIImage(named: "eye-off"), for: .normal)
            senhaAtual.isSecureTextEntry = true
        }
        
        
        
    }
    
    @IBAction func verSenha2(sender : UIButton) {
        
        
        statusVerSenha2 = !statusVerSenha2
        
        if statusVerSenha2 {
            
            imagemSenha2.setImage(UIImage(named: "eye"), for: .normal)
            novaSenha.isSecureTextEntry = false
            
            
        }else {
            imagemSenha2.setImage(UIImage(named: "eye-off"), for: .normal)
            novaSenha.isSecureTextEntry = true
        }
        
        
        
    }
    @IBAction func verSenha3(sender : UIButton) {
        
        statusVerSenha3 = !statusVerSenha3
        if statusVerSenha3 {
            
            imagemSenha3.setImage(UIImage(named: "eye"), for: .normal)
            confirmarSenha.isSecureTextEntry = false
            
        }else {
            imagemSenha3.setImage(UIImage(named: "eye-off"), for: .normal)
            confirmarSenha.isSecureTextEntry = true
        }
        
        
        
    }
    
    
    @IBAction func zeraEDesapareceProguessForcaSenha(sender: UITextField) {
        
        
        
        if sender.text?.characters.count == 0 {
            
            proguessForcaSenha.progress = 0
            forcaSenhaTexto.isHidden = true
            proguessForcaSenha.isHidden = true
            confirmarSenhaLabel.isHidden = true
            forca = 0
        }
        
        if  (sender.text?.characters.count)! > 0 && (sender.text?.characters.count)! < 6 {
            
            forcaSenhaTexto.isHidden = false
            forcaSenhaTexto.text = "Senha Fraca"
            proguessForcaSenha.isHidden = false
            
            
            
        }
        
        if (sender.text?.characters.count)! >= 6 {
            forcaSenhaTexto.isHidden = false
            forcaSenhaTexto.text = "Nova Senha"
            //verificaForcaSenha(senha: sender.text!)
            proguessForcaSenha.isHidden = false
            
        }
        
        
    }
    
    @IBAction func confirmarSenha(sender: UITextField) {
        
        confirmarSenhaLabel.isHidden = false
        
        if sender.text?.characters.count == 0 {
            
            confirmarSenhaLabel.isHidden = true
        }
        
        if sender.text != novaSenha.text {
            
            confirmarSenhaLabel.text = "Não está igual"
            
        }
        else {
            confirmarSenhaLabel.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verificaForcaSenha(senha: String) -> String {
        
        
        
        // let teste =  "SELF MATCHES %@ ^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        
        if senha.characters.count < 6 || verificaPalavrasIncorretas(senha: senha) == 1{
            
            forca = 1
        }
        
        if verificaPalavrasIncorretas(senha: senha) != 1 && (senha.characters.count) == 6 {
            
            forca += 10
            
        }
        else {
            forca = 0
        }
        
        if verificaPalavrasIncorretas(senha: senha) != 1 && (senha.characters.count) > 6 && (senha.characters.count) <= 9 {
            
            
            forca += 25
        }
        else {
            forca = 0
        }
        
        
        if verificaPalavrasIncorretas(senha: senha) != 1 && (senha.characters.count) >  10 {
            forca += 30
        }
        else {
            forca = 0
        }
        
        
        
        
        
        if validadores(senha: senha).0 == true {
            
            forca += validadores(senha: senha).1
        }
        else {
            forca = 0
        }
        
        
        
        
        verificaForca(forca: forca, forcaProguess: proguessForcaSenha)
        
        
        print( " forca é : \(forca)")
        return senha
    }
    
    
    func validadores(senha: String) -> (Bool, Int) {
        
        var forca = 0
        var sucesso = false
        
        let validacao1 : NSPredicate!
        let validacao2 : NSPredicate!
        let validacao3 : NSPredicate!
        let validacao4 : NSPredicate!
        var validacao5 : NSPredicate!
        
        
        
        validacao1 = NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-z]).{5,}")
        
        if validacao1.evaluate(with: senha) == true {
            
            forca += 10
            sucesso = true
            
            
        }
        
        
        validacao2 = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z]).{5,}")
        
        if validacao2.evaluate(with: senha) == true {
            
            forca += 20
            sucesso = true
            
            
        }
        else {
            forca = 0
        }
        
        validacao3 = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9]).{5,}")
        
        if validacao3.evaluate(with: senha) == true {
            
            forca += 20
            sucesso = true
            
            
        }
        else {
            forca = 0
        }
        
        
        
        
        validacao4 = NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-zA-Z0-9_]).{7,}")
        
        if validacao4.evaluate(with: senha) == true {
            
            forca += 25
            sucesso = true
            
            
        }
        else {
            forca = 0
        }
        // validacao5 = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        
        //sucesso = validacao5.evaluate(with: senha)
        
        return (sucesso, forca)
    }
    
   
    
    func verificaForca( forca : Int, forcaProguess : UIProgressView) {
        
        if forca == 0  {
            
            forcaProguess.progress = 0.25
            forcaProguess.progressTintColor = UIColor.red
        }
            
        else if forca >= 1 && forca < 30 {
            
            forcaProguess.progress = 0.25
            forcaProguess.progressTintColor = UIColor.red
        }
        else if forca >= 30 && forca < 60 {
            
            forcaProguess.progress = 0.50
            forcaProguess.progressTintColor = UIColor.yellow
        }
        else if forca >= 60 && forca < 85 {
            
            forcaProguess.progress = 0.75
            forcaProguess.progressTintColor = UIColor.blue
        }
        else {
            
            forcaProguess.progress = 1
            forcaProguess.progressTintColor = UIColor.green
        }
        
        
    }
    
    func verificaPalavrasIncorretas(senha :String) -> Int {
        
        var forca = 0
        
        var arrayPalavrasIncorretas = ["password", "123456", "12345678", "qwerty", "abc123", "monkey", "1234567", "letmein", "trustno1", "dragon", "baseball", "111111", "iloveyou", "master", "sunshine", "ashley", "bailey", "passw0rd", "shadow", "123123", "654321", "superman", "qazwsx", "michael", "football"]
        
        for palavras in arrayPalavrasIncorretas {
            
            if senha == palavras {
                
                forca = 1
            }
        }
        
        return forca
    }
    

    
    func trocaCorBorda(_ textField: UITextField){
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.green.cgColor
        
        //let screenWidth = UIScreen.main.bounds.width
        //border.frame.size.width = screenWidth
        
        border.frame = CGRect(x: 0, y: textField.frame.size.height - 2.0, width:  textField.bounds.width * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        
        textField.layer.masksToBounds = true
        
        
        /*textField.layer.borderColor = hexStringToUIColor(hex: "F44336").cgColor
         textField.layer.borderWidth = 2.0
         textField.borderStyle = .none*/
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
