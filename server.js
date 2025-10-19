import express from "express";
import mysql from "mysql2/promise";
import cors from "cors";

const app = express();
app.use(cors({ origin: "*" }));
app.use(express.json());

const db_host = "localhost";

app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ message: "invalid login" });
  }

  try {
    const conn = await mysql.createConnection({
      host: db_host,
      user: username,
      password: password,
      connectTimeout: 5000,
    });
    await conn.ping();
    await conn.end();
    return res.status(200).json({ message: "login successful" });
  } catch (err) {
    console.error("MySQL error:", err.message);
    return res.status(401).json({ message: "login failed" });
  }
});

app.post("/list-databases", async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ message: "missing credentials" });
  }

  try {
    const conn = await mysql.createConnection({
      host: db_host,
      user: username,
      password: password,
    });

    const [databases] = await conn.query("SHOW DATABASES;");

    let users = [];
    try {
      const [rows] = await conn.query("SELECT User FROM mysql.user;");
      users = rows;
    } catch (userErr) {
      console.warn("Skipping user list:", userErr.message);
      users = [{ User: "Access Denied", Host: "" }];
    }

    await conn.end();

    return res.status(200).json({ databases, users });
  } catch (err) {
    console.error("MySQL error:", err.message);
    return res.status(401).json({ message: "failed to list databases" });
  }
});
app.post("/create-database", async (req, res) => {
  const { username, password, dbNames } = req.body;
  if (!username || !password || !dbNames) {
    return res.status(400).json({ message: "missing parameters" });
  }

  try {
    const conn = await mysql.createConnection({
      host: db_host,
      user: username,
      password: password,
    });

    await conn.query(`CREATE DATABASE \`${dbNames}\`;`);
    await conn.end();

    return res.status(200).json({ message: "database created" });
  } catch (err) {
    console.error("MySQL error:", err.message);
    return res.status(500).json({ message: "failed to create database" });
  }
});
app.post("/create-user", async (req, res) => {
  const { username, password, newUser, newPass } = req.body;

  if (!username || !password || !newUser || !newPass) {
    return res.status(400).json({ message: "missing parameters" });
  }

  try {
    const conn = await mysql.createConnection({
      host: db_host,
      user: username,
      password: password,
    });

    await conn.query(
      `CREATE USER IF NOT EXISTS \`${newUser}\`@'localhost' IDENTIFIED BY ?;`,
      [newPass]
    );
    await conn.query(
      `GRANT ALL PRIVILEGES ON *.* TO \`${newUser}\`@'localhost' WITH GRANT OPTION;`
    );
    await conn.query("FLUSH PRIVILEGES;");

    await conn.end();

    return res
      .status(200)
      .json({ message: `User '${newUser}' created successfully.` });
  } catch (err) {
    console.error("MySQL error:", err.message);
    return res.status(500).json({ message: "failed to create user" });
  }
});
app.post("/create-table", async (req, res) => {
  const { username, password, dbName, tableName } = req.body;

  if (!username || !password || !dbName || !tableName) {
    return res.status(400).json({ message: "Missing parameters" });
  }

  try {
    const conn = await mysql.createConnection({
      host: db_host,
      user: username,
      password: password,
      database: dbName,
    });

    const createQuery = `
      CREATE TABLE IF NOT EXISTS \`${tableName}\` (
        id INT AUTO_INCREMENT PRIMARY KEY,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `;

    await conn.query(createQuery);
    await conn.end();

    res.status(201).json({
      message: `Table '${tableName}' created successfully in database '${dbName}'.`,
    });
  } catch (error) {
    console.error("Error creating table:", error.message);
    res.status(500).json({
      message: "Failed to create table",
      error: error.message,
    });
  }
});

app.listen(3000, () => console.log("running"));
