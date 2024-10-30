<?php
    header('Access-Control-Allow-Origin:*');

    include "pessoa.php";
    include "pessoaDAO.php";
    
    $cpf = filter_input(INPUT_GET ,'cpf');
    $nome = filter_input(INPUT_GET ,'nome');
    $profissao = filter_input(INPUT_GET ,'profissao');
    $telefone = filter_input(INPUT_GET ,'telefone');
    $email = filter_input(INPUT_GET ,'email');
    $cad = filter_input(INPUT_GET ,'cad');

    $pessoa = new Pessoa();
    $pessoaDAO = new PessoaDAO();

    $pessoa->setCpf($cpf);
    $pessoa->setNome($nome);
    $pessoa->setProfissao($profissao);
    $pessoa->setTelefone($telefone);
    $pessoa->setEmail($email);

    if($cad=="Cadastrar"){
        echo $pessoaDAO->cadastrar($pessoa);
    }else if($cad=="Deletar"){
        echo $pessoaDAO->deletar($pessoa);
    }else if($cad=="Atualizar"){
        echo $pessoaDAO->atualizar($pessoa);
    }else if($cad=="Consultar"){
        echo json_encode($pessoaDAO->consultar());
        
    }