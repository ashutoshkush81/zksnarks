const tester = require("circom").tester;
const crypto = require('crypto');

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
        const p = Math.floor(i / 8);
        b[p] = b[p] | (Number(a[i]) << (7 - (i % 8)));
    }
    return b;
}
const test = async () => {
    const cir = await tester('./sha256.circom');
    const testStr = "aqaqrbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq&q9231w";
    const b = Buffer.from(testStr, "utf8");
    console.log({b});
    const hash = crypto.createHash("sha256")
        .update(b)
        .digest("hex");
    console.log({hash}, {b});


    const arrIn = buffer2bitArray(b);
    console.log({arrIn,len: arrIn.length});
    const witness = await cir.calculateWitness({ "in": arrIn }, true);
    console.log({witness,len: witness.length});

    const arrOut = witness.slice(1, 257);
    console.log({arrOut, type:arrOut.type});
    const hash2 = bitArray2buffer(arrOut).toString("hex");
    console.log({hash2});
    return ({hash,hash2})
}

test().then(output=>{
    if(output.hash===output.hash2){
        console.log('Verified Sucessfully');
    } else{
        console.log("Not verified");
    }
});