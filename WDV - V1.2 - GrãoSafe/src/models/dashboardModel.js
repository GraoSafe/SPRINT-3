var database = require("../database/config")

function temperaturaAtual(fkSensor){
    var instrucao = `
    select * from medida where fkSensor = 1  ORDER BY dtHora ASC LIMIT 11;
    `
    return database.executar(instrucao)
}


module.exports = {
    temperaturaAtual
};