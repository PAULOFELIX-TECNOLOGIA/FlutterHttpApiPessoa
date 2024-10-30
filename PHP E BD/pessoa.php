<!--classe de entidade (Pessoa)-->
<?php
  class Pessoa{
    //variáveis globais
    private $cpf, $nome, $profissao, $telefone, $email;

    public function setCpf($cpf){
        $this->cpf = $cpf;
    }

    public function getCpf(){
        return $this->cpf;
    }

    public function setNome($nome){
        $this->nome = $nome;
    }

    public function getNome(){
        return $this->nome;
    }

    public function setProfissao($profissao){
        $this->profissao = $profissao;
    }

    public function getProfissao(){
        return $this->profissao;
    }

    public function setTelefone($telefone){
        $this->telefone = $telefone;
    }

    public function getTelefone(){
        return $this->telefone;
    }

    public function setEmail($email){
        $this->email = $email;
    }

    public function getEmail(){
        return $this->email;
    }
  }