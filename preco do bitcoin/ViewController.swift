//
//  ViewController.swift
//  preco do bitcoin
//
//  Created by Andre Linces on 19/09/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var precoBitcoin: UILabel!
    
    //Necessário criar 2 referências para o botão, primeira para mudar o texto atualizando para atualizar.
    @IBOutlet weak var botaoAtualizar: UIButton!
    //Segunda referência, action para atualizar o preço do bitcoin.
    
    @IBAction func atualizarPreco(_ sender: Any) {
        self.recuperarPrecoBitcoin()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recuperarPrecoBitcoin()
        
    }
    
    func formarPreco ( preco: NSNumber ) -> String {
        //Instanciando a objeto nf com a classe mumberFormatter
        let nf = NumberFormatter ()
        //formatando objeto para o formato decimal.
        nf.numberStyle = .decimal
        //Convertendo o objeto para o padrão do Brasil.
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            
            return precoFinal
            
        }
        return "0,00"
    }

    func recuperarPrecoBitcoin(){
        
        //Objeto criado para receber a Url recuperada do site api do blockchain
        if let url = URL(string: "https://www.blockchain.com/pt/ticker"){
            //objeto criado para receber a URL e recuperar as informações da API.
            let tarefa = URLSession.shared.dataTask(with: url) { dados, requisicao, erro in
            
                if erro == nil {
                    //print para testar se conseguiu recuperar a url
                    //print("Sucesso ao fazer a consulta do preço!")
                    
                    if let dadosRetorno = dados {
                        
                        do {
                            
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any ] {
                            //print(objetoJson)
                                
                                if let brl = objetoJson ["BRL"] as? [ String: Any ] {
                                        if let preco = brl ["buy"] as? Double {
                                        print(preco)
                                        }
                                }
                           
                            }
                        } catch  {
                            print("Erro ao formatar o retorno")
                        
                        }
                        
                    }
                    
                }else{
                    
                    print("Falha ao fazer a consulta do preço!")
                }
                
                
            }
            //Método resume que exibe as informações recuperadas.
            tarefa.resume()
            
        }/* Fim do IF url */
        
    }

}


