const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const path = require("path");
require("express-async-errors");
const app = express();

const formKtpRouter = require("./controllers/form_ktp");
const fotoKtpRouter = require("./controllers/foto_ktp");

const { PORT } = require("./utils/config");
const { connectToDatabase } = require("./utils/db");

app.use(express.json());
app.use(bodyParser.json({ limit: "50mb" }));
app.use(cors());
app.use(express.static("build"));
app.use(express.static("assets"));
app.use("/api/formktp", formKtpRouter);
app.use("/api/fotoktp", fotoKtpRouter);

const main = async () => {
  await connectToDatabase();
  app.listen(PORT);
};

main();
