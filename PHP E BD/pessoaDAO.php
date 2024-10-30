<?php
    //header('Access-Control-Allow-Origin:*');
    
    include "conexao.php";
    class PessoaDAO{
        public function cadastrar(Pessoa $p){
            //criando a query de cadastro
            $sql_pessoa = "insert into pessoa (cpf_pessoa, nome_pessoa, profissao_pessoa) 
            values (?, ?, ?)";
            $sql_contato = "insert into contato(telefone_contato, email_contato, pessoa_contato) values
            (?, ?, ?)";

            //instanciar o objeto de conexão
            $bd = new Conexao();
            $con = $bd->getConexao();

            $valor_pessoa = $con->prepare($sql_pessoa);
            $valor_pessoa->bindValue(1, $p->getCpf());
            $valor_pessoa->bindValue(2, $p->getNome());
            $valor_pessoa->bindValue(3, $p->getProfissao());

            $valor_contato = $con->prepare($sql_contato);
            $valor_contato->bindValue(1, $p->getTelefone());
            $valor_contato->bindValue(2, $p->getEmail());
            $valor_contato->bindValue(3, $p->getCpf());        

            $resultado_pessoa = $valor_pessoa->execute();
            $resultado_contato = $valor_contato->execute();

            if($resultado_pessoa && $resultado_contato){
                return "cadastrado com sucesso";
            }else{
                return "erro ao cadastrar";
            }
        }

        public function deletar(Pessoa $p){
            //criando a query de cadastro
            $sql_pessoa = "delete from pessoa where cpf_pessoa=?";
            $sql_contato = "delete from contato where pessoa_contato = ?";

            //instanciar o objeto de conexão
            $bd = new Conexao();
            $con = $bd->getConexao();

            $valor_pessoa = $con->prepare($sql_pessoa);
            $valor_pessoa->bindValue(1, $p->getCpf());

            $valor_contato = $con->prepare($sql_contato);
            $valor_contato->bindValue(1, $p->getCpf());        
            
            $resultado_pessoa = $valor_pessoa->execute();
            $resultado_contato = $valor_contato->execute();

            if($resultado_pessoa && $resultado_contato){
                return "Apagado com sucesso";
            }else{
                return "erro ao apagar";
            }
        }

        public function atualizar(Pessoa $p){
            //criando a query de cadastro
            $sql_pessoa = "update pessoa set nome_pessoa=?, profissao_pessoa=? where cpf_pessoa =?";
            $sql_contato = "update contato set telefone_contato=?, email_contato=? where pessoa_contato=?";

            //instanciar o objeto de conexão
            $bd = new Conexao();
            $con = $bd->getConexao();

            $valor_pessoa = $con->prepare($sql_pessoa);
            $valor_pessoa->bindValue(1, $p->getNome());
            $valor_pessoa->bindValue(2, $p->getProfissao());
            $valor_pessoa->bindValue(3, $p->getCpf());

            $valor_contato = $con->prepare($sql_contato);
            $valor_contato->bindValue(1, $p->getTelefone());
            $valor_contato->bindValue(2, $p->getEmail());
            $valor_contato->bindValue(3, $p->getCpf());      
            
            $resultado_pessoa = $valor_pessoa->execute();
            $resultado_contato = $valor_contato->execute();

            if($resultado_pessoa && $resultado_contato){
                return "Atualizado com sucesso";
            }else{
                return "erro ao atualizar";
            }
        }


        public function consultar(){
            //criando a query de cadastro
            $sql = "select * from pessoa inner join contato on pessoa.cpf_pessoa=contato.pessoa_contato";
           
            //instanciar o objeto de conexão
            $bd = new Conexao();
            $con = $bd->getConexao();
            
            if(!$con){
                return "está com erro";
            }

            $valor = $con->prepare($sql);
            $valor->execute();
            
            if($valor->rowCount()>0){
                $resultado = $valor->fetchAll(\PDO::FETCH_ASSOC);
                return $resultado;
            }else{
                return "erro";
            }
        }
    }
?>