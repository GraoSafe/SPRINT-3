var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.get("/temperaturaAtual", function (req, res) {
    dashboardController.temperaturaAtual(req, res);
})

module.exports = router;