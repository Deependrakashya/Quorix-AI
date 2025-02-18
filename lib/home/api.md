curl -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-pro-exp-02-05:generateContent?key=AIzaSyDXGt9gbIEMY8GG51qOoYaB5PEQEqh1pZM -H 'Content-Type: application/json' -d @<(echo '{
"contents": [
{
"role": "user",
"parts": [
{
"text": "who are you ?"
}
]
}
],
"generationConfig": {
"temperature": 1,
"topK": 64,
"topP": 0.95,
"maxOutputTokens": 8192,
"responseMimeType": "text/plain"
}
}')
