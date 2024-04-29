# Utilisation de l'image Node.js Alpine à partir des registres d'images.
FROM node:14-alpine AS base

# Définition du répertoire dans le conteneur à /app pour stocker les fichiers et lancer notre application.
WORKDIR /app

# Copie du fichier package.json dans le répertoire /app avec ses dépendances.
COPY package.json /app

# Installation des dépendances de l'application.
RUN npm install

# Copie du reste de l'application dans le répertoire /app.
COPY . /app

RUN npm run build

# Second Stage: Run Application

FROM node:14-slim AS production
WORKDIR /app
COPY --from=base /app .

EXPOSE 3000

# Commande pour exécuter notre application, qui est index.js.
CMD node app.js
