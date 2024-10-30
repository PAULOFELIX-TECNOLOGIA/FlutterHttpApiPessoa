create database cadastro_pessoa;
use cadastro_pessoa;
show databases;

create table pessoa(
 cpf_pessoa char(14) primary key,
 nome_pessoa varchar(100) not null,
 profissao_pessoa varchar(100)
);


select * from pessoa;
show tables;
desc pessoa;
describe contato;

create table contato(
  id_contato int primary key auto_increment,
  telefone_contato char(13) not null,
  email_contato varchar(100),
  pessoa_contato char(14),
  foreign key(pessoa_contato) references pessoa(cpf_pessoa)
);
insert into pessoa (cpf_pessoa, nome_pessoa, profissao_pessoa) 
values ('1234567890', 'João', 'porteiro');
insert into contato(telefone_contato, email_contato, pessoa_contato) values
('11987876565', 'joao@email.com', '1234567890');

select * from pessoa inner join contato on pessoa.cpf_pessoa=contato.pessoa_contato;