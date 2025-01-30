docker build -t lab1-backend .
docker run -d -p 5000:5000 --env-file .env lab1-backend