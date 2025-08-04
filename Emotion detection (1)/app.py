from deep_translator import GoogleTranslator
import numpy as np
from flask import Flask, render_template, request, redirect, url_for, session, jsonify, flash
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
import joblib

# Initialize Flask App
app = Flask(__name__)
app.secret_key = 'your_secret_key'
target_language = "en" 
# Load the pre-trained model
pipe_lr = joblib.load(open("./models/emotion_classifier_pipe_lr.pkl", "rb"))

# Database connection
conn = mysql.connector.connect(host="localhost", user="root", password="", database="emotionclass")
cursor = conn.cursor()

# Routes
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        mobile = request.form['mobile']
        password = request.form['password']  # Store password directly (no hashing)

        try:
            cursor.execute("INSERT INTO eusers (username, email, mobile, password) VALUES (%s, %s, %s, %s)",
                           (username, email, mobile, password))
            conn.commit()
            flash("Registration successful! Please log in.")
            return redirect(url_for('login'))
        except mysql.connector.IntegrityError:
            flash('Username or email already exists. Please choose a different one.')
            return redirect(url_for('register'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']  # Plain text password

        cursor.execute("SELECT * FROM eusers WHERE username = %s", (username,))
        user = cursor.fetchone()

        # Direct comparison of plain text password
        if user and user[4] == password:  # user[4] is the password field
            session['user_id'] = user[0]
            session['username'] = user[1]
            session['email'] = user[2]
            session['mobile'] = user[3]
            session.permanent = True
            flash("Login successful!")
            return redirect(url_for('home'))
        else:
            flash('Invalid credentials. Please try again.')
            return redirect(url_for('login'))

    return render_template('login.html')


@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('username', None)
    flash("Logged out successfully!")
    return redirect(url_for('index'))

@app.route('/home')
def home():
    if 'user_id' not in session:
        flash("Please log in to access this page.")
        return redirect(url_for('login'))
    return render_template('home.html')

def predict_emotions(docx):
    results = pipe_lr.predict([docx])
    return results[0]

def get_prediction_proba(docx):
    results = pipe_lr.predict_proba([docx])
    return results

@app.route('/predict', methods=['POST'])
def predict():
    if 'user_id' not in session:
        flash("Please log in to use the prediction feature.")
        return redirect(url_for('login'))

    data = request.json
    text = data['text']
    translated_text = GoogleTranslator(source='auto', target=target_language).translate(text)


    prediction = predict_emotions(translated_text)
    probabilities = get_prediction_proba(translated_text)

    # Round the probabilities using NumPy's round function
    rounded_probabilities = np.round(probabilities, 2)

    # Prepare the response using model-provided classes
    response = {
        "emotion": prediction,
        "probabilities": {emotion: rounded_probabilities[0][i] for i, emotion in enumerate(pipe_lr.classes_)}
    }

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
