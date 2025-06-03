var database = require("../database/config")

function temperaturaAtual(fkSensor){
    var instrucao = `
    select * from medida where fkSensor = 1  ORDER BY dtHora DESC LIMIT 1;
    `
    console.log('EXECUTANDO:',instrucao)
    return database.executar(instrucao)
}


module.exports = {
    temperaturaAtual
};