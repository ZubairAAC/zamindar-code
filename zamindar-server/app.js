require('dotenv').config();
const express = require('express');
const app = express();
const { MongoClient } = require('mongodb');

app.listen(3000, () => {
    console.log('server is live now');
});

async function main() {
    const url = "mongodb+srv://root:rooted@zamindarcluster.smfdd.mongodb.net/test";
    const client = new MongoClient(url);
    try {
        await client.connect();
        console.log('Connected correctly to server');
        // await createListing(client, {
        //     name: 'The Grand Budapest Hotel',
        //     summary: 'The Grand Budapest Hotel is a legendary European hotel located in the city center of New York, on the shores of the Hudson River.',
        //     bedrooms: 4,
        //     bathrooms: 4,
        // })

        await listDatabases(client);

    } catch (error) {
        console.log('could not connected');
        console.log(error);
    } finally {
        client.close();
    }
}
async function listDatabases(client) {
    databasesList = await client.db().admin().listDatabases();

    console.log("Databases:");
    databasesList.databases.forEach(db => console.log(` - ${db.name}`));
};
async function createListing(client, newListing) {
    const result = await client.db('sample_airbnb').collection('listingsAndReviews').insertOne(newListing);
    // console.log('new listing created with this id : ${result.insertId}');
    console.log(result.insertedId);
}

main().catch(console.error);

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);

// Login Endpoint


