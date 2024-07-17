# Use an official Python image as a base
FROM python:3.9-slim

# Set the working directory in the container to /app
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the application code
COPY . .

# Expose the port the application will use
EXPOSE 8080

# Run the command to start the application when the container starts
CMD ["python", "app.py"]