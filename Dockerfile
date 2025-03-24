FROM node:18-alpine

WORKDIR /app

# Copiar arquivos de configuração primeiro
COPY package*.json ./
COPY tsconfig.json ./
COPY .env ./

# Instalar todas as dependências (incluindo devDependencies)
RUN npm install

# Copiar o código fonte
COPY src/ ./src/

# Compilar o TypeScript
RUN npm run build

# Remover dependências de desenvolvimento
RUN npm prune --production

EXPOSE 8080

CMD ["node", "dist/index.js"] 