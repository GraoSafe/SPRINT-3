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
function ultimasDezTemperaturas(req,res){
    var fkSensor = req.body.fkSensorServer
    dashboardModel.ultimasDezTemperaturas(fkSensor)
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
function alertasLista(req,res){
    dashboardModel.alertasLista()
            .then(resultado => {
                res.status(200).json(resultado)
                console.log('ALERTAS ENCONTRADOS')
                    }
                ).catch(
                    function (erro) {
                        console.log(erro);
                        console.log("\nHouve um erro ao listar alertas! Erro: ", erro.sqlMessage);
                        res.status(500).json(erro.sqlMessage);
                    }
                );
}
function alertaUltimo(req,res){
    dashboardModel.alertaUltimo()
            .then(resultado => {
                res.status(200).json(resultado)
                console.log('ALERTA ENCONTRADO')
                    }
                ).catch(
                    function (erro) {
                        console.log(erro);
                        console.log("\nHouve um erro ao listar alertas! Erro: ", erro.sqlMessage);
                        res.status(500).json(erro.sqlMessage);
                    }
                );
}
function alerta(req,res){
    var tempAlerta = req.body.tempAlertaServer
    dashboardModel.alerta(tempAlerta)
        .then(resultado => {
            res.status(200).json(resultado)
        }).catch( function (erro) {
            console.log(erro)
            console.log("\nHouve um erro ao listar temperatura! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        })
}

module.exports = {
   temperaturaAtual,
   ultimasDezTemperaturas,
   alerta,
   alertasLista,
   alertaUltimo
}