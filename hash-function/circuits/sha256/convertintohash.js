const fs = require('fs');
function buffer2bitArray(b) {
    const res = [];
    for (let i = 0; i < b.length; i++) {
        for (let j = 0; j < 8; j++) {
            res.push((b[i] >> (7 - j) & 1));
        }
    }
    return res;
}

function bitArray2buffer(a) {
    const len = Math.floor((a.length - 1) / 8) + 1;
    const b = new Buffer.alloc(len);

    for (let i = 0; i < a.length; i++) {
        const p = Math.floor(+i / 8);
        b[p] = b[p] | (Number(a[i]) << (7 - (i % 8)));
    }
    return b;
}

const arrOut = JSON.parse(fs.readFileSync('./witness.json')).slice(1, 257);
const hash2 = bitArray2buffer(arrOut).toString("hex");
console.log({ hash2 });


