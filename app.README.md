Here is a simple Python Flask HTTP "Hello, World!" application:

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

This code creates a Flask application and defines a route for the root URL ("/"). When a request is made to this URL, the function `hello_world` is called, and it returns the string "Hello, World!". The `if __name__ == '__main__':` line is used to start the Flask development server when the script is run directly.
