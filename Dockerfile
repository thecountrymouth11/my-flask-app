# Use a lightweight Python 3.9 image
FROM python:3.9-slim

# Set the working directory inside the contsiner
WORKDIR /app

# Copy requirements.txt before the full app to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
