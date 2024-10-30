<form action="controle.php" method="GET">
    <p><input type="Text" name="cpf" placeholder="CPF"></p>
    <p><input type="Text" name="nome" placeholder="NOME"></p>
    <p><input type="Text" name="profissao" placeholder="PROFISSAO"></p>
    <p><input type="Text" name="telefone" placeholder="TELEFONE"></p>
    <p><input type="Text" name="email" placeholder="E-MAIL"></p>
    <p><input type="submit" name="cad" value="Cadastrar"></p>
    <p><input type="submit" name="cad" value="Deletar"></p>
    <p><input type="submit" name="cad" value="Atualizar"></p>
    <p><input type="submit" name="cad" value="Consultar"></p>
</form>

<button onclick="consultar()">Consulta</button>
<p id='resultado'></p>

<script>
    function consultar(){
        const xhttp = new XMLHttpRequest();
        xhttp.open("GET", "controle.php?cpf=1&nome=1&profissao=1"+
        "&telefone=1&email=1&cad=Consultar");
        xhttp.send();

        xhttp.onload = function(){
            document.getElementById("resultado").innerHTML = 
            this.responseText;
        }
    }
</script>


