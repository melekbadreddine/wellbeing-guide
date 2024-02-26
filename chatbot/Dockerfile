# Use Python base image
FROM python:3.13.0a3-slim AS flask_builder

# Set working directory
WORKDIR /app

# Copy Flask app and requirements file
COPY flask_server.py .
COPY requirements.txt .

# Install Flask dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Flask port
EXPOSE 5000

# Start Flask app
CMD ["python", "flask_server.py"]
