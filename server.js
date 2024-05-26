const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// MySQL connection setup
const connection = mysql.createConnection({
    host: 'localhost',    // Update with your DB host
    user: 'root', // Update with your DB username
    password: '', // Update with your DB password
    database: 'exp_sys_db' // Database name
});

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Endpoint to fetch questions
app.get('/questions', (req, res) => {
    connection.query('SELECT * FROM tabel_pertanyaan', (err, results) => {
        if (err) {
            return res.status(500).send('Error retrieving questions');
        }
        res.json(results);
    });
});

// Endpoint to fetch symptoms
app.get('/symptoms', (req, res) => {
    connection.query('SELECT * FROM tabel_gejala', (err, results) => {
        if (err) {
            return res.status(500).send('Error retrieving questions');
        }
        res.json(results);
    });
});

// Endpoint to check answers
app.post('/diagnose', express.json(), (req, res) => {
    const userAnswers = req.body.answers;
    // Debug
    console.log(userAnswers);
    
    connection.query('SELECT r.kode_pertanyaan, p.nama_penyakit FROM tabel_rule r JOIN tabel_penyakit p ON r.kode_penyakit = p.kode_penyakit', (err, rules) => {
        if (err) {
            return res.status(500).send('Error retrieving rules');
        }

        const possibleDiseases = rules.filter(rule => {
            const ruleQuestions = rule.kode_pertanyaan.split(',');
            return ruleQuestions.every(q => userAnswers.includes(q)) && ruleQuestions.length === userAnswers.length;
        });

        res.json(possibleDiseases.map(d => d.nama_penyakit));
        // Debug
        console.log(possibleDiseases);
    });
});

// Endpoint to list symptoms
app.post('/list-symptoms', express.json(), (req, res) => {
    const userSymptoms = req.body.answers;
    // Debug
    console.log(userSymptoms);
    
    connection.query('SELECT t.kode_gejala, g.nama_gejala FROM tabel_pertanyaan t JOIN tabel_gejala g ON t.kode_gejala = g.kode_gejala', (err, symptoms) => {
        if (err) {
            return res.status(500).send('Error retrieving rules');
        }

        const symptomsList = symptoms.filter(symptom => userSymptoms.includes(symptom.kode_gejala));

        res.json(symptomsList.map(s => s.nama_gejala));
        // Debug
        console.log(symptomsList);
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
