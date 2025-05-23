function Verify_Variables1() {
    var nome = input_nome.value;
    var email = input_email.value;
    var senha = input_senha.value;
    var telefone = input_telefone.value;

    if (nome == "" || email == "" || senha == "" || telefone == "") {
      Toastify({
      text: "Alert: Preencha todos os campos!",
      duration: 3000,
      style: {
      background: "linear-gradient(to right, #FF8C00, #FF4500)",
        },
      }).showToast();
    }
    else if (!email.includes('@') || !email.includes('.')) {
      emailCarac.innerHTML = `<span style="color: red;">* E-mail inválido. Deve conter "@" e ".". </span>`;
      Toastify({
      text: "Alert: Campos Inválidos! Deve conter @ e .",
      duration: 3000,
      style: {
      background: "linear-gradient(to right, #FF8C00, #FF4500)",
        },
      }).showToast();
    }
    else if (email != email.toLowerCase()) {
      emailCarac.innerHTML += `<span style="color: red;">* Apenas letras minúsculas. </span>`
    }
    else if (senha.length < 6 || senha.length > 12) {
      Toastify({
      text: "Alert: Campos Inválidos! Senha deve conter entre 6 e 12 caracteres",
      duration: 3000,
      style: {
      background: "linear-gradient(to right, #FF8C00, #FF4500)",
        },
      }).showToast();
    }
    else if (!senha.includes('!') && !senha.includes('@') && !senha.includes('#') && !senha.includes('_') && !senha.includes('-') && !senha.includes('.')) {
      senhaCarac.innerHTML = `<span style="color: red;">* Senha fraca. Senha deve conter caracteres especiais. ex: "!", "@", "#", "_", "-", "."</span>`;
    }
    else if (/[^0-9]/.test(telefone)) {
      Toastify({
      text: "Alert: Campos inválidos. Apenas números.",
      duration: 3000,
      style: {
      background: "linear-gradient(to right, #FF8C00, #FF4500)",
        },
      }).showToast();
    }
    else {
    nome_user = nome
    email_user = email
    senha_user = senha
    telefone_user = telefone
        
    cadastrar();
    }
  }
// Array para armazenar empresas cadastradas para validação de código de ativação 
  function cadastrar() {
    // aguardar();
    //Recupere o valor da nova input pelo nome do id
    // Agora vá para o método fetch logo abaixo
    var nomeVar = input_nome.value;
    var emailVar = input_email.value;
    var senhaVar = input_senha.value;
    var telefoneVar = input_telefone.value;

    // Verificando se há algum campo em branco
    if (
      nomeVar == "" ||
      emailVar == "" ||
      senhaVar == "" ||
      telefoneVar == ""
    ) {
      return false;
    } 

    // Enviando o valor da nova input
    fetch("/usuarios/cadastrar", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        // crie um atributo que recebe o valor recuperado aqui
        // Agora vá para o arquivo routes/usuario.js
        nomeServer: nomeVar,
        emailServer: emailVar,
        senhaServer: senhaVar,
        telefoneServer: telefoneVar
      }),
    })
      .then(function (resposta) {
        console.log("resposta: ", resposta);

        if (resposta.ok) {
          setTimeout(() => {
            window.location = "login.html";
          }, "2000");
        } else {
          throw "Houve um erro ao tentar realizar o cadastro!";
        }
      })
      .catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
      });

    return false;
  }


  




