require('dotenv').config();
const express = require("express");
const cors = require('cors');
const mongoose = require("mongoose");
const port = 3001;
const routes = require("./routes");
const fs = require('fs');
const password = process.env.MONGO_PASSWORD;
const host = process.env.MONGO_HOST;

// 🔐 Read and print the password
// const password = fs.readFileSync('/mnt/secrets-store/mongo_admin', 'utf8').trim();


// 🧠 Now construct the URI using the actual password
const uri = `mongodb://master:${password}@final-project-db-0-2025071213240880440000000c.cab2qcwmyvyz.us-east-1.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&retryWrites=false`;
// 🔁 Run the main app logic
main().catch((err) => console.log("❌ Connection failed:", err));

async function main() {
  await mongoose.connect(uri, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  });

  const app = express();
  app.use(cors());
  app.use(express.json());
  app.use("/api", routes);

  app.listen(port, () => {
    console.log(`🚀 Server is listening on port: ${port}`);
  });
}