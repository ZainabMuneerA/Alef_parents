/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey);

const calculateOrderAmount = (items) => {
    const prices = [];

    items.forEach(item => {
        if (item.price) {
            prices.push(item.price * 10);
        } else {
            console.error(`Item with no price`);
        }
    });

    const orderAmount = prices.reduce((a, b) => a + b, 0);
    // Ensure the amount is evenly divisible by 10 and convert to cents
    return Math.round(orderAmount * 100 / 10) * 10;
};


const generateResponse = function (intent) {
    switch (intent.status) {
        case 'requires_action':
            return {
                clientSecret: intent.client_secret,
                requiresAction: true,
                status: intent.status,
                id: intent.id,
                amount: intent.amount_received,
                date: intent.created,
            };
        case 'requires_payment_method':
            return {
                'error': "Your card was denied, please provide new payment method",
            };
        case 'succeeded':
            console.log('Payment success');
            return {
                clientSecret: intent.client_secret,
                id: intent.id,
                amount: intent.amount_received,
                status: intent.status,
                date: intent.created,
            };
    }
    return { error: 'Failed' };
};

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, items, currency, useStripeSDK } = req.body;

    const orderAmount = calculateOrderAmount(items);

    try {
        if (paymentMethodId) {
            // Create new payment
            const param = {
                amount: orderAmount,
                confirm: true,
                confirmation_method: 'manual',
                currency: currency,
                payment_method: paymentMethodId,
                payment_method_types: ['card'],
                use_stripe_sdk: useStripeSDK,
                return_url: 'https://example.com/placeholder',
            };

            const intent = await stripe.paymentIntents.create(param);
            console.log(`Intent: ${JSON.stringify(intent)}`);
            // return res.send(intent)
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);
    } catch (e) {
        console.error(`Error: ${e.message}`);
        return res.status(500).send({ error: e.message });
    }
});

exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body;

    try {
        if (paymentIntentId) {
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);
            console.log(`Intent: ${JSON.stringify(intent)}`);

            return res.send(generateResponse(intent));
        }
        console.log('400 in here');
        return res.sendStatus(400);
    } catch (e) {
        console.error(`Error: ${e.message}`);
        return res.status(500).send({ error: e.message });
    }
});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
