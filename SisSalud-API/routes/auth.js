const express = require('express');

const mysql = require('mysql');

const crypto = require('crypto');

const nJWT = require('../node_modules/njwt');

const router = express.Router();

const sql = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root3264',
    database: 'VolMex'
});

sql.connect();

router.post('/registrarVoluntario', (req, res, next) => {

    var voluntario = {
        Nombres: req.body.nombres,
        Apellidos: req.body.apellidos,
        Correo: req.body.correo,
        Nivel: req.body.nivel,
        Usuario: req.body.usuario,
        Contrasena: req.body.contrasena,
        ContrasenaHash: null,
        ContrasenaSalt: null,
        Tipo: req.body.tipo
    }

    var hashing = setSaltHash(voluntario.Contrasena);

    voluntario.ContrasenaHash = hashing.contrasenaHash;
    voluntario.ContrasenaSalt = hashing.salt;

    console.log(voluntario);

    var query =  sql.query('INSERT INTO Voluntarios VALUES (?,?,?,?,?,?,?,?)',[voluntario.Nombres,voluntario.Apellidos,voluntario.Correo,voluntario.Nivel,voluntario.Usuario,voluntario.ContrasenaHash,voluntario.ContrasenaSalt,voluntario.Tipo],function (error,result) {
        res.send(voluntario);
    });
});

router.post('/loginVoluntario', (req,res,next) => {

    var voluntario = {
        Usuario: req.body.usuario,
        Contrasena: req.body.contrasena,
        ContrasenaHash: null,
        ContrasenaSalt: null
    };

    var hashing = setSaltHash(voluntario.Contrasena);
    voluntario.ContrasenaHash = hashing.contrasenaHash;
    voluntario.ContrasenaSalt = hashing.salt;

    var query = sql.query('SELECT * FROM Voluntarios WHERE id  = ?', voluntario.Usuario, function(error,result) {
        if(voluntario.ContrasenaHash == result[0].ContrasenaHash && voluntario.ContrasenaSalt == result[0].ContrasenaSalt){

            res.json({
                token: generarJWT(voluntario.Usuario,result[0].Nombres,result[0].Apellidos,result[0].Id)
            });
        }
        else{
            res.send('datos incorrectos');
        }
    })
});

/**
 * Hacer un hash al password con sha512
 * @function
 * @param {string} password - Password del usuario
 * @param {string} salt - Data que sera validado
 */
var sha512 = function (password, salt) {
    var hash = crypto.createHmac('sha512', salt);
    hash.update(password);
    var value = hash.digest('hex');
    return {
        salt: salt,
        passwordHash: value
    };
};

/**
 * Retorna un objeto con el hash y el salt del password
 * @param {string} password - password del usuario
 */
function setSaltHash(password) {
    var salt = 'string super random generada de manera automatica que se supone se usa para encriptar'; /* retorna una string random de 16 caracteres  */
    var passwordData = sha512(password, salt);
    return passwordData;
}

/**
 * Generar token JWT
 * @param {string} Usuario - Usuario del usuario
 * @param {string} Nombres - Nombres del usuario
 * @param {string} Apellidos - Apellidos del usuario
 */
function generarJWT(Usuario,Nombres,Apellidos,Id) {

    const key = 'key super secreta que nadie nunca vera a menos que entre a github lol'

    var claims = {
        Usuario: Usuario,
        Nombre: Nombres + ' ' + Apellidos,
        Id: Id
    };

    var jwt = nJWT.create(claims,key);

    return jwt.compact();
}

module.exports = router;