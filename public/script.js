let currentStep = 0;
let selectedAnswers = [];
let selectedSymptoms = [];
let questions = [];

// Load questions from server
fetch('/questions')
    .then(response => response.json())
    .then(data => {
        questions = data;
        displayQuestion();
    });

// Display question
function displayQuestion() {
    if (currentStep < questions.length) {
        const questionDiv = document.getElementById('question');
        const choicesDiv = document.getElementById('choices');
        questionDiv.innerHTML = `<h3>${questions[currentStep].pertanyaan}</h3>`;
        choicesDiv.innerHTML = `
            <button onclick="answer(true)">Ya</button>
            <button onclick="answer(false)">Tidak</button>
        `;
    } else {
        listSymptoms()
        diagnose();
    }
}

// Handle answer
function answer(hasSymptom) {
    if (hasSymptom) {
        selectedAnswers.push(questions[currentStep].kode_pertanyaan);
        selectedSymptoms.push(questions[currentStep].kode_gejala);
    }
    currentStep++;
    displayQuestion();
}

// Lists symptoms based on answers
function listSymptoms() {
  fetch('/list-symptoms', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json'
      },
      body: JSON.stringify({ answers: selectedSymptoms })
  })
  .then(response => response.json())
  .then(symptomNames => {
      const symptomsDiv = document.getElementById('symptoms');
      if (symptomNames.length > 0) {
        symptomsDiv.innerHTML = `
        <p>Anda memiliki gejala berikut:</p>
        <ul style="list-style-type:none;">
          ${symptomNames.map(symptom => `<li>${symptom}</li>`).join('')}
        </ul>
        `;
      } else {
        symptomsDiv.textContent = 'Anda tidak memiliki gejala apapun.';
      }
  });
}

// Diagnose based on answers
function diagnose() {
    fetch('/diagnose', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ answers: selectedAnswers })
    })
    .then(response => response.json())
    .then(possibleDiseases => {
        const resultDiv = document.getElementById('result');
        if (possibleDiseases.length > 0) {
            resultDiv.innerHTML = `<p>Anda mungkin menderita penyakit:</p><h2>${possibleDiseases.map(disease => `${disease}`)}</h2>`;
        } else {
            resultDiv.textContent = 'Tidak ada penyakit yang cocok dengan jawaban yang Anda berikan.';
        }
    });
}
