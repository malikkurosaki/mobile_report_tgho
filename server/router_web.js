
const express = require('express');
const Web = express.Router();

const ApiList =
`
<i>
tgl1     tanggal first                              <br>
tgl2     tanggal end                                <br>
dep      departement                                <br>
out      outlet                                     <br>
/api/[param]                                        <br>

--------------------------------------------------- <br>
/display/dash?tgl1=&tgl2=&out=&wdep=                <br>
/display/salesPerformance?tgl1=&tgl2=&out=&wdep=    <br>
/display/salesAvarage?tgl1=&tgl2=&out=&wdep=        <br>
/display/bestDay?tgl1=&tgl2=&out=&wdep=             <br>
/display/bestProduct?tgl1=&tgl2=&out=&wdep=         <br>
/master/dep                                         <br>
/master/out                                         <br>
--------------------------------------------------- <br>
</i>
`


const idx = 
`
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="./main.js" defer></script>
    </head>
    <body>
        <h1>Mobile Report Server</h1>
        <hr>
        <span>V1.0.0.1</span>
        <div id="main"></div>
        <h3>API</h3>
        <code>
            ${ApiList}
        </code>
    </body>
    </html>
`

module.exports = Web;