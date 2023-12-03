const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const app = express();
const port = 3000;

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'jensen2023',
});

connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL database:', err);
  } else {
    console.log('Connected to MySQL database');
  }
});

app.use(bodyParser.json());

// Funktion för att hasha lösenord med bcrypt
async function hashPassword(password) {
  const saltRounds = 10;
  return await bcrypt.hash(password, saltRounds);
}

// Hämta alla användare
app.get('/users', (req, res) => {
  connection.query('SELECT * FROM users', (err, results) => {
    if (err) {
      console.error('Error fetching users:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.json(results);
    }
  });
});

// Hämta en specifik användare med id eller användarnamn
app.get('/users/:identifier', (req, res) => {
  const identifier = req.params.identifier;
  const query = 'SELECT * FROM users WHERE id = ? OR username = ?';

  connection.query(query, [identifier, identifier], (err, results) => {
    if (err) {
      console.error('Error fetching user:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      if (results.length === 0) {
        res.status(404).json({ error: 'User not found' });
      } else {
        res.json(results[0]);
      }
    }
  });
});

// Skapa en ny användare med hashat lösenord
app.post('/users', async (req, res) => {
  const { username, password, name, email } = req.body;
  try {
    const hashedPassword = await hashPassword(password);
    const newUser = { username, password: hashedPassword, name, email };
    console.log('Received request to create user:', newUser);

    connection.query('INSERT INTO users SET ?', newUser, (err, results) => {
      if (err) {
        console.error('Error creating user:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        newUser.id = results.insertId;
        delete newUser.password; // Undvik att skicka lösenordet i responsen
        res.status(201).json(newUser);
      }
    });
  } catch (error) {
    console.error('Error hashing password:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Uppdatera en specifik användare med id
app.put('/users/:id', async (req, res) => {
  const resourceId = req.params.id;
  const updatedUser = req.body;

  // Validera indata
  if (!updatedUser.username || !updatedUser.password || !updatedUser.name || !updatedUser.email) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    // Hasha lösenordet innan uppdatering
    updatedUser.password = await hashPassword(updatedUser.password);

    connection.query(
      'UPDATE users SET username = ?, password = ?, name = ?, email = ? WHERE id = ?',
      [updatedUser.username, updatedUser.password, updatedUser.name, updatedUser.email, resourceId],
      (err, results) => {
        if (err) {
          console.error('Error updating user:', err);
          res.status(500).json({ error: 'Internal Server Error' });
        } else if (results.affectedRows === 0) {
          res.status(404).json({ error: 'Resource not found' });
        } else {
          res.status(200).json(updatedUser);
        }
      }
    );
  } catch (error) {
    console.error('Error hashing password:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Logga in och returnera användarobjektet utan lösenordsfältet
app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  connection.query('SELECT * FROM users WHERE username = ?', [username], async (err, results) => {
    if (err) {
      console.error('Error fetching user:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      if (results.length === 0) {
        res.status(401).json({ error: 'Invalid credentials' });
      } else {
        const user = results[0];
        const passwordMatch = await bcrypt.compare(password, user.password);

        if (passwordMatch) {
          delete user.password; // Undvik att skicka lösenordet i responsen
          res.json(user);
        } else {
          res.status(401).json({ error: 'Invalid credentials' });
        }
      }
    }
  });
});

// Skapa en DELETE-route för att ta bort en användare
app.delete('/users/:id', (req, res) => {
  const userId = req.params.id;

  connection.query('DELETE FROM users WHERE id = ?', [userId], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
    } else if (results.affectedRows === 0) {
      res.status(404).json({ error: 'User not found' });
    } else {
      res.status(204).send(); // 204 No Content - Användaren har tagits bort
    }
  });
});

// Middleware för att hantera 404-fel
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Middleware för att hantera fel
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({ error: 'Internal Server Error' });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
