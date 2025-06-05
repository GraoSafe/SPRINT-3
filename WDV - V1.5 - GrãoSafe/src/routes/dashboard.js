var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.get("/temperaturaAtual", function (req, res){
    dashboardController.temperaturaAtual(req, res);
})
router.get("/ultimasDezTemperaturas", function (req, res){
    dashboardController.ultimasDezTemperaturas(req, res);
})
router.post("/alerta", function(req,res){
    dashboardController.alerta(req,res);
})
router.get("/alertasLista", function(req,res){
    dashboardController.alertasLista(req,res);
})

module.exports = router;