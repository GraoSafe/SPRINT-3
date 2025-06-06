var database = require("../database/config")

function temperaturaAtual(){
    var instrucao = `
    select * from medida where fkSensor = 1  ORDER BY dtHora DESC LIMIT 10;
    `
    console.log('EXECUTANDO:',instrucao)
    return database.executar(instrucao)
}
function ultimasDezTemperaturas(){
    var instrucao = `
    select temperatura from medida where fkSensor = 1 ORDER BY dtHora DESC LIMIT 10;
    `
    console.log('EXECUTANDO:',instrucao)
    return database.executar(instrucao)
    
}
function alerta(tempAlerta,fkSensor){
    var instrucao = `
    INSERT INTO alerta (tempAlerta,fkSensor) VALUES (${tempAlerta}, 1 )
    `
    console.log('EXECUTANDO:',instrucao)
    return database.executar(instrucao)
}
function alertasLista(){
    var instrucao = `
    SELECT * FROM alerta WHERE fkSensor = 1
    `
    console.log('EXECUTANDO:',instrucao)
    return database.executar(instrucao)
}
function alertaUltimo(){
    var instrucao = `
    SELECT * FROM alerta WHERE fkSensor = 1 LIMIT 1;
    `
    console.log('EXECUTANDO:',instrucao)
    return database.executar(instrucao)
}

module.exports = {
    temperaturaAtual,
    ultimasDezTemperaturas,
    alerta,
    alertasLista,
    alertaUltimo
};