document.getElementById('emotionForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    const text = document.getElementById('text').value;

    const response = await fetch('/predict', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ text })
    });

    const data = await response.json();
    document.getElementById('prediction').innerText = `Prediction: ${data.emotion}`;

    // Display graph with the prediction results
    const values = Object.keys(data.probabilities).map(emotion => ({
        emotion: emotion.charAt(0).toUpperCase() + emotion.slice(1), // Capitalize first letter
        probability: data.probabilities[emotion]
    }));

    vegaEmbed('#graph', {
        "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
        "description": "Emotion prediction graph",
        "width": 500,
        "data": {
            "values": values
        },
        "mark": "bar",
        "encoding": {
            "x": { "field": "emotion", "type": "nominal", "title": "Emotion" },
            "y": { "field": "probability", "type": "quantitative", "title": "Probability" }
        }
    });
});
