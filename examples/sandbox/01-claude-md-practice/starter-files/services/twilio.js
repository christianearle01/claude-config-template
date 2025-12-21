const twilio = require('twilio');

const client = twilio(process.env.TWILIO_SID, process.env.TWILIO_TOKEN);

async function sendSMS(to, message) {
  // Send SMS for urgent tasks
  await client.messages.create({
    body: message,
    to: to,
    from: process.env.TWILIO_NUMBER
  });
}

module.exports = { sendSMS };
