require('dotenv').config();
const express = require('express');
const app = express();
const { MongoClient } = require('mongodb');

app.listen(3000, () => {
    console.log('server is live now');
});

async function main() {
    const url = "mongodb+srv://zaac:12345@zamindarcluster.smfdd.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
    const client = new MongoClient(url);
    try {
        await client.connect(connectionString, { useNewUrlParser: true });
        console.log(db.admin().listDatabases)
        return client;
        // await listFDatabase(client);

    } catch (error) {
        console.log('could not connected');
        console.log(error);
    } finally {
        client.close();
    }
}
async function listFDatabase(client) {
    const dbList = await client.db().admin().listDatabases();
    console.log("DataBase are : ");
    dbList.databases.forEach(db => {
        console.log('this is => ${db.name}');
    })

}

main().catch(console.error);

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);

// Login Endpoint


