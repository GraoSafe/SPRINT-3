var dashboardModel = require("../models/dashboardModel");

function temperaturaAtual(req,res){
    var fkSensor = req.body.fkSensorServer
    dashboardModel.temperaturaAtual(fkSensor)
            .then(resultado => {
                res.status(200).json(resultado)
                    }
                ).catch(
                    function (erro) {
                        console.log(erro);
                        console.log("\nHouve um erro ao listar temperatura! Erro: ", erro.sqlMessage);
                        res.status(500).json(erro.sqlMessage);
                    }
                );
}

module.exports = {
   temperaturaAtual
}