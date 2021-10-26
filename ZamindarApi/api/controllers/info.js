const express = require("express");
const router = express.Router();
const dbConfig = require('../../config/database.config')
const MongoClient = require('mongodb').MongoClient
const ObjectId = require('mongodb').ObjectID
const multer = require('multer');
const { GridFsStorage } = require('multer-gridfs-storage');
const mongoose = require('mongoose');
const Grid = require('gridfs-stream');
const crypto = require('crypto');
const path = require('path');



const conn = mongoose.createConnection(dbConfig.url);

// Init gfs
let gfs;

conn.once('open', () => {
    // Init stream
    gfs = Grid(conn.db, mongoose.mongo);
    gfs.collection('uploads');
});

// Create storage engine
const storage = new GridFsStorage({
    url: dbConfig.url,
    file: (req, file) => {
        return new Promise((resolve, reject) => {
            crypto.randomBytes(16, (err, buf) => {
                if (err) {
                    return reject(err);
                }
                const filename = buf.toString('hex') + path.extname(file.originalname);
                const fileInfo = {
                    filename: filename,
                    bucketName: 'uploads'
                };
                resolve(fileInfo);
            });
        });
    }
});
const upload = multer({ storage });

router.get('/', (req, res) => {
    // res.json(users);
    MongoClient.connect(dbConfig.url, { useNewUrlParser: true, useUnifiedTopology: true }, (err, client) => {
        if (err) return console.log(err)
        let db = client.db('ZamindarMobileApp')
        db.collection('Questions').find().toArray().then(function (docs) {
            client.close()
            res.send(docs)
        })
    })
});

//get user by id 
router.get('/:id', (req, res) => {
    const found = users.some(users => users.id === parseInt(req.params.id))

    if (found) {
        res.json(users.filter(users => users.id === parseInt(req.params.id)))
    } else {
        res.sendStatus(400)
    }
})
//post new user
router.post('/', upload.single('image'), (req, res) => {
    const newinfo = {
        title: req.body.title,
        description: req.body.description,

        image: req.file.filename,
    }

    // if (!newUser.name || !newUser.phone || !newUser.image) {
    //     return res.send("can't add");
    // }

    MongoClient.connect(dbConfig.url, { useNewUrlParser: true, useUnifiedTopology: true }, (err, client) => {
        if (err) return console.log(err)
        let db = client.db('ZamindarMobileApp')
        db.collection('Questions').insertOne(newinfo, function (err, r) {
            if (err) return console.log(err)
            client.close()
            res.send(r.ops)
        })
    });
    res.send({
        message: 'info added successfully',
        respone: 'Success',
        user_added: newinfo,
    })
    // users.push(newUser);

    // // res.send("new user has been added");
    // res.json(users);

})

//update user 
router.put('/:id', (req, res) => {
    const found = users.some(users => users.id === parseInt(req.params.id))

    if (found) {
        const updateUser = req.body;
        users.forEach(users => {
            if (users.id === parseInt(req.params.id)) {
                users.name = updateUser.name ? updateUser.name : users.name
                users.phone = updateUser.phone ? updateUser.phone : users.phone
                users.image = updateUser.image ? updateUser.image : users.image
                res.json({ msg: 'user has been updated', users })
            }
        })
    }

})

//delete user 
router.delete('/:id', (req, res) => {
    const found = users.some(users => users.id === parseInt(req.params.id))
    if (found) {
        users = users.filter((users) => users.id !== parseInt(req.params.id));
        res.json({
            msg: 'user has been deleted',
            users,
        });
    } else {
        res.sendStatus(400);
    }


})

router.delete = (req, res) => {
    let id = req.params.id
    MongoClient.connect(dbConfig.url, { useNewUrlParser: true, useUnifiedTopology: true }, (err, client) => {
        if (err) return console.log(err)
        let db = client.db('ZamindarMobileApp')
        let whereQuery = { _id: ObjectId(id) }
        db.collection('users').deleteOne(whereQuery, function (err, docs) {
            if (err) return console.log(err)
            client.close()
            res.send(docs)
        })
    })
}



module.exports = router;