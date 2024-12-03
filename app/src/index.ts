import express from "express";
import customersRouter from "./routes/customers";

const app = express();
const port = 3000;

app.use(customersRouter);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
